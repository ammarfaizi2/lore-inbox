Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSDZRh7>; Fri, 26 Apr 2002 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314095AbSDZRh6>; Fri, 26 Apr 2002 13:37:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8717 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314094AbSDZRh5>; Fri, 26 Apr 2002 13:37:57 -0400
Date: Fri, 26 Apr 2002 10:37:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.10 IDE 42
In-Reply-To: <20020426160911.GE3783@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0204261031370.29542-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Apr 2002, Pavel Machek wrote:
> > +		if (stat & READY_STAT)
> > +			printk("DriveReady ");
> > +		if (stat & WRERR_STAT)
> > +			printk("DeviceFault ");
> > +		if (stat & SEEK_STAT)
> > +			printk("SeekComplete ");
> > +		if (stat & DRQ_STAT)
> > +			printk("DataRequest ");
> > +		if (stat & ECC_STAT)
> > +			printk("CorrectedError ");
> > +		if (stat & INDEX_STAT)
> > +			printk("Index ");
> > +		if (stat & ERR_STAT)
> > +			printk("Error ");
>
> I believe this is actually making it *less* readable.

Somewhat agreed. Also, the above is just not the right way to do
printouts.

I'd suggest rewriting the whole big mess as something like

	#define STAT_STR(x,s) \
		((stat & x ##_STAT) ? s " " : "")

	...

	printf("IDE: %s%s%s%s%s%s..\n"
		STAT_STR(READY, "DriveReady"),
		STAT_STR(WERR, "DeviceFault"),
		...

which is pretty certain to generate much smaller code (not to mention
smaller sources).

			Linus

