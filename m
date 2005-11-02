Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVKBNW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVKBNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVKBNW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:22:59 -0500
Received: from [85.8.13.51] ([85.8.13.51]:29077 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964974AbVKBNW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:22:58 -0500
Message-ID: <4368BDA7.6060401@drzeus.cx>
Date: Wed, 02 Nov 2005 14:22:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: swsusp not able to stop tasks
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problem with swsusp in the recent kernels (somewhere around 
the late 2.6.14 rc:s). It says it cannot suspend all tasks:

[ 7221.993472] ehci_hcd 0000:00:1d.7: remove, state 1
[ 7221.993656] usb usb1: USB disconnect, address 1
[ 7222.043455] ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
[ 7222.057147] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[ 7222.118871] uhci_hcd 0000:00:1d.2: remove, state 1
[ 7222.119060] usb usb4: USB disconnect, address 1
[ 7222.120849] uhci_hcd 0000:00:1d.2: USB bus 4 deregistered
[ 7222.121875] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[ 7222.122053] uhci_hcd 0000:00:1d.1: remove, state 1
[ 7222.122197] usb usb3: USB disconnect, address 1
[ 7222.177656] uhci_hcd 0000:00:1d.1: USB bus 3 deregistered
[ 7222.193209] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[ 7222.193397] uhci_hcd 0000:00:1d.0: remove, state 1
[ 7222.193494] usb usb2: USB disconnect, address 1
[ 7222.238614] uhci_hcd 0000:00:1d.0: USB bus 2 deregistered
[ 7222.252926] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[ 7222.858099] PM: suspend-to-disk mode set to 'platform'
[ 7223.525225] Stopping tasks: 
=======================================================================================================================================
[ 7229.532506]  stopping tasks failed (1 tasks remaining)
[ 7229.532529] Restarting tasks...<6> Strange, kauditd not stopped
[ 5422.163830]  done
[ 2711.145009] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 
5 (level, low) -> IRQ 5
[ 2711.145149] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[ 2711.145183] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[ 2711.145228] ehci_hcd 0000:00:1d.7: debug port 1
[ 2711.148734] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned 
bus number 1
[ 2711.148873] ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
[ 2711.148923] PCI: cache line size of 32 is not supported by device 
0000:00:1d.7
[ 2711.152855] ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, 
driver 10 Dec 2004
[ 2711.155516] hub 1-0:1.0: USB hub found
[ 2711.155610] hub 1-0:1.0: 6 ports detected
[ 2711.520868] USB Universal Host Controller Interface driver v2.3
[ 2711.522329] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 
10 (level, low) -> IRQ 10
[ 2711.522436] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[ 2711.522469] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[ 2711.523737] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 2
[ 2711.523821] uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
[ 2711.526128] hub 2-0:1.0: USB hub found
[ 2711.526214] hub 2-0:1.0: 2 ports detected
[ 2711.631308] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 
5 (level, low) -> IRQ 5
[ 2711.631438] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[ 2711.631471] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[ 2711.632744] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 3
[ 2711.632826] uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
[ 2711.635127] hub 3-0:1.0: USB hub found
[ 2711.635211] hub 3-0:1.0: 2 ports detected
[ 2711.739199] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 
5 (level, low) -> IRQ 5
[ 2711.739337] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[ 2711.739371] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[ 2711.740700] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 4
[ 2711.740789] uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
[ 2711.743189] hub 4-0:1.0: USB hub found
[ 2711.743280] hub 4-0:1.0: 2 ports detected
[ 2711.870191] ACPI: Power Button (FF) [PWRF]
[ 2711.870350] ACPI: Power Button (CM) [C1BE]
[ 2711.870393] ACPI: Lid Switch [C136]

The TSC counter is behaving very strangely aswell, as you can see, so it 
seems to be doing something low-level.

Some late addition (post 2.6.14) also makes my keyboard crap out after 
one of these cycles. Not sure it the TSC funkiness was present before this.

Any ideas or is it time to start bisecting?

Rgds
Pierre
