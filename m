Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbRAQKPT>; Wed, 17 Jan 2001 05:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132782AbRAQKPK>; Wed, 17 Jan 2001 05:15:10 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:53032 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S131721AbRAQKPA>; Wed, 17 Jan 2001 05:15:00 -0500
Date: Wed, 17 Jan 2001 11:14:49 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: Martin Mares <mj@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
Message-ID: <20010117111449.A5195@inf.tu-dresden.de>
In-Reply-To: <20010116181207.A1325@inf.tu-dresden.de> <20010117095221.A553@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117095221.A553@albireo.ucw.cz>; from mj@suse.cz on Wed, Jan 17, 2001 at 09:52:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed Jan 17, 2001 at 09:52:21 +0100, Martin Mares wrote:
> > The patch below (against vanilla 2.4.0) makes Linux recognize
> > PCI-Devices sitting in another PCI bus than 0 (or 1).
> > 
> > This was tested on a Netfinity 7100-8666 using a ServerWorks chipset.
> 
> I don't have the ServerWorks chipset documentation at hand, but I think your
> patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers
> 0x44 and 0x45 are probably ID's of two primary buses and the code should scan
> both of them, but not the space between them.

I was just inspired by the comment in this function and knew that this
"patch" was probably wrong but it was enough to get someone else' eyes
watching on it ... :-)

BTW, one line of dmesg says:
PCI: PCI BIOS revision 2.10 entry at 0xfd5cc, last bus=6

So that "6" in 0x45 made some sense to me...

> Anyway, could you send me a `lspci -MH1 -vvx' and `lspci -vvxxx -s0:0', please?

$ lspci -MH1 -vvx
00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 08 00 00 00 00 00 21 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 96, cache line size 08
00: 66 11 08 00 47 01 00 22 01 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 SCSI storage controller: Adaptec 7896
	Subsystem: Adaptec: Unknown device 080f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 100 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at 2000
	Region 1: Memory at febff000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 5f 00 07 00 90 02 00 00 00 01 08 64 80 80
10: 01 20 00 00 04 f0 bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 0f 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 27 19

00:01.1 SCSI storage controller: Adaptec 7896
	Subsystem: Adaptec: Unknown device 080f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 100 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at 2100
	Region 1: Memory at febfe000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 5f 00 07 00 90 02 00 00 00 01 08 64 80 80
10: 01 21 00 00 04 e0 bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 0f 08
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 27 19

00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
	Subsystem: IBM: Unknown device 2000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 100 (6000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 2200
	Region 1: Memory at febfdc00 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
00: 22 10 00 20 47 01 90 02 44 00 00 02 00 64 00 00
10: 01 22 00 00 00 dc bf fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 00 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 18 18

00:06.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01) (prog-if 00 [VGA])
	Subsystem: IBM Integrated Trio3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 63750ns max)
	Interrupt: pin ? routed to IRQ 255
	Region 0: Memory at f8000000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 33 53 04 89 07 00 10 02 01 00 00 03 00 60 00 00
10: 00 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 db 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 04 ff

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 66 11 00 02 47 01 00 02 4f 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 0840
00: 66 11 11 02 45 01 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at febfc000 (32-bit, non-prefetchable)
00: 66 11 20 02 57 01 80 02 04 10 03 0c 08 60 80 00
10: 00 c0 bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 00 50

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Subsystem: Accton Technology Corporation Cheetah Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 100 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 2280
	Region 1: Memory at f7fffc00 (32-bit, non-prefetchable)
00: 11 10 19 00 57 01 80 02 41 00 00 02 08 64 00 00
10: 81 22 00 00 00 fc ff f7 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 07 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 14 28

02:06.0 RAID bus controller: IBM: Unknown device 01bd
	Subsystem: IBM: Unknown device 01bf
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f5ffe000 (32-bit, prefetchable)
00: 14 10 bd 01 56 01 80 02 00 00 04 01 08 60 00 00
10: 08 e0 ff f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 bf 01
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00


Summary of buses:

00: Primary host bus
02: Secondary host bus (?)

$ lspci -vvxxx -s0:0
00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 66 11 08 00 00 00 00 00 21 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 01 06 00 00 00 61 01 33 00 00 00 00
50: 00 00 00 00 03 00 00 00 00 00 00 10 00 00 00 00
60: 00 00 c0 10 00 01 07 04 00 00 00 00 00 00 00 00
70: 08 aa 0a aa c0 0f ff 2f 01 18 00 00 06 00 00 00
80: 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 f9 1a 5f 00 10 00 00 00 10 00 00 00 00 00 00
a0: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 43 00 98 58 00 00 00 01 a6 78 83 08 12 ac 49 84
c0: 00 02 af 08 b0 08 5f 0f 60 0f 7f 0f 15 00 c0 fe
d0: 20 22 fc ff 24 42 a4 28 00 00 00 00 01 00 00 00
e0: 04 00 00 00 00 96 00 00 03 00 00 96 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 00 00 00

00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 96, cache line size 08
00: 66 11 08 00 47 01 00 22 01 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 f8 00 00 00 00 43 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 00 20 00 01 02 00 10 41 3c 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 5a 00 45 02 80 0f 7f 0f 80 0f ff 0f 10 00 00 00
d0: 00 00 1c 22 00 00 00 00 00 00 00 00 01 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 54 40 7e f1 ec 9f 4a b0 00 00 00 00 c2 08 00 00

00:00.2 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 06 f8 00 02 ff 00 04 00 00 00 00
50: 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 0a aa c0 0f ff 0f 00 00 80 00 00 00 00 00
80: 20 00 00 00 fd b9 fb ef ff ff ff ff 00 00 00 00
90: dc ff fc 6f 74 39 fc ff 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 02 af 08 b0 08 5f 0f 60 0f 7f 0f 15 00 00 00
d0: 20 22 fc ff fc bf b8 6d dc ff fc fb 01 00 00 00
e0: ff ff ff ef 00 00 00 00 00 00 00 00 c4 00 00 00
f0: 40 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 Host bridge: ServerWorks: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
00: 66 11 06 00 42 01 00 22 00 00 00 06 08 60 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 01 01 f8 00 12 ff 00 04 00 00 00 00
50: 15 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 0a aa c0 0f ff 0f 00 00 80 00 00 00 00 00
80: 20 00 00 00 fd b9 fb ef ff ff ff ff 00 00 00 00
90: f8 fd bc ef fc ff dc 5f 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: fd ff ff ff 60 0f 5f 0f 80 0f 7f 0f 00 00 00 00
d0: 20 22 1c 22 dc ff fc ef fc ff ec ff 00 00 00 00
e0: 7f fb bf fd 00 00 00 00 00 00 00 00 c6 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
