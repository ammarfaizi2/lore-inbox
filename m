Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136441AbRD3Cy7>; Sun, 29 Apr 2001 22:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135477AbRD3Cyu>; Sun, 29 Apr 2001 22:54:50 -0400
Received: from cc1020302-a.sumt1.nj.home.com ([24.3.184.188]:1797 "EHLO
	shakti.sivalik.com") by vger.kernel.org with ESMTP
	id <S136441AbRD3Cyd>; Sun, 29 Apr 2001 22:54:33 -0400
To: linux-kernel@vger.kernel.org
Subject: v2.4.4 PCI IRQ 0 / help wanted
From: Narang <narang@home.com>
Date: 29 Apr 2001 22:54:30 -0400
Message-ID: <871yqbf66x.fsf@shakti.sivalik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

. If a device is not found by BIOS can it still be used?
. Why is the USB device getting IRQ 0?
. Why is the Firewire device 8020 unknown?

Attached is output of lspci, syslog, and output of lspci -vv.

Hoping I can get some help. Please CC me any suggestions. Thanks.

lspci
--------

00:00.0 Host bridge: VLSI Technology Inc 82C592-FC1 (rev 01)
00:01.0 ISA bridge: VLSI Technology Inc 82C593-FC1 (rev 01)
00:0d.0 IDE interface: CMD Technology Inc PCI0640 (rev 02)
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:12.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10]
01:04.0 USB Controller: CMD Technology Inc USB0670 (rev 06)
>>>>> 01:05.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020

>From syslog
-----------

Apr 29 17:56:03 shakti kernel: PCI: PCI BIOS revision 2.00 entry at 0xfc9bb, last bus=0
Apr 29 17:56:03 shakti kernel: PCI: Using configuration type 1
Apr 29 17:56:03 shakti kernel: PCI: Probing PCI hardware
Apr 29 17:56:03 shakti kernel: Unknown bridge resource 0: assuming transparent
Apr 29 17:56:03 shakti kernel: Unknown bridge resource 1: assuming transparent
Apr 29 17:56:03 shakti kernel: Unknown bridge resource 2: assuming transparent
>>>>> Apr 29 17:56:03 shakti kernel: PCI: Device 01:20 not found by BIOS
>>>>> Apr 29 17:56:03 shakti kernel: PCI: Device 01:28 not found by BIOS
...
Apr 29 17:56:06 shakti kernel: usb.c: registered new driver usbdevfs
Apr 29 17:56:06 shakti kernel: usb.c: registered new driver hub
>>>>> Apr 29 17:56:06 shakti kernel: PCI: No IRQ known for interrupt pin A of device 01:04.0. Please try using pci=biosirq.
Apr 29 17:56:06 shakti kernel: PCI: Setting latency timer of device 01:04.0 to 64
Apr 29 17:56:06 shakti kernel: usb-ohci.c: USB OHCI at membase 0xc8917000, IRQ 0
Apr 29 17:56:06 shakti kernel: usb-ohci.c: usb-01:04.0, CMD Technology Inc USB0670
Apr 29 17:56:08 shakti kernel: usb-ohci.c: USB HC TakeOver failed!
Apr 29 17:56:08 shakti kernel: usb.c: USB bus -1 deregistered
Apr 29 17:56:08 shakti kernel: usb.c: deregistering driver usbdevfs
Apr 29 17:56:08 shakti kernel: usb.c: deregistering driver hub

lspci -vv
---------

00:00.0 Host bridge: VLSI Technology Inc 82C592-FC1 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 16

00:01.0 ISA bridge: VLSI Technology Inc 82C593-FC1 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0d.0 IDE interface: CMD Technology Inc PCI0640 (rev 02) (prog-if 0a [SecP PriP])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14

00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00000000-00000fff
	Memory behind bridge: 00000000-000fffff
	Prefetchable memory behind bridge: 0000000000000000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:11.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 20000000 [disabled] [size=64K]

00:12.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240, cache line size 04
	Interrupt: pin C routed to IRQ 15
	Region 0: I/O ports at fcfc [size=4]
	Expansion ROM at ff000000 [disabled] [size=16K]

01:04.0 USB Controller: CMD Technology Inc USB0670 (rev 06) (prog-if 10 [OHCI])
	Subsystem: CMD Technology Inc USB0670
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

01:05.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at 10004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

