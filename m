Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271037AbTHGWVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTHGWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:20:59 -0400
Received: from vitelus.com ([64.81.243.207]:18614 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S271037AbTHGWU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:20:57 -0400
Date: Thu, 7 Aug 2003 15:17:11 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI is shutting down my laptop spontaneously
Message-ID: <20030807221711.GO2712@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded my laptop to 2.6 yesterday from a late 2.4 kernel. I had
always used APM, and thought this would be a good time to try ACPI. It
seems to do basically what APM did (show me the battery level,
basically) with a lot more complexity. The only problem that I've had
is that ACPI shuts the machine off when it's under heavy load.

I've run distributed computing clients when connected to AC power
ever since I got the laptop. It used to always run at full speed.
Since the beginning of the summer, computations would really slow down
once the machine heated up. A loop which took 50ms per iteration would
slow down to 110-120ms after ten minutes. I'm not sure whether it was
the summer heat or just poor design of the laptop. Since Dell stuck a
desktop P4 in it, I wouldn't be surprised at the latter. Anyway,
unless I mount the laptop specially and point a huge fan at it, it
will slow down significantly when I load it heavily.

...Until I upgraded to 2.6.0-test2 and enabled ACPI. At the point
where the CPU speed would have been scaled down before, the laptop
simply halts, giving no warning except announcing it to every
terminal. I don't like the way my laptop throttles the CPU speed to
prevent overheating, but it's better than shutting down to prevent it.
Is there any way to make ACPI throttle the clockspeed, which was
presumably being done by the BIOS when I had APM enabled? For now I've
switched back to APM and it's working fine. I have CPUFreq support
enabled in the kernel.

Here is the ACPI information from the log:

ACPI: RSDP (v000 Acer) @ 0x000fe030
ACPI: RSDT (v001 Acer   TMH2
ACPI: FADT (v001 Acer   TMH2 00000.00001) @ 0x0ffe0054
ACPI: BOOT (v001 Acer   TMH2 00000.00001) @ 0x0ffe002c
ACPI: DSDT (v001    H2       H2 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
...
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp.  82801BA/CA/DB PCI Br
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Kernel Card Services 3.1.22
options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try
using option 'pci=noacpi' or even 'acpi=off'
...
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THR1] (51 C)
ACPI: Thermal Zone [THR2] (51 C)
