Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJZOeV>; Sat, 26 Oct 2002 10:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJZOeV>; Sat, 26 Oct 2002 10:34:21 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:3755 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262158AbSJZOeS>; Sat, 26 Oct 2002 10:34:18 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Cajoline'" <cajoline@andaxin.gau.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ASUS TUSL2-C and Promise Ultra100 TX2
Date: Sat, 26 Oct 2002 16:38:30 +0200
Message-ID: <008b01c27cfd$5a6f7820$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-reply-to: <Pine.LNX.4.44.0210260632370.13879-100000@andaxin.gau.hu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This board should be rather similar to mine, with the main difference
> being suport for Coppermine/Tualatin processors.
> also use the PIIX4 onboard IDE chipset?

>From the Asus website, the motherboards are very similar, both have the
Intel 815 north bridge, and both have the ICH2 (Intel 82801BA Enhanced
I/O Controller Hub 2) IDE controller onboard. This chip is handled by
the piix.c driver.

> Indeed, that could be a workaround, but I'm afraid it's not that good
> after all, because not all the drives have the same capabilities, it's
> still slower than udma 5 (UDMA100) and from my tests, with such a
> forced setting, the performance is still poor even for this udma mode.

Note that "ata66" actually means UDMA66 and up (it actually means that
you use 80-conductor cables), so with this parameter your drive _will_
run at UDMA 100 if that's supported by the drive and controller. I have
several boxes which need this parameter with the Linus kernel tree, and
they all have disks running at UDMA100 with this boot parameter. Also,
my tests show good speeds on these drives. 

> This is interesting. Excuse my ignorance, but do you know what has
> actually changed exactly regarding PDC20268 and PDC20269?

LBA48 support (for disks > 127Gb) I think was added.

> > > What's even funnier is that if I try to copy files from a
> > > filesystem on
> > > a
> > >
> > > drive attached to a PDC20268 and a drive attached to the 
> motherboard
> > > controller (PIIX4 chipset), the system eventually locks up
> > > (after about
> > > 3
> > > GB).

This night, I experienced another hang on my box. Even magic sysreq
doesn't do anything anymore. Do you have a reproducible testcase to
trigger this?

> OK fine, I agree, but how do you explain this only happens 
> when running on
> this motherboard?

Maybe we should start blaming the onboard ICH2 controller, or the piix.c
driver in this case, because that's the only common thing in our faulty
setups. I also noticed that the ICH2 on the Asus TUSL2-C and CUSL2-C
boards have its own PCI device id in the pci.ids file. So this could
mean they have something different than regular ICH2 chips. I'll include
my full lspci -vvvx for anyone who is interested.

> Indeed. The same controllers work just fine on a P3 600 + QDI 
> Advance 10F
> motherboard (with onboard VIA vt82c686a IDE UDMA66 controller).

Did you also try this motherboard with a different brand add-on PCI
controller (like a CMD one)? 

Regards,
- Robbert


Lspci -vvvx:
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [f104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 30 11 06 00 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 88 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: f7b00000-f7bfffff
        Prefetchable memory behind bridge: f7f00000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 31 11 07 00 20 00 02 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 a0 22
20: b0 f7 b0 f7 f0 f7 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 01)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000b000-0000dfff
        Memory behind bridge: f0000000-f7afffff
        Prefetchable memory behind bridge: f7c00000-f7efffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 86 80 4e 24 07 01 80 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 b0 d0 80 22
20: 00 f0 a0 f7 c0 f7 e0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0e 00

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 40 24 0f 01 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 01) (prog-if 80
[Master])
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at a800 [size=16]
00: 86 80 4b 24 05 00 80 02 01 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a8 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 01)
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e800 [size=16]
00: 86 80 43 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 43 10 27 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

02:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at d400 [size=4]
        Region 2: I/O ports at d000 [size=8]
        Region 3: I/O ports at b800 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: Memory at f7000000 (32-bit, non-prefetchable)
[size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 d8 00 00 01 d4 00 00 01 d0 00 00 01 b8 00 00
20: 01 b4 00 00 00 00 00 f7 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 04 01 04 12

02:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 09)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at f6800000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at b000 [size=64]
        Region 2: Memory at f6000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 17 00 90 02 09 00 00 02 08 20 00 00
10: 00 00 80 f6 01 b0 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 11 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 08 38

02:0e.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06)
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, non-prefetchable)
[size=64M]
        Expansion ROM at f7cf0000 [disabled] [size=64K]
00: 33 53 31 56 07 00 00 02 06 00 00 03 00 20 00 00
10: 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 cf f7 00 00 00 00 00 00 00 00 0a 01 04 ff

