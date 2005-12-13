Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVLMWfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVLMWfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVLMWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:35:34 -0500
Received: from kestrel.astro.umass.edu ([128.119.51.84]:30120 "EHLO
	kestrel.astro.umass.edu") by vger.kernel.org with ESMTP
	id S1030306AbVLMWfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:35:33 -0500
To: linux-kernel@vger.kernel.org
Cc: weinberg@astro.umass.edu
Subject: 2.6.15-rc5 makes tons of: <NULL>: hw csum failure
Message-Id: <E1EmIk7-0004Ua-00@kestrel.astro.umass.edu>
From: "Martin D. Weinberg" <weinberg@kestrel.astro.umass.edu>
Date: Tue, 13 Dec 2005 17:35:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Kernel errors as follows: <NULL>: hw csum failure, seemingly from the
   sk98lin module

2. These appear quite often.  The system continues to run.  Disconnecting
   the cat5 stops the messages.  This system is dual homed.  The other nic
   is an onboard DP83820.  This is an IWILL DK8X main board.

5. My previous kernel was 2.6.14 which did not have this bug.

6. Example:

<NULL>: hw csum failure.
 [<c02fc046>] csum_partial_copy_to_xdr+0x126/0x160
 [<c02fbca0>] skb_read_and_csum_bits+0x0/0xa0
 [<c02fcb05>] xs_udp_data_ready+0xe5/0x1b0
 [<c02e1d76>] udp_queue_rcv_skb+0x156/0x200
 [<c02e22c6>] udp_rcv+0x146/0x3d0
 [<c02c25d0>] ip_defrag+0x110/0x1d0
 [<c02c1187>] ip_local_deliver+0x97/0x170
 [<c02c14b8>] ip_rcv+0x258/0x4a0
 [<f8a1c629>] FillRxDescriptor+0x39/0xd0 [sk98lin]
 [<c02abfe5>] netif_receive_skb+0x145/0x1c0
 [<c02ac0e2>] process_backlog+0x82/0x110
 [<c02ac1e7>] net_rx_action+0x77/0x100
 [<c0121485>] __do_softirq+0xc5/0xe0
 [<c01214d2>] do_softirq+0x32/0x40
 [<c010531e>] do_IRQ+0x1e/0x30
 [<c0103a26>] common_interrupt+0x1a/0x20
 [<c0100de3>] default_idle+0x33/0x60
 [<c0100ea2>] cpu_idle+0x72/0x80
 [<c03ca96c>] start_kernel+0x15c/0x180
 [<c03ca380>] unknown_bootoption+0x0/0x1b0

 
Linux kestrel 2.6.15-rc5 #1 SMP Mon Dec 12 12:06:48 EST 2005 i686 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           1.0.4
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         reiserfs uhci_hcd ehci_hcd ohci_hcd st aic7xxx scsi_transport_spi radeon parport_pc parport ohci1394 ieee1394 ns83820 ext3 jbd raid5 xor md_mod 3w_xxxx sk98lin

lspci -vvv output:

0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 13)
	Subsystem: Advanced Micro Devices [AMD] AMD-8151 System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00006000-00008fff
	Memory behind bridge: dd400000-dd4fffff
	Prefetchable memory behind bridge: dea00000-ee9fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: dd500000-dd5fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
	Subsystem: Iwill Corp: Unknown device 0045
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at c800 [size=256]
	Region 1: I/O ports at cc00 [size=64]

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dd600000-dd7fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at de9ff000 (64-bit, non-prefetchable) [size=4K]

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: dd800000-de8fffff
	Prefetchable memory behind bridge: 00000000eea00000-00000000eea00000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at de9fe000 (64-bit, non-prefetchable) [size=4K]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 8500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 8000 [size=256]
	Region 2: Memory at dd4f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dd4c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at dd5fe000 (32-bit, non-prefetchable) [size=4K]

0000:02:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at dd5ff000 (32-bit, non-prefetchable) [size=4K]

0000:02:05.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2750ns min, 13000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at 9800 [size=256]
	Region 1: Memory at dd5fd000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dd5e0000 [disabled] [size=64K]

0000:02:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at dd5fc800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at dd5f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

0000:02:07.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dd5f6000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:02:07.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at dd5f7000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at dd5fc400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:03:03.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
	Subsystem: Iwill Corp: Unknown device 0047
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dd7f8000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at a000 [size=256]
	Expansion ROM at dd7c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:03:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at a880 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a480 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Region 5: Memory at dd7ffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at dd700000 [disabled] [size=512K]
	Capabilities: <available only to root>

0000:04:01.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 17
	BIST result: 00
	Region 0: I/O ports at b800 [disabled] [size=256]
	Region 1: Memory at de8ff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at de8c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:04:02.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
	Subsystem: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at bc00 [size=16]
	Region 1: Memory at de8fec00 (32-bit, non-prefetchable) [size=16]
	Region 2: Memory at de000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at de8e0000 [disabled] [size=64K]
	Capabilities: <available only to root>

HTH!!

--Martin
