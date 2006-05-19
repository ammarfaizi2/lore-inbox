Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWESKDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWESKDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWESKDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:03:24 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:56971 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932252AbWESKDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:03:23 -0400
Date: Fri, 19 May 2006 12:03:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
Message-ID: <20060519100303.GB17270@wohnheim.fh-wedel.de>
References: <20060518160940.GS7570@earth.li> <20060518165728.GA26113@wohnheim.fh-wedel.de> <20060519090142.GB7570@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060519090142.GB7570@earth.li>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 10:01:42 +0100, Jonathan McDowell wrote:
> On Thu, May 18, 2006 at 06:57:28PM +0200, Jörn Engel wrote:
> > On Thu, 18 May 2006 17:09:41 +0100, Jonathan McDowell wrote:
> > > +	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
> >                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Could that be done in a macro?
> 
> Is there any benefit to doing so?

Not a big one.  A common pattern is to have some defines like

#define FOO_BASE 0x12340000
#define FOO_THIS (FOO_BASE + 0)
#define FOO_THAT (FOO_BASE + 4)
etc.

Your code looks similar to this pattern, so I asked.  If it doesn't
make sense, fair.

> > > +	udelay(0.04);
> > 
> > Floating point in the kernel?
> 
> Not quite. udelay is a macro on ARM so this ends up as an integer before
> it ever hits a function call.

Hmm.  It does what you say.  Whether this is robust and will continue
to do so... I'm not sure.

> In an ideal world I'd use "ndelay(40);"
> but that would result in a delay of over 1µs as ARM doesn't have ndelay
> defined so we hit the generic fallback.

Can you either introduce a proper ndelay or get rmk to officially
bless your use of (constant, I know) floats in the kernel source?  A
proper ndelay would obviously be preferred.

> > > +	ams_delta_mtd = kmalloc (sizeof(struct mtd_info) +
> >                                ^
> > > +					sizeof (struct nand_chip), GFP_KERNEL);
> > 
> > Remove space
> > 
> > And please create a structure containing both struct mtd_info and
> > struct nand_chip.  Then use sizeof(that structure)...
> 
> This format is used throughout the drivers/mtd/nand/ directory. I'd
> suggest it'd be more appropriate to have a separate patch that did this
> for all of them if it's desired, rather than having each driver do its
> own thing.
> 
> Agreed on all the spacing comments you raised; hangovers from toto.c
> that I used as a base.

We have suboptimal code in the kernel, true.  I still prefer new code
to have slightly higher standards, so the overall quality improves
slowly.  Therefore, pointing to the other ugly duckling is not an
excuse for being mud-covered. ;)

But you are right.  The other ducklings could use a bath as well.

Jörn

-- 
There are two ways of constructing a software design: one way is to make
it so simple that there are obviously no deficiencies, and the other is
to make it so complicated that there are no obvious deficiencies.
-- C. A. R. Hoare
