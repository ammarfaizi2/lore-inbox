Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289072AbSA3K0H>; Wed, 30 Jan 2002 05:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSA3KZ6>; Wed, 30 Jan 2002 05:25:58 -0500
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:41464 "EHLO
	pidaibm.in.idoox.com") by vger.kernel.org with ESMTP
	id <S289080AbSA3KZi>; Wed, 30 Jan 2002 05:25:38 -0500
Date: Wed, 30 Jan 2002 11:25:41 +0100
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre7 Ali chipset performance
Message-ID: <20020130112541.A1215@pidaibm.in.idoox.com>
Reply-To: david@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux 2.4.18-pre7
Organization: Systinet, Inc. [formerly Idoox]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I face bad disk performance on 2.4.18pre7 on
my new Thinkpad R30 laptop with ALI IDE chipset. 
I can get around ~8mb/s with hdparm. With 
stock 2.4.9-21 redhat kernel I can get 18mb/s, but
random lookups occured. 

Chipset is recognized as:

ALI15X3: IDE controller on PCI bus 00 dev 80
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7050-0x7057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7058-0x705f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N015ATDA04-0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 29498112 sectors (15103 MB) w/347KiB Cache, CHS=1950/240/63, UDMA(33)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)



[root@pidaibm david]# hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  2.06 seconds = 62.14 MB/sec
 Timing buffered disk reads:  64 MB in  8.35 seconds =  7.66 MB/sec
[root@pidaibm david]# 


[root@pidaibm david]# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1950/240/63, sectors = 29498112, start = 0
[root@pidaibm david]# 


[root@pidaibm david]# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 01)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01)
00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown device 5451 (rev 01)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 0d)
00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:13.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6972
00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d)
[root@pidaibm david]# 


[root@pidaibm david]# lspci -vv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=27 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 80500000-818fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]: Unknown device 5451 (rev 01)
	Subsystem: IBM: Unknown device 0506
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at 81c00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 0d)
	Subsystem: IBM: Unknown device 023a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 81a00000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 9000 [size=64]
	Region 2: Memory at 81a20000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 81a40000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if fa)
	Subsystem: IBM: Unknown device 050f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 7050 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: IBM: Unknown device 0510
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:13.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6972
	Subsystem: IBM: Unknown device 020c
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=00, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 81e00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0502
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at 80500000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at 81000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 80520000 [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-David
