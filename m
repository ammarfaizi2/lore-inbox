Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314379AbSDZUFy>; Fri, 26 Apr 2002 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314413AbSDZUFx>; Fri, 26 Apr 2002 16:05:53 -0400
Received: from waste.org ([209.173.204.2]:17538 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314379AbSDZUFw>;
	Fri, 26 Apr 2002 16:05:52 -0400
Date: Fri, 26 Apr 2002 15:05:21 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Pavel Machek <pavel@ucw.cz>, Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.10 IDE 42
In-Reply-To: <Pine.LNX.4.44.0204261031370.29542-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204261454440.30456-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Linus Torvalds wrote:

>
>
> On Fri, 26 Apr 2002, Pavel Machek wrote:
> > > +		if (stat & READY_STAT)
> > > +			printk("DriveReady ");
> > > +		if (stat & WRERR_STAT)
> > > +			printk("DeviceFault ");
> > > +		if (stat & SEEK_STAT)
> > > +			printk("SeekComplete ");
> > > +		if (stat & DRQ_STAT)
> > > +			printk("DataRequest ");
> > > +		if (stat & ECC_STAT)
> > > +			printk("CorrectedError ");
> > > +		if (stat & INDEX_STAT)
> > > +			printk("Index ");
> > > +		if (stat & ERR_STAT)
> > > +			printk("Error ");
> >
> > I believe this is actually making it *less* readable.
>
> Somewhat agreed. Also, the above is just not the right way to do
> printouts.
>
> I'd suggest rewriting the whole big mess as something like
>
> 	#define STAT_STR(x,s) \
> 		((stat & x ##_STAT) ? s " " : "")
>
> 	...
>
> 	printf("IDE: %s%s%s%s%s%s..\n"
> 		STAT_STR(READY, "DriveReady"),
> 		STAT_STR(WERR, "DeviceFault"),
> 		...

I'd go even further and suggest that pulling the mapping from a mask or
key to string out into a table and looping through it is preferable for
this sort of thing. You win later if you decide you need the same mapping
elsewhere or if you want to format your messages differently, add bits to
it, etc. Tables are generally easier to inspect for errors than code,
although Linus' version is very nearly a table.

Maintaining tables as code is a pain and is generally only a win for
small or sparse state machines.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

