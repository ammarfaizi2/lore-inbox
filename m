Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBHGv2>; Thu, 8 Feb 2001 01:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129929AbRBHGvS>; Thu, 8 Feb 2001 01:51:18 -0500
Received: from phoenix.dynamine.net ([64.14.25.210]:1410 "HELO
	phoenix.dynamine.net") by vger.kernel.org with SMTP
	id <S129583AbRBHGvM>; Thu, 8 Feb 2001 01:51:12 -0500
Date: Wed, 7 Feb 2001 22:51:08 -0800
From: "Michael S. Fischer" <michael@dynamine.net>
To: linux-kernel@vger.kernel.org
Subject: DMA overrun in i810_audio
Message-ID: <20010207225107.A531@dynamine.net>
Reply-To: "Michael S. Fischer" <michael@dynamine.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting hundreds of thousands of "DMA overrun on send" messages 
in my kernel logs from the i810_audio driver.  Help!  I'm running stock
Linux 2.4.1.

-- syslog --
Feb  7 22:34:27 angeline kernel: Intel 810 + AC97 Audio, version 0.01, 22:21:54
Feb  7 2001
Feb  7 22:34:27 angeline kernel: PCI: Found IRQ 11 for device 00:1f.5
Feb  7 22:34:27 angeline kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Feb  7 22:34:27 angeline kernel: i810: Intel ICH2 found at IO 0xdc00 and 0xd800, IRQ 11
Feb  7 22:34:27 angeline kernel: ac97_codec: AC97 Audio codec, id: 0x414c:0x432f (Unknown)
Feb  7 22:34:27 angeline kernel: i810_audio: only 48Khz playback available.
...
Feb  7 22:34:57 angeline kernel: DMA overrun on send
Feb  7 22:34:57 angeline last message repeated 633 times
Feb  7 22:34:57 angeline kernel: on send
Feb  7 22:34:57 angeline kernel: DMA overrun on send
Feb  7 22:34:58 angeline last message repeated 2740 times
...

-- lspci -vvv-
00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 0402
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: de000000-dfffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE U100 (rev 01) (prog-if 80 [Master])
	Subsystem: ABIT Computer Corp.: Unknown device 0402
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 01) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 0402
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d000 [size=32]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 01) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 0402
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 01)
	Subsystem: ABIT Computer Corp.: Unknown device 0402
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc00 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c41
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at df140000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at c000 [size=64]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:03.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (rev fe)
	Subsystem: Diamond Multimedia Systems Monster Sound II
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 3000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at df100000 (32-bit, non-prefetchable) [size=256K]
	Region 1: I/O ports at c400 [size=8]
	Region 2: I/O ports at c800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
	Subsystem: Adaptec: Unknown device 3869
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at cc00 [size=256]
	Region 1: Memory at df141000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
Michael S. Fischer <michael@dynamine.net>      AKA Otterley         _O_
Lead Hacketeer, Dynamine Consulting, Silicon Valley, CA              |
Phone: +1 650 533 4684 | AIM: IsThisOtterley | ICQ: 4218323          |
"From the bricks of shame is built the hope"--Alan Wilder         net.goth
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
