Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbRFRNfU>; Mon, 18 Jun 2001 09:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbRFRNfL>; Mon, 18 Jun 2001 09:35:11 -0400
Received: from Expansa.sns.it ([192.167.206.189]:48398 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S263058AbRFRNe7>;
	Mon, 18 Jun 2001 09:34:59 -0400
Date: Mon, 18 Jun 2001 15:34:43 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: German Gomez Garcia <german@piraos.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.33.0106181500480.270-100000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.33.0106181524580.15235-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, German Gomez Garcia wrote:

> On Mon, 18 Jun 2001, Andrea Arcangeli wrote:
>
> > On Mon, Jun 18, 2001 at 12:14:01PM +0200, German Gomez Garcia wrote:
> > > 	Hello,
> > >
> > > 	I've running 2.4.5-ac15 for almost a day (22 hours) and I found
> > > some strange behaviour of the kswap, at least it was not present in
> > > 2.4.5-ac9. The swap memory increase with time as the cache dedicated
> > > memory also increase, that is swapping process at a very fast rate, even
> > > when no program is getting more memory. Is that the expected behaviour?
> > > 	An example, with no process running (just the usual daemons and
> > > none of them getting extra memory) the command:
> > >
> > > 	free ; sleep 60; free
> > >
> > >              total       used       free     shared    buffers     cached
> > > Mem:        513416     393184     120232        364      63276     254576
> > > -/+ buffers/cache:      75332     438084
> > > Swap:       530104      14228     515876
> > >
> > >              total       used       free     shared    buffers     cached
> > > Mem:        513416     393192     120224        364      63276     258412
> > > -/+ buffers/cache:      71504     441912
> > > Swap:       530104      18064     512040
> > >
> > > 	Any idea?
> >
> > either apply this patch to 2.4.5ac15:
> >
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_fix-unusable-vm-on-alpha-1
> >
> > (note it is not an alpha specific bug, it's just that I was triggering
> > all the time on alpha so I called the patch that way)
>
> 	It doesn't fix it, swapped memory and cache memory increase at a
> rate of about 40K/s, swapping process very fast, even the "agetty"
> processes get 64 out of 68 K swapped one or two minutes after booting.
> This rate gets lower as nothing but the essential (4K of "agetty", etc) is
> left in the physical memory.
>
I was having similar problems with a sun 3500 with 4 GB of RAM
running 2.4.5 (no problems of this kind with 2.4.4), and this
patch fixed my problems under eavy stress.

I was having the most of memory free and a lot of swap allocated,
and system swapping to dead.

Now it works, with other problems, but when i have time and
permission to try to debug them..... :).

Maybe there could be some HW related reason because of which it fixed for
my sun and not for you...

Luigi


