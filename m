Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSEQMzh>; Fri, 17 May 2002 08:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSEQMzg>; Fri, 17 May 2002 08:55:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20058 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316213AbSEQMzg>; Fri, 17 May 2002 08:55:36 -0400
Date: Fri, 17 May 2002 14:55:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Faure <paul@engsoc.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <20020517125529.GC11512@dualathlon.random>
In-Reply-To: <20020517123902.GA11512@dualathlon.random> <E178hMQ-0006Sb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 02:01:30PM +0100, Alan Cox wrote:
> > On Fri, May 17, 2002 at 01:49:21PM +0100, Alan Cox wrote:
> > > I think its mostly #2. We invoke ksoftirq far far too easily.
> > 
> > ksoftirqd + SCHED_FIFO is like no ksoftirqd at all, provided the ne card
> > is irq driven (it is) everything works like it was working in 2.4.0.
> 
> For a 10Mbit ne2k it ought to be if its done with sched fifo. For serious
> devices its not. The ksoftirqd bounce blows everything out of cache and is
> easily measured

if you're under a flood of irq ksoftirqd or not won't make differences
to the softirq handling, and yes in such case ksoftirq cannot help
because you are under a flood of do_softirq anyways run from irq context
and it is only a minor scheduler overhead in such case, but it gets
right all and polishes all the other "recursion" cases like NAPI.

But that has nothing to do with this case, here the userspace runs with
SCHED_FIFO in a loop so ksoftirqd cannot make any difference compared to
2.4.0 if the device is irq driven, so I don't see your point in
mentioning minor performance regressions while under a flood of irqs due
the minor scheduler overhead, here the minor scheduler overhead cannot
apply because ksoftirqd has not a chance to run at all.

Also I'd be nice if he could try with mainline (or 2.4.19pre8aa3) too
just in case, we didn't had any confirm that such proggy uses SCHED_FIFO
or SCHED_RR, even if I of course agree about the supposions made by
Andrew without having access to additional informations.

Andrea
