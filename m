Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbTFCBqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 21:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFCBqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 21:46:34 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:46721 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264866AbTFCBqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 21:46:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Grover, Andrew" <andrew.grover@intel.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Date: Tue, 3 Jun 2003 12:01:09 +1000
User-Agent: KMail/1.5.1
Cc: "Paul P Komkoff Jr" <i@stingr.net>, <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A84725A2CC@orsmsx401.jf.intel.com> <200306031012.07832.kernel@kolivas.org>
In-Reply-To: <200306031012.07832.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031201.09642.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 10:12, Con Kolivas wrote:
> On Tue, 3 Jun 2003 07:01, Grover, Andrew wrote:
> > I suspect this machine should be falling into one of the cases before
> > this last one, thus making ACPI not use C3, or check for bus-mastering.
> > I especially think this is the case because this appears to be a desktop
> > system. It should not have a C3 address or a plvl3_lat less than 1000,
> > yet it appears to, yes?
>
> Sorry Andy I have no idea what you're talking about. Are there some details
> specifically about this machine you want me to provide?

At least I can provide you with the acpi info from dmesg when it booted, and 
I'll try Zwane's hack in the near future to see if it helps.

Jun  1 16:32:45 localhost kernel: ACPI: Interpreter enabled
Jun  1 16:32:45 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Jun  1 16:32:45 localhost kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 
6 7 9 10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 
6 7 *9 10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 
6 7 *9 10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 
6 7 *9 10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 
6 7 9 *10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 
6 7 *9 10 11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 
6 7 9 10 11 12 14 15, disabled)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 
6 7 9 10 *11 12 14 15)
Jun  1 16:32:45 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun  1 16:32:45 localhost kernel: PCI: Probing PCI hardware (bus 00)
Jun  1 16:32:45 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller 
00:1f.1
Jun  1 16:32:45 localhost kernel: Transparent bridge - Intel Corp. 
82801BA/CA/DB PCI Bridge
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.PCI1._PRT]
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.PCI2._PRT]
Jun  1 16:32:45 localhost kernel: PCI: Probing PCI hardware
Jun  1 16:32:45 localhost kernel: ACPI: PCI Interrupt Link [LNKG] enabled at 
IRQ 11
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 
0xb1 -> IRQ 16)
Jun  1 16:32:45 localhost kernel: 00:00:1d[A] -> 2-16 -> IRQ 16
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 
0xb9 -> IRQ 19)
Jun  1 16:32:45 localhost kernel: 00:00:1d[B] -> 2-19 -> IRQ 19
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 
0xc1 -> IRQ 18)
Jun  1 16:32:45 localhost kernel: 00:00:1d[C] -> 2-18 -> IRQ 18
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 
0xc9 -> IRQ 23)
Jun  1 16:32:45 localhost kernel: 00:00:1d[D] -> 2-23 -> IRQ 23
Jun  1 16:32:45 localhost kernel: Pin 2-18 already programmed
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 
0xd1 -> IRQ 17)
Jun  1 16:32:45 localhost kernel: 00:00:1f[B] -> 2-17 -> IRQ 17
Jun  1 16:32:45 localhost kernel: Pin 2-16 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-17 already programmed
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 
0xd9 -> IRQ 21)
Jun  1 16:32:45 localhost kernel: 00:02:09[A] -> 2-21 -> IRQ 21
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 
0xe1 -> IRQ 20)
Jun  1 16:32:45 localhost kernel: 00:02:09[D] -> 2-20 -> IRQ 20
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-20 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-21 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-20 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-21 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-20 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-21 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-21 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-20 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-18 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-19 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-16 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-17 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-20 already programmed
Jun  1 16:32:45 localhost kernel: Pin 2-23 already programmed
Jun  1 16:32:45 localhost kernel: PCI: Using ACPI for IRQ routing
Jun  1 16:32:45 localhost kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi
=off'
Jun  1 16:32:45 localhost kernel: Linux NET4.0 for Linux 2.4
Jun  1 16:32:45 localhost kernel: Based upon Swansea University Computer 
Society NET3.039
Jun  1 16:32:45 localhost kernel: Initializing RT netlink socket
Jun  1 16:32:45 localhost kernel: Starting kswapd
Jun  1 16:32:45 localhost kernel: devfs: v1.12c (20020818) Richard Gooch 
(rgooch@atnf.csiro.au)
Jun  1 16:32:45 localhost kernel: devfs: boot_options: 0x1
Jun  1 16:32:45 localhost kernel: ACPI: Power Button (FF) [PWRF]
Jun  1 16:32:45 localhost kernel: ACPI: Processor [CPU0] (supports C1)
Jun  1 16:32:45 localhost kernel: ACPI: Processor [CPU1] (supports C1)


Con
