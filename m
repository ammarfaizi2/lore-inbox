Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTFDRfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTFDRfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:35:54 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:32526 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S263705AbTFDRfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:35:50 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Wed, 4 Jun 2003 19:49:19 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: 2.4.21-rc7 ACPI broken
Message-ID: <Pine.OSF.4.51.0306041935090.234869@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just tried on ASUS 3800C laptop the new kernel and see:


 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:....................................................................................................
....................................................................................................................
......................................
254 Control Methods found and parsed (769 nodes total)
ACPI Namespace successfully loaded at root c0428e00
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-25] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.......................evregion-0302 [-7] Ev_address_space_dispa: Region handler: AE_E
RROR [PCIConfig]
 dswexec-0392 [-16] Ds_exec_end_op        : [Store]: Could not resolve operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.PCI2.CB0_._INI (f7eaea28)
  nsinit-0351 [-23] Ns_init_one_device    : \   /_SB_PCI0PCI2CB0_._INI failed: AE_ERROR
.evregion-0302 [-7] Ev_address_space_dispa: Region handler: AE_ERROR [PCIConfig]
 dswexec-0392 [-16] Ds_exec_end_op        : [Store]: Could not resolve operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.PCI2.CB1_._INI (f7eaee28)
  nsinit-0351 [-23] Ns_init_one_device    : \   /_SB_PCI0PCI2CB1_._INI failed: AE_ERROR
....................................
60 Devices found: 60 _STA, 3 _INI
Completing Region and Field initialization:..................
18/26 Regions, 0/0 Fields initialized (769 nodes total)
ACPI: Subsystem enabled
Power Resource: found
EC: found, GPE 28
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
ectransx-0199 [01] ec_read               : Unable to send 'read command' to EC.
evregion-0302 [-2] Ev_address_space_dispa: Region handler: AE_TIME [Embedded_control]
 dswexec-0392 [-11] Ds_exec_end_op        : [LAnd]: Could not resolve operands, AE_TIME
Ps_execute: method failed - \_SB_.BAT0._BIF (f7ebff28)
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
ACPI: Thermal Zone found
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
tzpolicy-0255 [-20] tz_policy_active      : Unable to turn ON cooling device [00].
PCI: Found IRQ 5 for device 01:00.0
PCI: Sharing IRQ 5 with 00:1d.0
PCI: Sharing IRQ 5 with 02:07.0
radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
[...]
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status timeout: status=0xd0 { Busy }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04 { DriveStatusError }
ide0: reset: master: ECC circuitry error




# lspci -n -v
00:00.0 Class 0600: 8086:1a30 (rev 04)
        Subsystem: 1043:1626
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0

00:01.0 Class 0604: 8086:1a31 (rev 04)
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7000000-d7efffff
        Prefetchable memory behind bridge: d7f00000-dfffffff

00:1d.0 Class 0c03: 8086:2482 (rev 02)
        Subsystem: 1043:1628
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at b800 [size=32]

00:1d.1 Class 0c03: 8086:2484 (rev 02)
        Subsystem: 1043:1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b400 [size=32]

00:1e.0 Class 0604: 8086:2448 (rev 42)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: d6000000-d6ffffff

00:1f.0 Class 0601: 8086:248c (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 Class 0101: 8086:248a (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: 1043:1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8400 [size=16]
        Memory at d5800000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Class 0401: 8086:2485 (rev 02)
        Subsystem: 1043:1583
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

00:1f.6 Class 0703: 8086:2486 (rev 02)
        Subsystem: 1043:1496
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]

01:00.0 Class 0300: 1002:4c57
        Subsystem: 1043:1622
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ
5
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:05.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 1043:1045
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a800 [size=256]
        Memory at d6800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:07.0 Class 0607: 1180:0476 (rev a8)
        Subsystem: 1043:1624
        Flags: bus master, medium devsel, latency 168, IRQ 5
        Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=02, subordinate=03, sec-latency=176
        Memory window 0: 40400000-407ff000 (prefetchable)
        Memory window 1: 40800000-40bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001

02:07.1 Class 0607: 1180:0476 (rev a8)
        Subsystem: 1043:1624
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at 40001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: 40c00000-40fff000 (prefetchable)
        Memory window 1: 41000000-413ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        16-bit legacy interface ports at 0001

02:07.2 Class 0c00: 1180:0552 (prog-if 10)
        Subsystem: 1043:1627
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

# lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 04)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
(rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7
LW [Radeon Mobility 7500]
02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
#


I suspect there's something wrong compared to 2.4.21-rc2-ac2 which I used till now.

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
