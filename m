Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271998AbRIIPcq>; Sun, 9 Sep 2001 11:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272002AbRIIPcg>; Sun, 9 Sep 2001 11:32:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23606 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271998AbRIIPcX>; Sun, 9 Sep 2001 11:32:23 -0400
Date: Sun, 9 Sep 2001 17:33:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010909173313.V11329@athlon.random>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201c13942$b1bec9a0$010411ac@local>; from manfred@colorfullife.com on Sun, Sep 09, 2001 at 05:18:00PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 05:18:00PM +0200, Manfred Spraul wrote:
> >
> > it provides lifo allocations from both partial and unused slabs.
> >
> 
> lifo/fifo for unused slabs is obviously superflous - free is free, it
> doesn't matter which free page is used first/last.

then why don't you also make fifo the buddy allocator and the partial
list as well if free is free and fifo/lifo doesn't matter?

> Did you run any benchmarks? If yes, could you post them?

I didn't run any specific benchmark for such change but please let me
know if you can find that any real benchmark is hurted by it. I think
the cleanup and the potential for lifo in the free slabs is much more
sensible than the other factors you mentioned, of course there's less
probability of having to fall into the free slabs rather than in the
partial ones during allocations, but that doesn't mean that cannot
happen very often, but I will glady suggest to remove it if you prove me
wrong. All I'm saying here is that the dummy allocations with no access
to the ram returned are not interesting numbers.

Andrea
