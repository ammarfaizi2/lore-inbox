Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272537AbRIKTfZ>; Tue, 11 Sep 2001 15:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRIKTfQ>; Tue, 11 Sep 2001 15:35:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272537AbRIKTfD>; Tue, 11 Sep 2001 15:35:03 -0400
Date: Tue, 11 Sep 2001 21:36:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
Subject: Re: Purpose of the mm/slab.c changes
Message-ID: <20010911213602.C715@athlon.random>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random> <001201c13942$b1bec9a0$010411ac@local> <20010909173313.V11329@athlon.random> <004101c13af1$6c099060$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004101c13af1$6c099060$010411ac@local>; from manfred@colorfullife.com on Tue, Sep 11, 2001 at 08:41:32PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 08:41:32PM +0200, Manfred Spraul wrote:
> > I think the cleanup
> I'm sure you read of this comment in page_alloc.c:
> * Buddy system. Hairy. You really aren't expected to understand this
> *
> * Hint: -mask = 1+~mask
> 
> and the slab allocator must sustain more 10 times more allocations/sec:
> from lse netbench on sourceforge, 4-cpu, ext2, one minute:
>     4 million kmallocs,
>     5 million kmem_cache_alloc
>     721 000 rmqueue
> slab.c doesn't need to be simple, it must be fast.
> 
> > and the potential for lifo in the free slabs is much more
> > sensible than the other factors you mentioned, of course there's less
> > probability of having to fall into the free slabs rather than in the
> > partial ones during allocations, but that doesn't mean that cannot
> > happen very often, but I will glady suggest to remove it if you prove
> > me wrong.
> 
> Ok, so you agree that your changes are only beneficial in one case:
> 
> kmem_cache_free(), uniprocessor or SMP not-per-cpu cached.

I wouldn't say "not only in such case" but "mainly in such case"
(there's not infinite ram in the per-cpu caches).

> If I can modify my slab allocator to guarantee it, you'd drop your
> patch?

I'm open to an alternate more optimized approch, however I've to say
that using the struct list_head and maintaining the very clean three
separated lists was really nice IMHO.

Also I believe there are more interesting parts to optimize on the
design side rather than making the slab.c implementation more complex
with the object of microoptimization for microbenchmarks (as you told me
you couldn't measure any decrease in performance in real life in a
sendfile benchmark, infact the first run with the patch was a little
faster and the second a little slower).

Andrea
