//
//  ComplicationSampleAppWidgetExtension.swift
//  ComplicationSampleAppWidgetExtension
//
//  Created by  on 2025/03/03.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "Sample")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), text: "Snapshot")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entries = [
            SimpleEntry(date: Date(), text: "Now"),
            SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 1, to: Date())!, text: "1 min"),
            SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 2, to: Date())!, text: "2 min"),
            SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 3, to: Date())!, text: "3 min"),
            SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 4, to: Date())!, text: "4 min"),
            SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 5, to: Date())!, text: "5 min")
                ]

        return Timeline(entries: entries, policy: .atEnd)
    }

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct ComplicationSampleAppWidgetExtensionEntryView : View {
    var entry: SimpleEntry
    var body: some View {
        Text(entry.text)
            .font(.system(size: 12))
            .minimumScaleFactor(0.5)
    }
}

@main
struct ComplicationSampleAppWidgetExtension: Widget {
    let kind: String = "ComplicationSampleAppWidgetExtension"

    var body: some WidgetConfiguration {
        
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ComplicationSampleAppWidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Complication")
        .description("This is a sample complication.")
        .supportedFamilies([
            .accessoryCircular,    // 丸型
            .accessoryInline,      // テキストのみ
            .accessoryRectangular  // 長方形
        ])
    }
}


