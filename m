Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136460AbREDRRl>; Fri, 4 May 2001 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136462AbREDRRW>; Fri, 4 May 2001 13:17:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:52334 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136460AbREDRRG>; Fri, 4 May 2001 13:17:06 -0400
Date: Fri, 4 May 2001 19:16:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504191623.F22820@athlon.random>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010503192848.V1162@athlon.random> <20010504131528.A2228@jurassic.park.msu.ru> <20010504163359.F3762@athlon.random> <20010504210233.A653@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010504210233.A653@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, May 04, 2001 at 09:02:33PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 09:02:33PM +0400, Ivan Kokshaysky wrote:
> But I can't imagine how this "feature" could be useful in a real life :-)

It will be required by the time we can fork more than 2^16 tasks (which
I'm wondering if it could be just the case if you use CLONE_PID as
root, I didn't checked the code yet to be sure).

> You meant "the fast path", I guess? Then it's true. However with those

Yes, I guess the slow path is quite painful to maintain, however I'd add
at least the __builtin_expect() so it gets optimized by 2.96 and 3.[01].

> atomic functions code is much more readable.

Your attached code is nice enough IMHO ;).

> Anyway, I've attached asm-alpha/rwsem_xchgadd.h for your implementation.

Sweet, thanks.

> However I got processes in D state early on boot with it -- maybe
> I've made a typo somewhere...

It has to be a bug in a non contention case then, or maybe you run some
threaded app during boot?  Note that my version is a bit different than
David's one, my fast path has less requirements in up_write and so it
can be implemented with less instructions. I will check and integrate
your code soon into my patch, thanks. If you find the bug meanwhile let
me know (to beat it hard you can use my userspace threaded app that
faults and mmap/munmap in loop from dozen of threads).

Andrea
