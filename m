Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUK0GC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUK0GC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUK0Dr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:47:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262589AbUKZTfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:22 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd problem
Date: Thu, 25 Nov 2004 18:45:35 +0000
User-Agent: KMail/1.7.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041122080122.GM26240@suse.de> <1101399946.18177.25.camel@localhost.localdomain> <20041125181249.GN12098@suse.de>
In-Reply-To: <20041125181249.GN12098@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411251845.35355.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 18:12, Jens Axboe wrote:
> On Thu, Nov 25 2004, Alan Cox wrote:
> > On Iau, 2004-11-25 at 15:29, Jens Axboe wrote:
> > > Something is funky with this drive, it requires an extra delay after it
> > > has raised an interrupt. But we can restrict it to ide-cd once it's
> > > fully understood.
> >
> > You are assuming its a drive issue. Some controllers have errata around
> > this area that might be involved too. We can certainly stick a quirk for
> > IRQ delay into the drive tho
>
> That's true - Alan (Chandler), can you provide an lspci of the system as
> well?

lspci -vvx output

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
 Latency: 32
 Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
 Capabilities: <available only to root>
00: 39 10 35 07 07 00 10 22 01 00 00 06 00 20 80 00
10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI 
bridge (AGP) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
 I/O behind bridge: 0000b000-0000bfff
 Memory behind bridge: cfe00000-cfefffff
 Prefetchable memory behind bridge: afc00000-cfcfffff
 BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 39 10 01 00 07 01 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 b0 b0 00 20
20: e0 cf e0 cf c0 af c0 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 0
00: 39 10 18 00 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Interrupt: pin B routed to IRQ 5
 Region 4: I/O ports at 0c00 [size=32]
00: 39 10 16 00 01 00 00 02 00 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00

0000:00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 07) (prog-if 10 [OHCI])
 Subsystem: Elitegroup Computer Systems: Unknown device 0a14
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
 Interrupt: pin D routed to IRQ 11
 Region 0: Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 02 07 10 03 0c 08 40 00 00
10: 00 e0 ff cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 14 0a
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 50

0000:00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 07) (prog-if 10 [OHCI])
 Subsystem: Elitegroup Computer Systems: Unknown device 0a14
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
 Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
 Interrupt: pin A routed to IRQ 10
 Region 0: Memory at cffff000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 01 80 82 07 10 03 0c 08 40 00 00
10: 00 f0 ff cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 14 0a
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 
d0) (prog-if 80 [Master])
 Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B 
step)
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 128
 Region 4: I/O ports at ff00 [size=16]
00: 39 10 13 55 05 00 00 00 d0 80 01 01 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
07)
 Subsystem: Creative Labs SBLive! Player 5.1
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64 (500ns min, 5000ns max)
 Interrupt: pin A routed to IRQ 5
 Region 0: I/O ports at d800 [size=32]
 Capabilities: <available only to root>
00: 02 11 02 00 05 01 90 02 07 00 01 04 00 40 80 00
10: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 61 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14

0000:00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
 Subsystem: Creative Labs Gameport Joystick
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64
 Region 0: I/O ports at dc00 [size=8]
 Capabilities: <available only to root>
00: 02 11 02 70 05 01 90 02 07 00 80 09 00 40 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (rev 
30)
 Subsystem: 3Com Corporation 3cSOHO100-TX Hurricane
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
 Interrupt: pin A routed to IRQ 11
 Region 0: I/O ports at d400 [size=128]
 Region 1: Memory at cfffdf80 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at cffc0000 [disabled] [size=128K]
 Capabilities: <available only to root>
00: b7 10 46 76 17 01 10 02 30 00 00 02 08 40 00 00
10: 01 d4 00 00 80 df ff cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 46 76
30: 00 00 fc cf dc 00 00 00 00 00 00 00 0b 01 0a 0a

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 
9200] (rev 01) (prog-if 00 [VGA])
 Subsystem: Giga-byte Technology: Unknown device 4018
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
 Region 1: I/O ports at b800 [size=256]
 Region 2: Memory at cfef0000 (32-bit, non-prefetchable) [size=64K]
 Expansion ROM at cfec0000 [disabled] [size=128K]
 Capabilities: <available only to root>
00: 02 10 61 59 07 01 b0 02 01 00 00 03 08 40 80 00
10: 08 00 00 c0 01 b8 00 00 00 00 ef cf 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 18 40
30: 00 00 ec cf 58 00 00 00 00 00 00 00 00 01 08 00

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] 
(Secondary) (rev 01)
 Subsystem: Giga-byte Technology: Unknown device 4019
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
 Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
 Region 0: Memory at b8000000 (32-bit, prefetchable) [size=128M]
 Region 1: Memory at cfee0000 (32-bit, non-prefetchable) [size=64K]
 Capabilities: <available only to root>
00: 02 10 41 59 07 00 b0 02 01 00 80 03 08 40 00 00
10: 08 00 00 b8 00 00 ee cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 19 40
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00


-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
