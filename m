Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbSITMuf>; Fri, 20 Sep 2002 08:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSITMuf>; Fri, 20 Sep 2002 08:50:35 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4062 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262518AbSITMue>; Fri, 20 Sep 2002 08:50:34 -0400
Date: Fri, 20 Sep 2002 18:42:46 +0530 (IST)
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE:  [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <Pine.LNX.4.33.0209201838030.2801-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Sep 20, 2002 at 11:40:16AM +0200, Ingo Molnar wrote:
> > > +			if (cmpxchg(&map->page, NULL, page))
> > > +				free_page(page);
> > Note that this piece breaks compilation for every arch that does not
> > have cmpxchg implementation.
> > This is the case with x86 (with CONFIG_X86_CMPXCHG undefined, e.g.
i386),
> > ARM, CRIS, m68k, MIPS, MIPS64, PARISC, s390, SH, sparc32, UML (for
x86).
> we need a cmpxchg() function in the generic library, using a spinlock.

>But this is not safe for arches that provides SMP but does not provide
>cmpxchg in hadware, right?
>I mean it is only safe to use such spinlock-based function if
>all other places read and write this value via special functions that are
>also taking this spinlock.
>Do you think we can count on this?

> Bye,
   > Oleg

First of all, using bitmap is not that good as exposed in this
mailing list (I think some good guys at IBM already implememted
bitmap for pids as part of Linux scalability enhancements & I
remember they discussed pros & cons too) & atomic operations
are not that cheap anyway. However it is good to have something
better than the previous one.

~Hanu


