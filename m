Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSDRLoT>; Thu, 18 Apr 2002 07:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314322AbSDRLoS>; Thu, 18 Apr 2002 07:44:18 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:9713 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S314321AbSDRLoQ>; Thu, 18 Apr 2002 07:44:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.5.9: ide: unexpected interrupt 1 12
Date: Thu, 18 Apr 2002 07:43:45 -0400
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204180743.45666.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I pulled the latest 2.5 souce, checked with revtool and found the last changeset
converted it to 2.5.9, so I decided to try it out here.  It almost works.  During boot
I get hundreds of 'ide: unexpected interrupts 1 12'.  This is after the kernel reconizes
that I have a promize 20267 on int 12.  Is this one known?  If not what else should I
gather?.

The box is a AMD K5-III 400 on an MVP3 chipset.  The 2.4.19-pre5-ac3 lspci -vv follows.

Also the kernel build scripts now try to install the kernel with lilo.  It gets things wrong 
here.  How do I turn off this crud?

Ed Tomlinson

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at a000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at a400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)
	Subsystem: D-Link System Inc DFE-530TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (29500ns min, 38000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a800 [size=128]
	Region 1: Memory at ed120000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ea000000 [disabled] [size=64K]

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=4]
	Region 4: I/O ports at bc00 [size=64]
	Region 5: Memory at ed100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at eb000000 [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Subsystem: Kingston Technologies KNE100TX Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at c000 [size=128]
	Region 1: Memory at ed122000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ec000000 [disabled] [size=256K]

00:0b.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ed121000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk+ DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=7 SBA+ AGP+ 64bit- FW- Rate=x1


