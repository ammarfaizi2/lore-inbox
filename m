Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbTAEPqy>; Sun, 5 Jan 2003 10:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTAEPqx>; Sun, 5 Jan 2003 10:46:53 -0500
Received: from tag.witbe.net ([81.88.96.48]:35599 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264856AbTAEPqt>;
	Sun, 5 Jan 2003 10:46:49 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Justin T. Gibbs'" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Date: Sun, 5 Jan 2003 16:55:20 +0100
Organization: Witbe.net
Message-ID: <013401c2b4d2$d9aab390$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <418420000.1041781806@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Out of this, two problems :
> >  - AIC7xxx fails to use DMA, with :
> > aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
> > scsi0: PCI error Interrupt at seqaddr = 0x3
> > scsi0: Signaled a Target Abort
> 
> This is because your system is violating the PCI spec.  There 
Waouh.... It is a quite new MB... I wasn't expecting it to be
so bad...

> is now an explicit test for this during driver initialization 
> so that the driver doesn't unexpectedly fail later.  I can 
Thanks for taking care of people with bad hardware...

> change the driver so that it doesn't print out the diagnostic 
> if it would make you feel better. 8-)
No, just keep it like that... It is a dev kernel !
 
> Just out of curiosity, what MB/Chipset are you using?
This is an ASUS P4S8X MB.
Not sure about the kind of chipset you are looking for, so here
are some details (but full spec are avail at asus web site).

[root@donald rol]# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device
0648 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8086
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
[size=256M]
        Capabilities: [c0] AGP version 2.0
         Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
         Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: cf800000-cfffffff
        Prefetchable memory behind bridge: eff00000-febfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device
0963 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 11
        Region 4: I/O ports at a400 [size=16]

00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ce800000 (32-bit, non-prefetchable)
[size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at ce000000 (32-bit, non-prefetchable)
[size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 9
        Region 0: Memory at cd800000 (32-bit, non-prefetchable)
[size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device
7002 (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8087
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 0: Memory at cd000000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: I/O ports at 8400 [size=256]
        Region 1: Memory at cc000000 (64-bit, non-prefetchable)
[disabled] [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs: Unknown device 8064
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8000 [size=32]
        Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 7800 [size=8]
        Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at 7400 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW
[Radeon 7500] (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 4000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at cf800000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
         Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
         Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Does this help in any way ?

Regards,
Paul, rol@as2917.net

