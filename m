Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbSLFBgo>; Thu, 5 Dec 2002 20:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbSLFBgo>; Thu, 5 Dec 2002 20:36:44 -0500
Received: from [195.223.140.107] ([195.223.140.107]:59009 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267499AbSLFBgn>;
	Thu, 5 Dec 2002 20:36:43 -0500
Date: Fri, 6 Dec 2002 02:44:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206014429.GI1567@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFFEAA.6B386051@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 05:34:34PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > He may still suffer other known problems besides
> > the above two critical highmem fixes (for example if
> > lower_zone_reserve_ratio is not applied and there's no other fix around
> > it IMHO, that's generic OS problem not only for linux, and that was my
> > only sensible solution to fix it, the approch in mainline is way too
> > weak to make a real difference)
> 
> argh.  I hate that one ;)  Giving away 100 megabytes of memory
> hurts.

100M hurts on a 4G box? No-way ;)

it hurts when such 100M of normal zone are mlocked
by an highmem-capable users and you can't allocate one more inode but
you have still 3G free of highmem (google is doing this, they even drop
a check so they can mlock > half of the ram).

Or it hurts when you can't allocate an inode because such 100M are in
pagetables on a 64G box and you still have 60G free of highmem.

> I've never been able to find the workload which makes this
> necessary.  Can you please describe an "exploit" against 

ask google...

> 2.4.20 which demonstrates the need for this?

even simpler, swapoff -a and malloc and have fun! ;) (again ask google,
they run w/o swap for obvious good reasons)

Or if you have enough time, wait those 100M to be filled by pagetables
on a 64G box.

Andrea
