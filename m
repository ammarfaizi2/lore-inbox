Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTILPdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbTILPdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:33:02 -0400
Received: from ozone.tzone.org ([209.104.74.2]:39889 "EHLO OZoNE.TZoNE.ORG")
	by vger.kernel.org with ESMTP id S261724AbTILPc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:32:57 -0400
From: Francis Provencher <darkfox@TZoNE.ORG>
Date: Fri, 12 Sep 2003 11:32:55 -0400
To: linux-kernel@vger.kernel.org
Subject: The boot process freeze when using ACPI for PCI on Toshiba 5200
Message-ID: <20030912153255.GK22380@OZoNE.TZoNE.ORG>
References: <20030912133626.GH22380@OZoNE.TZoNE.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912133626.GH22380@OZoNE.TZoNE.ORG>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Toshiba 5200 doesn't have any bios, so it is up to the ACPI to
configure the IRQ for some of the PCI cards on the system (including
modem, audio and possibly pcmcia).

I am using Linux 2.4.22 and when I boot the booting process STOP
(doesn't do anything) after the line:

PCI: Enabling device 00:1f.6 (0000 -> 0001)

If I put pci=noacpi in my kernel parameters, I am able to boot, but then
my pci cards are assigned to IRQ 0.

Here is my lspci (using pci=noacpi):
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 04)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M)
(rev 42)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 248c (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 248a (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. AC'97 Audio Controller
(rev 02)
00:1f.6 Modem: Intel Corp.: Unknown device 2486 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
031a (rev a1)
02:06.0 USB Controller: NEC Corporation USB (rev 41)
02:06.1 USB Controller: NEC Corporation USB (rev 41)
02:06.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02)
02:07.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset
Ethernet Controller (rev 42)
02:0a.0 Ethernet controller: Unknown device 168c:0012 (rev 01)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 33)
02:0d.0 System peripheral: Toshiba America Info Systems: Unknown device
0805 (rev 05)

here is my dmesg | grep ACPI (using pci=noacpi):
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 000000001ffd0000 - 000000001ffe0000 (ACPI data)
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 TOSHIB                                    ) @
0x000f0180
ACPI: RSDT (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @
0x1ffd0000
ACPI: FADT (v002 TOSHIB 5200     0x20021230 TASM 0x04010000) @
0x1ffd0058
ACPI: DBGP (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @
0x1ffd00dc
ACPI: BOOT (v001 TOSHIB 5200     0x20030327 TASM 0x04010000) @
0x1ffd0030
ACPI: DSDT (v001 TOSHIB 5200     0x20030327 MSFT 0x0100000a) @
0x00000000
ACPI: MADT not present
ACPI: Subsystem revision 20030813
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
ACPI Namespace successfully loaded at root c038041c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 6 7 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
ACPI: Thermal Zone [THRM] (61 C)

here is my dmesg | grep PCI (using pci=noacpi):
PCI: PCI BIOS revision 2.10 entry at 0xfcf0c, last bus=4
PCI: Using configuration type 1
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 6 7 10 11 12)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
PCI: Enabling device 00:1f.6 (0000 -> 0001)
PCI: No IRQ known for interrupt pin B of device 00:1f.6. Please try
using pci=biosirq.
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 02:06.2 (0000 -> 0002)
PCI: No IRQ known for interrupt pin C of device 02:06.2. Please try
using pci=biosirq.
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 02:06.2 setup!
PCI: Enabling device 00:1f.5 (0000 -> 0001)
PCI: No IRQ known for interrupt pin B of device 00:1f.5. Please try
using pci=biosirq.
PCI: Setting latency timer of device 00:1f.5 to 64

Any idea anyone?

-Francis
-- 
Francis Provencher <darkfox@TZoNE.ORG>
"What if the bird will not sing?"
