Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266828AbUFYSIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266828AbUFYSIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUFYSIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:08:21 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:49553 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266828AbUFYSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:06:59 -0400
Date: Fri, 25 Jun 2004 20:08:12 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: Linux 2.6.7-mm1, IBM T40p, ACPI C3 finally working.
In-reply-to: <20040625132911.C77693-100000@www.missl.cs.umd.edu>
To: Adam Sulmicki <adam@cfar.umd.edu>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Message-id: <200406252008.20638@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <20040625132911.C77693-100000@www.missl.cs.umd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yes. i did a patch -R -p1 < ..bk-acpi.patch
But checking every single patch seems a bit clumsy to me.
I suppose anyone has changed something that busmasters all the time. Isn't 
there an easier way to tell what patch it was?

regards
Alex

Am Freitag, 25. Juni 2004 19:30 schrieb Adam Sulmicki:
> ugh. so you say you reverted whole ACPI patch and it did not help? that's
> actually surprising since it would mean that the problem is outside of the
> ACPI code.
>
> if you are up to, you probably could do a binary search to see which
> particular sub-partch of the mm2 is responsible for the regression.
>
> On Fri, 25 Jun 2004, Alexander Gran wrote:
> > Sorry, did not help:
> > alex@t40:/proc/acpi/processor/CPU$ cat power
> > active state:            C2
> > default state:           C1
> > bus master activity:     ffffffff
> > states:
> >     C1:                  promotion[C2] demotion[--] latency[000]
> > usage[00000010]
> >    *C2:                  promotion[C3] demotion[C1] latency[001]
> > usage[00164425]
> >     C3:                  promotion[--] demotion[C2] latency[085]
> > usage[00000000]
> >
> > regards
> > Alex
> >
> > Am Freitag, 25. Juni 2004 04:51 schrieb Adam Sulmicki:
> > > can you try to revert this sub-patch and see if it helps?
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6
> > >.7-m m2/broken-out/bk-acpi.patch
> > >
> > > it would be really nice to have T40? working in 2.6.8 proper.
> > >
> > > On Fri, 25 Jun 2004, Alexander Gran wrote:
> > > > Ok guys, now this is strange.
> > > >
> > > > since 2.6.7-mm2 C3 does not work any longer. No idea why.
> > > > Same config, same system:
> > > > IBM t40p, 2373-g1g.
> > > > lspci -vvv:
> > > > root@t40:~# lspci -vvv
> > > > 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
> > > > Controller (rev 03)
> > > >         Subsystem: IBM: Unknown device 0529
> > > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
> > > > >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> > > >         Latency: 0
> > > >         Region 0: Memory at d0000000 (32-bit, prefetchable)
> > > >         Capabilities: [e4] #09 [f104]
> > > >         Capabilities: [a0] AGP version 2.0
> > > >                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> > > > HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
> > > >                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
> > > > FW- Rate=x2
> > > >
> > > > 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
> > > > Controller (rev 03) (prog-if 00 [Normal decode])
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 96
> > > >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> > > >         I/O behind bridge: 00003000-00003fff
> > > >         Memory behind bridge: c0100000-c01fffff
> > > >         Prefetchable memory behind bridge: e0000000-e7ffffff
> > > >         Expansion ROM at 00003000 [disabled] [size=4K]
> > > >         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> > > >
> > > > 0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1
> > > > (rev 01) (prog-if 00 [UHCI])
> > > >         Subsystem: IBM: Unknown device 052d
> > > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin A routed to IRQ 9
> > > >         Region 4: I/O ports at 1800 [size=32]
> > > >
> > > > 0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2
> > > > (rev 01) (prog-if 00 [UHCI])
> > > >         Subsystem: IBM: Unknown device 052d
> > > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin B routed to IRQ 10
> > > >         Region 4: I/O ports at 1820 [size=32]
> > > >
> > > > 0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3
> > > > (rev 01) (prog-if 00 [UHCI])
> > > >         Subsystem: IBM: Unknown device 052d
> > > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin C routed to IRQ 11
> > > >         Region 4: I/O ports at 1840 [size=32]
> > > >
> > > > 0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI
> > > > Controller (rev 01) (prog-if 20 [EHCI])
> > > >         Subsystem: IBM: Unknown device 052e
> > > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin D routed to IRQ 10
> > > >         Region 0: Memory at c0000000 (32-bit, non-prefetchable)
> > > >         Capabilities: [50] Power Management version 2
> > > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > > >         Capabilities: [58] #0a [2080]
> > > >
> > > > 0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
> > > > (prog-if 00 [Normal decode])
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR+
> > > >         Latency: 0
> > > >         Bus: primary=00, secondary=02, subordinate=08,
> > > > sec-latency=168 I/O behind bridge: 00004000-00008fff
> > > >         Memory behind bridge: c0200000-cfffffff
> > > >         Prefetchable memory behind bridge: e8000000-efffffff
> > > >         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> > > >
> > > > 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface
> > > > Controller (rev 01)
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >
> > > > 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
> > > > Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
> > > >         Subsystem: IBM: Unknown device 052d
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin A routed to IRQ 11
> > > >         Region 0: I/O ports at <unassigned>
> > > >         Region 1: I/O ports at <unassigned>
> > > >         Region 2: I/O ports at <unassigned>
> > > >         Region 3: I/O ports at <unassigned>
> > > >         Region 4: I/O ports at 1860 [size=16]
> > > >         Region 5: Memory at 20000000 (32-bit, non-prefetchable)
> > > > [size=1K]
> > > >
> > > > 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller
> > > > (rev 01) Subsystem: IBM: Unknown device 052d
> > > >         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Interrupt: pin B routed to IRQ 10
> > > >         Region 4: I/O ports at 1880 [size=32]
> > > >
> > > > 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4)
> > > > AC'97 Audio Controller (rev 01)
> > > >         Subsystem: IBM: Unknown device 0537
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin B routed to IRQ 10
> > > >         Region 0: I/O ports at 1c00
> > > >         Region 1: I/O ports at 18c0 [size=64]
> > > >         Region 2: Memory at c0000c00 (32-bit, non-prefetchable)
> > > > [size=512] Region 3: Memory at c0000800 (32-bit, non-prefetchable)
> > > > [size=256] Capabilities: [50] Power Management version 2
> > > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > > >
> > > > 0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller
> > > > (rev 01) (prog-if 00 [Generic])
> > > >         Subsystem: IBM: Unknown device 0525
> > > >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 0
> > > >         Interrupt: pin B routed to IRQ 10
> > > >         Region 0: I/O ports at 2400
> > > >         Region 1: I/O ports at 2000 [size=128]
> > > >         Capabilities: [50] Power Management version 2
> > > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > > >
> > > > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
> > > > R250 Lf [Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
> > > >         Subsystem: IBM: Unknown device 054d
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping+ SERR+ FastB2B+
> > > >         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
> > > >         Interrupt: pin A routed to IRQ 9
> > > >         Region 0: Memory at e0000000 (32-bit, prefetchable)
> > > >         Region 1: I/O ports at 3000 [size=256]
> > > >         Region 2: Memory at c0100000 (32-bit, non-prefetchable)
> > > > [size=64K] Capabilities: [58] AGP version 2.0
> > > >                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> > > > HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
> > > >                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
> > > > FW- Rate=x2
> > > >         Capabilities: [50] Power Management version 2
> > > >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> > > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> > > >
> > > > 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card
> > > > Cardbus Controller (rev 01)
> > > >         Subsystem: IBM ThinkPad T30/T40
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 168, Cache Line Size: 0x20 (128 bytes)
> > > >         Interrupt: pin A routed to IRQ 9
> > > >         Region 0: Memory at b0000000 (32-bit, non-prefetchable)
> > > >         Bus: primary=02, secondary=03, subordinate=06,
> > > > sec-latency=176 Memory window 0: 20400000-207ff000 (prefetchable)
> > > >         Memory window 1: 20800000-20bff000
> > > >         I/O window 0: 00004000-000040ff
> > > >         I/O window 1: 00004400-000044ff
> > > >         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> > > > PostWrite+ 16-bit legacy interface ports at 0001
> > > >
> > > > 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card
> > > > Cardbus Controller (rev 01)
> > > >         Subsystem: IBM ThinkPad T30/T40
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > > ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 168, Cache Line Size: 0x20 (128 bytes)
> > > >         Interrupt: pin B routed to IRQ 10
> > > >         Region 0: Memory at b1000000 (32-bit, non-prefetchable)
> > > >         Bus: primary=02, secondary=07, subordinate=0a,
> > > > sec-latency=176 Memory window 0: 20c00000-20fff000 (prefetchable)
> > > >         Memory window 1: 21000000-213ff000
> > > >         I/O window 0: 00004800-000048ff
> > > >         I/O window 1: 00004c00-00004cff
> > > >         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
> > > > PostWrite+ 16-bit legacy interface ports at 0001
> > > >
> > > > 0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit
> > > > Ethernet Controller (Mobile) (rev 03)
> > > >         Subsystem: IBM PRO/1000 MT Mobile Connection
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 64 (63750ns min), Cache Line Size: 0x08 (32 bytes)
> > > >         Interrupt: pin A routed to IRQ 9
> > > >         Region 0: Memory at c0220000 (32-bit, non-prefetchable)
> > > >         Region 1: Memory at c0200000 (32-bit, non-prefetchable)
> > > > [size=64K] Region 2: I/O ports at 8000 [size=64]
> > > >         Capabilities: [dc] Power Management version 2
> > > >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> > > >         Capabilities: [f0] Message Signalled Interrupts: 64bit+
> > > > Queue=0/0 Enable-
> > > >                 Address: 0000000000000000  Data: 0000
> > > >
> > > > 0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211
> > > > 802.11ab NIC (rev 01)
> > > >         Subsystem: Unknown device 17ab:8310
> > > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > > > ParErr- Stepping- SERR+ FastB2B-
> > > >         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > > > >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 0x08
> > > > (32 bytes) Interrupt: pin A routed to IRQ 11
> > > >         Region 0: Memory at c0210000 (32-bit, non-prefetchable)
> > > >         Capabilities: [44] Power Management version 2
> > > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > > > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > > >                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> > > >
> > > > dmesges attached.
> > > >
> > > > regards
> > > > Alex
> > > >
> > > > Am Montag, 21. Juni 2004 19:50 schrieb Alexander Gran:
> > > > > Hi,
> > > > >
> > > > > just a quick note:
> > > > > Since 2.6.7-mm1 acpi C3 works even with usb and radeon loaded.
> > > > > Great work!
> > > > >
> > > > > regards
> > > > > Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3GoT/aHb+2190pERAlW2AJ446y3PzZY5u0LvxDxzHloiu6q0vgCgrt4K
St69aZvzniJF+yl1GTpRoKU=
=sptO
-----END PGP SIGNATURE-----

