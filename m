Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSHCR0l>; Sat, 3 Aug 2002 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSHCR0l>; Sat, 3 Aug 2002 13:26:41 -0400
Received: from mail.hometree.net ([212.34.181.120]:23755 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S317619AbSHCR0j>; Sat, 3 Aug 2002 13:26:39 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Linux 2.4.19-rc5-ac1 and Intel SCB2 (OSB5) trouble
Date: Sat, 3 Aug 2002 17:30:10 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aih3v2$11l$1@forge.intermeta.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1028395810 11589 212.34.181.4 (3 Aug 2002 17:30:10 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 3 Aug 2002 17:30:10 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a new Intel SR1200 server and wanted to install Linux on it.
Unfortunately, the customer ordered the ATA variant of this machine
and I got a box with an Serverworks OSB5 chipset and an onboard
Promise FastTrak 100 controller. 

I fetched 2.4.19-rc5-ac1 and did all my tests with this kernel.

The problem is: The board does contain the Promise RAID Driver
BIOS. The customer wants to set up RAID1 with the BIOS and run the box
under Linux.

The kernel keeps thinking that this is a regular Ultra 100 Promise
controller and ignores the RAID partitioning. I cannot load the
pdcraid driver, because the chip is already claimed by the ide driver
as ide2/ide3.

2.4.19 is also not able to set up the OSB5 chipset IDE controller in
DMA mode. (Yes, I run latest BIOS from Intel)

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 10
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfe8e0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
PDC20267: neither IDE port enabled (BIOS)
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
PCI: Device 00:0f.1 not available because of resource collisions
SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.

With _FORCE, I get the following result:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 10
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfe8e0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0x1440-0x1447, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1448-0x144f, BIOS settings: hdg:pio, hdh:pio
SvrWks CSB5: IDE controller on PCI bus 00 dev 79
PCI: Device 00:0f.1 not available because of resource collisions
SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.

I'm quite stuck at the moment. The board won't install in RAID mode
and I can't even connect a regular disk to the OSB5 controller.

At the moment I boot the board with PXE from the network to be able to
run at least a few tests on it. Not very nice...

The board is described here: http://support.intel.com/support/motherboards/server/SCB2/
The server itself here: http://support.intel.com/support/motherboards/server/chassis/SR1200/ 

Does anyone have an idea what to do?
	
	Regards
		Henning


This is the result of lspci:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 08 00 00 00 00 00 23 00 00 06 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08
00: 66 11 08 00 07 01 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 02 01 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 02 01 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 1400 [size=8]
	Region 1: I/O ports at 1408 [size=4]
	Region 2: I/O ports at 1410 [size=8]
	Region 3: I/O ports at 140c [size=4]
	Region 4: I/O ports at 1440 [size=64]
	Region 5: Memory at fe8a0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fe8e0000 [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 30 4d 07 00 10 02 02 00 04 01 00 40 00 00
10: 01 14 00 00 09 14 00 00 11 14 00 00 0d 14 00 00
20: 41 14 00 00 00 00 8a fe 00 00 00 00 86 80 10 34
30: 01 00 8e fe 58 00 00 00 00 00 00 00 0b 01 00 00

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fe890000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1480 [size=64]
	Region 2: Memory at fe860000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fe880000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 01 90 02 0d 00 00 02 08 40 00 00
10: 00 00 89 fe 81 14 00 00 00 00 86 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 88 fe dc 00 00 00 00 00 00 00 09 01 08 38

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fe850000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 14c0 [size=64]
	Region 2: Memory at fe820000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fe840000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D2 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 01 90 02 0d 00 00 02 08 40 00 00
10: 00 00 85 fe c1 14 00 00 00 00 82 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 84 fe dc 00 00 00 00 00 00 00 05 01 08 38

00:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at fe8f0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe8c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 87 00 90 02 27 00 00 03 08 40 00 00
10: 00 00 00 fd 01 10 00 00 00 00 8f fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 8c fe 5c 00 00 00 00 00 00 00 0a 01 08 00

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
00: 66 11 01 02 07 01 00 02 92 00 01 06 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at 03a0 [size=16]
	Region 5: I/O ports at 0410 [size=4]
00: 66 11 12 02 05 01 00 02 92 8a 01 01 08 40 80 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: a1 03 00 00 11 04 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) (prog-if 10 [OHCI])
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe810000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 17 01 80 02 05 10 03 0c 08 40 00 00
10: 00 00 81 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50

00:0f.3 Host bridge: ServerWorks: Unknown device 0230
	Subsystem: Intel Corp.: Unknown device 3410
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
00: 66 11 30 02 05 01 00 02 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 10 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00




-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
