Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSCWBWi>; Fri, 22 Mar 2002 20:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310224AbSCWBPP>; Fri, 22 Mar 2002 20:15:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292852AbSCWBO5>;
	Fri, 22 Mar 2002 20:14:57 -0500
Date: Fri, 22 Mar 2002 16:27:08 -0800
From: Adam Fritzler <mid@zigamorph.net>
To: "G. Clark Haynes" <gchaynes@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony VAIO GR, 1394 port not receiving IRQ
Message-ID: <20020323002708.GC348@zigamorph.net>
In-Reply-To: <Pine.LNX.4.33.0203180037130.22725-300000@crimson.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had this problem with my R505DS.  Try recompiling your kernel to force
PCI "direct" access (CONFIG_PCI_GODIRECT=y).  GOANY and GOBIOS both
failed, but GODIRECT works. 

Of course, sbp can't log into the CD-RW/DVD drive on the dock -- but at
least now it's a 1394 problem and not PCI.

asf.

On Mon, Mar 18, 2002 at 12:42:34AM -0500, G. Clark Haynes wrote:
> I have a relatively new Sony laptop, purchased last summer, which fails to
> receive an IRQ for its 1394 port (firewire).  I suspect the problem here
> is the PCI subsystem, and not  the Firewire drivers.  I have already
> contacted the linux1394 developers, but since this problem is most likely
> something between the bios and the kernel, I'm hoping some of you could
> shed some light on it.
> 
> Upon trying to activate the ohci1394 module, the kernel complains that it
> cannot accesst the shared IRQ 0.  Why it is being assigned IRQ 0, I do not
> know.  Any help??
> 
> I have been running tests by inputting various pci=option[,option...]
> flags at boot time, but none of them seem to make a large change to the
> PCI settings.  The output from "lspci -vvx" is attached.
> 
> Clark Haynes, gchaynes@umich.edu
> Artificial Intelligence Lab
> University of Michigan

> 00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
> 	Capabilities: [40] #09 [0105]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1
> 00: 86 80 75 35 06 01 10 20 02 00 00 06 00 00 00 00
> 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 96
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: d0100000-d01fffff
> 	Prefetchable memory behind bridge: d8000000-dfffffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 00: 86 80 76 35 07 00 20 00 02 00 04 06 00 60 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
> 20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
> 
> 00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01) (prog-if 00 [UHCI])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 9
> 	Region 4: I/O ports at 1800 [size=32]
> 00: 86 80 82 24 05 00 80 02 01 00 03 0c 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
> 
> 00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01) (prog-if 00 [UHCI])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 9
> 	Region 4: I/O ports at 1820 [size=32]
> 00: 86 80 84 24 05 00 80 02 01 00 03 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 21 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00
> 
> 00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01) (prog-if 00 [UHCI])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin C routed to IRQ 0
> 	Region 4: I/O ports at 1840 [size=32]
> 00: 86 80 87 24 05 00 80 02 01 00 03 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 41 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 03 00 00
> 
> 00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 41) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
> 	I/O behind bridge: 00004000-00004fff
> 	Memory behind bridge: d0200000-d02fffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 00: 86 80 48 24 07 00 80 00 41 00 04 06 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 02 02 40 40 40 80 22
> 20: 20 d0 20 d0 f0 ff 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
> 
> 00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 00: 86 80 8c 24 0f 00 80 02 01 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 0
> 	Region 0: I/O ports at 01f0 [size=8]
> 	Region 1: I/O ports at 03f4
> 	Region 2: I/O ports at 0170 [size=8]
> 	Region 3: I/O ports at 0374
> 	Region 4: I/O ports at 1860 [size=16]
> 	Region 5: Memory at d0000000 (32-bit, non-prefetchable) [size=1K]
> 00: 86 80 8a 24 07 00 80 02 01 8a 01 01 00 00 00 00
> 10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
> 20: 61 18 00 00 00 00 00 d0 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
> 
> 00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 01)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin B routed to IRQ 0
> 	Region 4: I/O ports at 1880 [size=32]
> 00: 86 80 83 24 01 00 80 02 01 00 05 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 81 18 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 02 00 00
> 
> 00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2485 (rev 01)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 9
> 	Region 0: I/O ports at 1c00 [size=256]
> 	Region 1: I/O ports at 18c0 [size=64]
> 00: 86 80 85 24 05 00 80 02 01 00 01 04 00 00 00 00
> 10: 01 1c 00 00 c1 18 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00
> 
> 00:1f.6 Modem: Intel Corporation: Unknown device 2486 (rev 01) (prog-if 00 [Generic])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin B routed to IRQ 0
> 	Region 0: I/O ports at 2400 [size=256]
> 	Region 1: I/O ports at 2000 [size=128]
> 00: 86 80 86 24 01 00 80 02 01 00 03 07 00 00 00 00
> 10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 02 00 00
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 (prog-if 00 [VGA])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
> 	Region 1: I/O ports at 3000 [size=256]
> 	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [58] AGP version 2.0
> 		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 02 10 59 4c 83 02 b0 02 00 00 00 03 08 42 00 00
> 10: 08 00 00 d8 01 30 00 00 00 00 10 d0 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 58 00 00 00 00 00 00 00 09 01 08 00
> 
> 02:02.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 (rev 02) (prog-if 10 [OHCI])
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (750ns min, 1000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 0
> 	Region 0: Memory at d0205000 (32-bit, non-prefetchable) [size=2K]
> 	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 4c 10 21 80 06 00 10 02 02 10 00 0c 08 40 00 00
> 10: 00 50 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 03 04
> 
> 02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168
> 	Interrupt: pin A routed to IRQ 3
> 	Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
> 	I/O window 0: 00004400-000044ff
> 	I/O window 1: 00004800-000048ff
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
> 	16-bit legacy interface ports at 0001
> 00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
> 10: 00 60 20 d0 dc 00 00 02 02 03 06 b0 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 44 00 00
> 30: fc 44 00 00 00 48 00 00 fc 48 00 00 03 01 80 05
> 40: 4d 10 e7 80 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 168
> 	Interrupt: pin B routed to IRQ 0
> 	Region 0: Memory at d0207000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
> 	I/O window 0: 00004c00-00004cff
> 	I/O window 1: 00000000-00000003
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
> 	16-bit legacy interface ports at 0001
> 00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
> 10: 00 70 20 d0 dc 00 00 02 02 07 0a b0 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 4c 00 00
> 30: fc 4c 00 00 00 00 00 00 00 00 00 00 00 02 00 05
> 40: 4d 10 e7 80 01 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 02:08.0 Ethernet controller: Intel Corporation: Unknown device 1031 (rev 41)
> 	Subsystem: Sony Corporation: Unknown device 80e7
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 66 (2000ns min, 14000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=4K]
> 	Region 1: I/O ports at 4000 [size=64]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
> 00: 86 80 31 10 07 00 90 02 41 00 00 02 08 42 00 00
> 10: 00 40 20 d0 01 40 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e7 80
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38
> 

> Mar 15 18:30:12 visvaio kernel: ohci1394: v0.50 15/Jul/01 Ben Collins 
> <bcollins@debian.org>
> Mar 15 18:30:12 visvaio kernel: PCI: No IRQ known for interrupt pin A of device 02:02.0. 
> Please try using pci=biosirq.
> Mar 15 18:30:12 visvaio kernel: ohci1394: Failed to allocate shared interrupt 0
> Mar 15 18:30:12 visvaio kernel: Trying to free free IRQ0
> 

