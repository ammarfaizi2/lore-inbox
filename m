Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276463AbRJGRYo>; Sun, 7 Oct 2001 13:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276483AbRJGRYf>; Sun, 7 Oct 2001 13:24:35 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:20121 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276463AbRJGRYW>; Sun, 7 Oct 2001 13:24:22 -0400
Date: Sun, 7 Oct 2001 13:23:49 -0400
From: Willem Riede <wriede@home.com>
To: linux-kernel@vger.kernel.org
Subject: Tyan Tiger MP AMD760 chipset support
Message-ID: <20011007132349.A1424@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Alan Cox wrote months ago:

> 2.4.7ac should be up to date on it

with reference to AMD760 (IDE?) support on a Tyan K7 Thunder,
I was somewhat surprised to find the chipset:

 	AMD-762 North bridge & AMD-766 South bridge
	Winbond W83627HF Super I/O ASIC
 	Winbond W83782D hardware monitoring ASIC

only partly recognized by my 2.4.9ac18 based kernel. 
One problem is that the temperature sensors are not detected 
(I'm reluctant to torture my system if I can't watch out for 
it overheating).

Does anyone know the AMD760 support status? Any pointers
for (experimental) patches?

Here is the lspci -vvv output:

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev
11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e8006000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 10a0 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev
02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
(rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB
(rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268
(rev 01) (prog-if 85)
	Subsystem: Promise Technology, Inc. 20268
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 10b8 [size=8]
	Region 1: I/O ports at 10b0 [size=4]
	Region 2: I/O ports at 10a8 [size=8]
	Region 3: I/O ports at 10a4 [size=4]
	Region 4: I/O ports at 1090 [size=16]
	Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at e8005000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5144 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 008a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Thanks. Willem Riede.
