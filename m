Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQKPSln>; Thu, 16 Nov 2000 13:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPSlX>; Thu, 16 Nov 2000 13:41:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12816 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129076AbQKPSlR>; Thu, 16 Nov 2000 13:41:17 -0500
Date: Thu, 16 Nov 2000 10:10:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: PATCH: 8139too kernel thread
In-Reply-To: <Pine.GSO.4.21.0011161302200.13047-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011161008060.2513-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Alexander Viro wrote:
> 
> On Thu, 16 Nov 2000, Alan Cox wrote:
> 
> > > The only disadvantage to this scheme is the added cost of a kernel
> > > thread over a kernel timer.  I think this is an ok cost, because this
> > > is a low-impact thread that sleeps a lot..
> > 
> > 8K of memory, two tlb flushes, cache misses on the scheduler. The price is
>                 ^^^^^^^^^^^^^^^
> > actually extremely high.
> 
> <confused>
> Does it really need non-lazy TLB?

If Alan wants to back-port it into 2.2.x, the lazy tlb won't work.

But yes, on 2.4.x the cost of threads is fairly low. The biggest cost by
far is probably the locking needed for the scheduler etc, and there the
best rule of thumb is probably to see whether the driver really ends up
being noticeably simpler.

The event stuff that we are discussing for pcmcia may make all of this
moot, maybe media selection is the perfect example of how to do the very
same thing. I'll forward Jeff the emails on that.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
