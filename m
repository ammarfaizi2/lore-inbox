Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHaUod>; Fri, 31 Aug 2001 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269257AbRHaUoX>; Fri, 31 Aug 2001 16:44:23 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:60686 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S269254AbRHaUoN>; Fri, 31 Aug 2001 16:44:13 -0400
Date: Fri, 31 Aug 2001 22:44:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Piotrek Kaczmarek <kaczorek@msg.beta.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C416MV support
Message-ID: <20010831224430.A20122@suse.cz>
In-Reply-To: <20010828210426.A278@msg.beta.pl> <20010829222606.A14042@suse.cz> <20010829231544.A4305@msg.beta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010829231544.A4305@msg.beta.pl>; from kaczorek@msg.beta.pl on Wed, Aug 29, 2001 at 11:15:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 11:15:44PM +0200, Piotrek Kaczmarek wrote:
> On Wed, Aug 29, 2001 at 10:26:06PM +0200, Vojtech Pavlik wrote:
> > On Tue, Aug 28, 2001 at 09:04:26PM +0200, Piotrek Kaczmarek wrote:
> > > Hi,
> > > I use 2.4.10-pre1-xfs series kernel (cvs checkout 2001-08-28)
> > > on a P133 based on a motherboard (don't remeber the manufacturer) 
> > > with some VIA IDE controller, which seems to be
> > > PCI_IDE: unknown IDE controller on PCI bus 00 device 08, VID=1106, DID=1571
> > > for IDE driver....
> > > VIA_82CXXX suport is compiled in kernel
> > > 
> > > Unfortunately i was unable to use UDMA33 mode with my
> > Wow, this must be a very ancient hardware! If you send me lspci -vvxxx,
> > I'll take a look and perhaps we could make it work.
> 
> Ok, here it is:
> 00:01.0 IDE interface: VIA Technologies, Inc. VT82C416MV (rev 04) (prog-if 8a [Master SecP PriP])

This is probably a bad entry in the database. The IDE/ISA chip
on your board is probably vt82c576m.

>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at 6000 [size=16]
> 00: 06 11 71 15 07 00 80 02 04 8a 01 01 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
> 40: 0b 02 09 3a 68 00 30 00 a8 20 a8 20 ff 00 ff ff

This (a8 20 a8 20 ff 00 ff ff) suggests that the chip could work with
the normal vt82cxxx.c IDE driver. It refuses to do that now, though.

Could you send me the whole lspci -vvxxx, including namely the ISA
bridge? With that knowledge I should be able to make a patch for you
that'll enable your chip in vt82cxxx.c

> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 70: 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00 00
> 80: 00 50 2d 01 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Vojtech

-- 
Vojtech Pavlik
SuSE Labs
