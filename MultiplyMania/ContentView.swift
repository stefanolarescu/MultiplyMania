//
//  ContentView.swift
//  MultiplyMania
//
//  Created by Stefan Olarescu on 17.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 1
    @State private var numberOfQuestions = 5
    
    @State private var hasStartedGame = false
    @State private var question = ""
    @State private var numberOfQuestionsAsked = Int.zero
    
    @State private var answer = ""
    
    private let questionsCounts = [5, 10, 20]
    
    private let questionFormat = "What is %@ times %@?"
    
    var body: some View {
        NavigationView {
            Form {
                if hasStartedGame {
                    Section("Question #\(numberOfQuestionsAsked)") {
                        Text(question)
                        
                        TextField("Answer:", text: $answer)
                            .keyboardType(.numberPad)
                            .onChange(of: answer) { newValue in
                                answer = newValue.filter { $0.isNumber }
                            }
                    }
                    
                    Section {
                        Button(numberOfQuestionsAsked == numberOfQuestions ? "Finish" : "Next") {
                            askQuestion()
                        }
                        .disabled(answer.isEmpty)
                    }
                } else {
                    Section("Settings") {
                        Stepper(
                            "Multiplication table: \(multiplicationTable)",
                            value: $multiplicationTable,
                            in: 1...10
                        )
                        
                        Picker(
                            "Number of questions",
                            selection: $numberOfQuestions,
                            content: {
                                ForEach(questionsCounts, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                        )
                    }
                    
                    Section {
                        Button("Start") {
                            hasStartedGame = true
                            
                            askQuestion()
                        }
                    }
                }
            }
            .navigationTitle("Multiply Mania")
        }
    }
    
    private func askQuestion() {
        if numberOfQuestionsAsked == numberOfQuestions {
            hasStartedGame = false
            numberOfQuestionsAsked = .zero
        } else {
            question = String(format: questionFormat, "\(multiplicationTable)", "\(Int.random(in: 1...10))")
            numberOfQuestionsAsked += 1
        }
    }
}

#Preview {
    ContentView()
}
