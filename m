Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSHCDmv>; Fri, 2 Aug 2002 23:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSHCDmv>; Fri, 2 Aug 2002 23:42:51 -0400
Received: from dsl-213-023-043-125.arcor-ip.net ([213.23.43.125]:7353 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317433AbSHCDmu>;
	Fri, 2 Aug 2002 23:42:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sat, 3 Aug 2002 05:47:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <3D4AE995.DFD862EF@zip.com.au>
In-Reply-To: <3D4AE995.DFD862EF@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17aptH-0008DR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 August 2002 22:20, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > This patch eliminates about 35% of the raw rmap setup/teardown overhead by
> > adopting a new locking interface that allows the add_rmaps to be batched
> > in copy_page_range.
> 
> Well that's fairly straightforward, thanks.  Butt-ugly though ;)

I could try "fast is beautiful" or "beauty is in the eye of the beholder", 
but I think I'll stick with "beauty isn't the point just now".

> Don't bother doing teardown yet.  I have patches which batch
> all the zap_page_range activity into 16-page chunks, so we
> eventually end up in a single function with 16 virtually-contiguous
> pages to release.  Adding the batched locking to that will
> be simple.

Great.  Well, both the locking locality of anonymous pages and the dispersion 
of mmaped pages could be improved considrably, so maybe I'll play around with 
those a little.  Taking a wild guess, it might be good for another 5-10% 
overhead reduction, and won't impact the basic structure.

> Sigh.  I have a test which sends the 2.5.30 VM into a five-minute
> coma

That doesn't sound like a rmap problem per se.  Is the test posted?

> and which immediately panics latest -ac with pte_chain oom.
> Remind me again why all this is worth it?

It will be worth it when we finally have a system that swaps well and doesn't 
die if you throw a lot of disk IO at it (like BSD).  It will be doubly worth 
it when active defragmentation happens.

What we will end up with at the end of this cycle will have all the solidity 
and flexibility of the BSD VM with little of the complexity.  According to me 
anyway ;-)

-- 
Daniel
