import AppIntents

struct GetBatteryState: AppIntent, CustomIntentMigratedAppIntent {
	static let intentClassName = "GetBatteryStateIntent"

	static let title: LocalizedStringResource = "Get Battery State"

	static let description = IntentDescription(
		"Returns whether the device's battery is unplugged, charging, or full.",
		categoryName: "Device"
	)

	@Parameter(title: "State", default: .charging)
	var state: BatteryStateTypeAppEnum

	static var parameterSummary: some ParameterSummary {
		Summary("Is the battery \(\.$state)?")
	}

	func perform() async throws -> some IntentResult & ReturnsValue<Bool> {
		let result = {
			switch state {
			case .unplugged:
				return Device.batteryState == .unplugged
			case .charging:
				return Device.batteryState == .charging
			case .full:
				return Device.batteryState == .full
			}
		}()

		return .result(value: result)
	}
}

enum BatteryStateTypeAppEnum: String, AppEnum {
	case unplugged
	case charging
	case full

	static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Battery State Type")

	static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.unplugged: "unplugged",
		.charging: "charging",
		.full: "full"
	]
}
