Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTI0Gk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTI0Gk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 02:40:57 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:30731 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262395AbTI0Gkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 02:40:55 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Sat, 27 Sep 2003 14:40:12 +0800
User-Agent: KMail/1.5.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, mru@users.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <200309270319.37985.mhf@linuxmail.org> <20030927061342.GA14652@ucw.cz>
In-Reply-To: <20030927061342.GA14652@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309271440.12958.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 14:13, Vojtech Pavlik wrote:
> On Sat, Sep 27, 2003 at 03:19:37AM +0800, Michael Frank wrote:
> 
> > > > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
> > > >         Subsystem: Asustek Computer, Inc.: Unknown device 1688
> > > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> > > >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > > >         Latency: 128
> > > >         Region 4: I/O ports at b800 [size=16]
> > > > 00: 39 10 13 55 07 00 00 00 d0 80 01 01 00 80 80 00
> > > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 88 16
> > > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > 40: 31 81 00 00 31 85 00 00 08 01 e6 51 00 02 00 02
> > > 
> > > Ok, this means:
> > > 
> > > 31 - hda: 90ns data active time, 30 ns data recovery time (PIO4)
> > > 41 - hda: UDMA enabled, UDMA mode 5 (UDMA100)
> > > 00 - hdb: 240ns/360ns (PIO0) - no drive present
> > > 00 - hdb: UDMA disabled
> > > 31 - hdc: 90ns/30ns PIO4
> > > 85 - hdc: UDMA enabled, UDMA mode 2 (UDMA33)
> > > 00 - hdd: 240ns/360ns (PIO0) - no drive present
> > > 00 - hdd: UDMA disabled
> >

> 1) You're looking at your ethernet controller config registers,
>    not at the IDE controller config registers.

Oooooooooops, pasted the wrong one - was 3am ;)

Here it is with 2.4.22:

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 5332
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 10
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 13 55 05 00 10 02 00 80 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 40 00 00 00 00 00 00 00 00 00 00 62 14 32 53
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 07 f2 07 ea 96 d5 d0 01 00 02 86 00 00 00 00
60: ff aa ff aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 00 60 1c 1e 00 60 1c 1e 00 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

2.6.0-test5 is same

Regards
Michael

