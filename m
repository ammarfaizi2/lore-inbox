Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275449AbRIZSaV>; Wed, 26 Sep 2001 14:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275447AbRIZSaL>; Wed, 26 Sep 2001 14:30:11 -0400
Received: from [195.223.140.107] ([195.223.140.107]:32239 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275440AbRIZSaB>;
	Wed, 26 Sep 2001 14:30:01 -0400
Date: Wed, 26 Sep 2001 20:29:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: tpepper@vato.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        Jacek =?iso-8859-1?Q?=5Biso-8859-2=5D_Pop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926202904.P27945@athlon.random>
In-Reply-To: <20010926000922.I8350@athlon.random> <Pine.LNX.4.21.0109251823550.2193-100000@freak.distro.conectiva> <20010926010516.V8350@athlon.random> <20010926111509.A3332@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010926111509.A3332@cb.vato.org>; from tpepper@vato.org on Wed, Sep 26, 2001 at 11:15:09AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 11:15:09AM -0700, tpepper@vato.org wrote:
> On Wed 26 Sep at 01:05:16 +0200 andrea@suse.de done said:
> > On Tue, Sep 25, 2001 at 06:25:10PM -0300, Marcelo Tosatti wrote:
> > > 
> > > Does vm-tweaks-1 fixes the current problem we're seeing? 
> > 
> > it seems no by reading the last email, however I'm not seeing any
> > problem, the DEBUG_GFP will tell us where the problem cames from,
> > pssobly it's a highmem thing since I never reproduced anything bad here.
> > But the point is that the above isn't going to be a right fix anyways.
> 
> vm-tweaks-1 fixes things for me.  I've got 512MB ram (kernel not
> configured for highmem) and 1 gig of swap.  The workload is heavy file
> i/o and has now been running almost 24 hours (about 2 billion I/Os or
> a few TB of data I think so far).  Previously all the memory was being
> consumed by cache, nothing swapped (as expected if the memory is cached
> buffer i/o right?) and I'd get the:

yes, unless the buffered I/O was identified as your very working set but
even in such case the 2.4.10 vm shouldn't swapout too early.

> 	__alloc_pages: 0-order allocation failed
> Now I continue to see the memory consumption / no swap, and no more
> error...iow the expected behaviour.

good. As far I can tell it is the check in swap_out that is making the
difference and fixing the oom problem, it was very intentional indeed.

> On an unrelated note if I want to backport the async I/O changes in 2.4.10,
> are there patches from you I should apply other than:
> 	2.4.10pre10aa1/40_blkdev-pagecache-17
> 	2.4.7pre8aa1/41_blkdev-pagecache-5_drop_get_bh_async-1

both patches are now included in mainline 2.4.10.

thanks,
Andrea
