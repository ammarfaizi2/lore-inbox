Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbTI0GSA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 02:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbTI0GSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 02:18:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:11216 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262387AbTI0GR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 02:17:58 -0400
Date: Sat, 27 Sep 2003 08:13:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mru@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
Message-ID: <20030927061342.GA14652@ucw.cz>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <yw1x3cejjvdw.fsf@users.sourceforge.net> <20030926183323.GA12614@ucw.cz> <200309270319.37985.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309270319.37985.mhf@linuxmail.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 03:19:37AM +0800, Michael Frank wrote:

> > > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
> > >         Subsystem: Asustek Computer, Inc.: Unknown device 1688
> > >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> > >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > >         Latency: 128
> > >         Region 4: I/O ports at b800 [size=16]
> > > 00: 39 10 13 55 07 00 00 00 d0 80 01 01 00 80 80 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 88 16
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 40: 31 81 00 00 31 85 00 00 08 01 e6 51 00 02 00 02
> > 
> > Ok, this means:
> > 
> > 31 - hda: 90ns data active time, 30 ns data recovery time (PIO4)
> > 41 - hda: UDMA enabled, UDMA mode 5 (UDMA100)
> > 00 - hdb: 240ns/360ns (PIO0) - no drive present
> > 00 - hdb: UDMA disabled
> > 31 - hdc: 90ns/30ns PIO4
> > 85 - hdc: UDMA enabled, UDMA mode 2 (UDMA33)
> > 00 - hdd: 240ns/360ns (PIO0) - no drive present
> > 00 - hdd: UDMA disabled
>
> Was running 2.4.22.
> 
> Now running 2.6.0-test5. Fresh boot.
> 
> 00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at e000 [size=256]
>         Region 1: Memory at eb102000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
> 10: 01 e0 00 00 00 20 10 eb 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> I am surprised at your analysis of the pci bus data. By what you
> stated my drive(r) should be doing PIO ;)

1) You're looking at your ethernet controller config registers,
   not at the IDE controller config registers.

2) The 961 and 963 have completely different config register layout.
   Actually, there is not much common between the 961 and the 963,
   except for the '5513' fake ID. (The 961's real id is 5517, and the
   963's is 5518).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
