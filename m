Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUGNS3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUGNS3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUGNS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:29:34 -0400
Received: from [208.223.9.37] ([208.223.9.37]:36111 "EHLO maestro.symsys.com")
	by vger.kernel.org with ESMTP id S265148AbUGNS3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:29:09 -0400
Date: Wed, 14 Jul 2004 13:29:07 -0500 (CDT)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: vaio preempt + acpi ac/battery trouble
Message-ID: <Pine.LNX.4.44.0407141306240.16050-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentlemen,

On my Sony Vaio PCG-FXA32, I seem to have some trouble between ACPI and a
preemptible kernel.  The trouble generates messages about the time the
battery module loads.  We see a bunch of:

    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL

The real problem is that the AC Adaptor status is wrong.  The preempt
kernel always thinks the AC is off-line.

The only thing different in the configs is enabling preempt, though a diff
does show one other setting:

	# cd /usr/src/linux-2.6
	# diff production/.config preempt/.config
	97c97
	< # CONFIG_PREEMPT is not set
	---
	> CONFIG_PREEMPT=y
	119a120
	> CONFIG_HAVE_DEC_LOCK=y

I've tried to include only ACPI and power-related dmesg output below.
Full dmesg output is available here:

	http://www.symsys.com/~ingram/sony/production
	http://www.symsys.com/~ingram/sony/preempt

Any clues for better tracking down the problem?

Regards,

- Greg



Messages from non-preemptible kernel:

ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7710
ACPI: RSDT (v001 SONY   K5       0x06040000  LTP 0x00000000) @ 0x0bef9a91
ACPI: FADT (v001 SONY   K5       0x06040000 PTL_ 0x000f4240) @ 0x0befee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0befeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0befeee8
ACPI: DSDT (v001  SONY  K5       0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PCR1] (off)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: FSB:  99.998 MHz
powernow: Found PSB header at c00f75e0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:12 (@c00f76c0)
powernow:  cpuid: 0x770	fsb: 100	maxFID: 0xc	startvid: 0xb
powernow:    FID: 0x5 (5.5x [549MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x7 (6.5x [649MHz])	VID: 0x11 (1.250V)
powernow:    FID: 0x8 (7.0x [699MHz])	VID: 0xe (1.300V)
powernow:    FID: 0xa (8.0x [799MHz])	VID: 0xc (1.400V)
powernow:    FID: 0xc (9.0x [899MHz])	VID: 0xb (1.450V)
powernow: SGTC: 10000
powernow: Minimum speed 549 MHz. Maximum speed 899 MHz.
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery present)
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Thermal Zone [THRM] (52 C)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.

-------------------------------------------------------------------------

Messages from non-preemptible kernel:

ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7710
ACPI: RSDT (v001 SONY   K5       0x06040000  LTP 0x00000000) @ 0x0bef9a91
ACPI: FADT (v001 SONY   K5       0x06040000 PTL_ 0x000f4240) @ 0x0befee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0befeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0befeee8
ACPI: DSDT (v001  SONY  K5       0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PCR1] (off)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: FSB: 100.045 MHz
powernow: Found PSB header at c00f75e0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:12 (@c00f76c0)
powernow:  cpuid: 0x770	fsb: 100	maxFID: 0xc	startvid: 0xb
powernow:    FID: 0x5 (5.5x [550MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x7 (6.5x [650MHz])	VID: 0x11 (1.250V)
powernow:    FID: 0x8 (7.0x [700MHz])	VID: 0xe (1.300V)
powernow:    FID: 0xa (8.0x [800MHz])	VID: 0xc (1.400V)
powernow:    FID: 0xc (9.0x [900MHz])	VID: 0xb (1.450V)
powernow: SGTC: 10000
powernow: Minimum speed 550 MHz. Maximum speed 900 MHz.
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [BAT1] (battery present)
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.PIB_.EC0_._Q20] (Node cbeb6388), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [BAT2] (battery present)
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Thermal Zone [THRM] (59 C)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.

