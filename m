Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUFYCtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUFYCtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 22:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUFYCtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 22:49:15 -0400
Received: from www.missl.cs.umd.edu ([128.8.126.38]:4103 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S266173AbUFYCs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 22:48:57 -0400
Date: Thu, 24 Jun 2004 22:51:14 -0400 (EDT)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Alexander Gran <alex@zodiac.dnsalias.org>
cc: linux-kernel@vger.kernel.org, <linux-thinkpad@linux-thinkpad.org>
Subject: Re: Linux 2.6.7-mm1, IBM T40p, ACPI C3 finally working.
In-Reply-To: <200406250406.45408@zodiac.zodiac.dnsalias.org>
Message-ID: <20040624225008.N73194-100000@www.missl.cs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


can you try to revert this sub-patch and see if it helps?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm2/broken-out/bk-acpi.patch

it would be really nice to have T40? working in 2.6.8 proper.

On Fri, 25 Jun 2004, Alexander Gran wrote:

> Ok guys, now this is strange.
>
> since 2.6.7-mm2 C3 does not work any longer. No idea why.
> Same config, same system:
> IBM t40p, 2373-g1g.
> lspci -vvv:
> root@t40:~# lspci -vvv
> 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev
> 03)
>         Subsystem: IBM: Unknown device 0529
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at d0000000 (32-bit, prefetchable)
>         Capabilities: [e4] #09 [f104]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
> Rate=x2
>
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
> 03) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 96
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 00003000-00003fff
>         Memory behind bridge: c0100000-c01fffff
>         Prefetchable memory behind bridge: e0000000-e7ffffff
>         Expansion ROM at 00003000 [disabled] [size=4K]
>         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
>
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
> (prog-if 00 [UHCI])
>         Subsystem: IBM: Unknown device 052d
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 9
>         Region 4: I/O ports at 1800 [size=32]
>
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
> (prog-if 00 [UHCI])
>         Subsystem: IBM: Unknown device 052d
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 10
>         Region 4: I/O ports at 1820 [size=32]
>
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
> (prog-if 00 [UHCI])
>         Subsystem: IBM: Unknown device 052d
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 11
>         Region 4: I/O ports at 1840 [size=32]
>
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
> (rev 01) (prog-if 20 [EHCI])
>         Subsystem: IBM: Unknown device 052e
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 10
>         Region 0: Memory at c0000000 (32-bit, non-prefetchable)
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] #0a [2080]
>
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if
> 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
>         I/O behind bridge: 00004000-00008fff
>         Memory behind bridge: c0200000-cfffffff
>         Prefetchable memory behind bridge: e8000000-efffffff
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
> 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
> Controller (rev 01) (prog-if 8a [Master SecP PriP])
>         Subsystem: IBM: Unknown device 052d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at <unassigned>
>         Region 1: I/O ports at <unassigned>
>         Region 2: I/O ports at <unassigned>
>         Region 3: I/O ports at <unassigned>
>         Region 4: I/O ports at 1860 [size=16]
>         Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
>
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
>         Subsystem: IBM: Unknown device 052d
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 10
>         Region 4: I/O ports at 1880 [size=32]
>
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97
> Audio Controller (rev 01)
>         Subsystem: IBM: Unknown device 0537
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 10
>         Region 0: I/O ports at 1c00
>         Region 1: I/O ports at 18c0 [size=64]
>         Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
>         Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
> (prog-if 00 [Generic])
>         Subsystem: IBM: Unknown device 0525
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 10
>         Region 0: I/O ports at 2400
>         Region 1: I/O ports at 2000 [size=128]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
> [Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
>         Subsystem: IBM: Unknown device 054d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping+ SERR+ FastB2B+
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at e0000000 (32-bit, prefetchable)
>         Region 1: I/O ports at 3000 [size=256]
>         Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [58] AGP version 2.0
>                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
> Rate=x2
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01)
>         Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168, Cache Line Size: 0x20 (128 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at b0000000 (32-bit, non-prefetchable)
>         Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
>         Memory window 0: 20400000-207ff000 (prefetchable)
>         Memory window 1: 20800000-20bff000
>         I/O window 0: 00004000-000040ff
>         I/O window 1: 00004400-000044ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
>
> 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01)
>         Subsystem: IBM ThinkPad T30/T40
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168, Cache Line Size: 0x20 (128 bytes)
>         Interrupt: pin B routed to IRQ 10
>         Region 0: Memory at b1000000 (32-bit, non-prefetchable)
>         Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
>         Memory window 0: 20c00000-20fff000 (prefetchable)
>         Memory window 1: 21000000-213ff000
>         I/O window 0: 00004800-000048ff
>         I/O window 1: 00004c00-00004cff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
>         16-bit legacy interface ports at 0001
>
> 0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet
> Controller (Mobile) (rev 03)
>         Subsystem: IBM PRO/1000 MT Mobile Connection
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (63750ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at c0220000 (32-bit, non-prefetchable)
>         Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
>         Region 2: I/O ports at 8000 [size=64]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable-
>                 Address: 0000000000000000  Data: 0000
>
> 0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab
> NIC (rev 01)
>         Subsystem: Unknown device 17ab:8310
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at c0210000 (32-bit, non-prefetchable)
>         Capabilities: [44] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> dmesges attached.
>
> regards
> Alex
>
>
> Am Montag, 21. Juni 2004 19:50 schrieb Alexander Gran:
> > Hi,
> >
> > just a quick note:
> > Since 2.6.7-mm1 acpi C3 works even with usb and radeon loaded.
> > Great work!
> >
> > regards
> > Alex
>
>

