Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUBPN5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUBPN5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:57:08 -0500
Received: from crux.i-cable.com ([203.83.110.33]:10393 "HELO crux.i-cable.com")
	by vger.kernel.org with SMTP id S265640AbUBPNyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:54:52 -0500
Message-ID: <004301c3f494$fa0e8aa0$353ffea9@kyle>
From: "Kyle" <kyle@southa.com>
To: "Martin Schlemmer" <azarah@nosferatu.za.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Linux Kernel Mailing Lists" <linux-kernel@vger.kernel.org>
References: <021801c3f3f4$50f66280$353ffea9@kyle> <200402152019.34858.bzolnier@elka.pw.edu.pl> <1076873030.27648.17.camel@nosferatu.lan>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Mon, 16 Feb 2004 21:58:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I tried "lspci -vvv -xxx" with 2.6.1, forgotten to do this with
2.4.20, and I found this:

00:1f.1 IDE interface: Intel Corp. 82801EB ICH5 IDE (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 4c43
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 7f800000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02) (prog-if 8f
[Master SecP SecO PriP PriO])
        Subsystem: Intel Corp.: Unknown device 4c43
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e800 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at d800 [size=16]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 4c43
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d000 [size=32]

[root@s1 kyle]# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD2500JB-00EVA0, FwRev=15.05R15, SerialNo=WD-WMAEH1328328
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
 BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5 6

Does it means that ICH5 shared IRQ 18 with USB and cause the performance
problem?
I'll try to submit this to bugzilla.

Kyle

