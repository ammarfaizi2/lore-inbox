Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTBULcD>; Fri, 21 Feb 2003 06:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTBULcD>; Fri, 21 Feb 2003 06:32:03 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:49029 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267354AbTBULcC>;
	Fri, 21 Feb 2003 06:32:02 -0500
Date: Fri, 21 Feb 2003 12:41:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030221114143.GS31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de> <20030221105146.GA10411@holomorphy.com> <20030221110807.GQ31480@x30.school.suse.de> <3E560AE3.8030309@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E560AE3.8030309@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 10:17:55PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >it's like a dma ring buffer size of a soundcard, if you want low latency
> >it has to be small, it's as simple as that. It's a tradeoff between
> >
> Although the dma buffer is strictly FIFO, so the situation isn't
> quite so simple for disk IO.

In genereal (w/o CFQ or the other side of it that is an extreme unfair
starving elevator where you're stuck regardless the size of the queue)
larger queue will mean higher latencies in presence of flood of async
load like in a dma buffer. This is obvious for the elevator noop for
example.

I'm speaking about a stable, non starving, fast, default elevator
(something like in 2.4 mainline incidentally) and for that the
similarity with dma buffer definitely applies, there will be a latency
effect coming from the size of the queue (even ignoring the other issues
that the load of locked buffers introduces).

The whole idea of CFQ is to make some workload work lowlatency
indipendent on the size of the async queue. But still (even with CFQ)
you have all the other problems about write throttling and worthless
amount of locked ram and even wasted time on lots of full just ordered
requests in the elevator (yeah I know you use elevator noop won't waste
almost any time, but again this is not most people will use). I don't
buy Andrew complaining about the write throttling when he still allows
several dozen mbytes of ram in flight and invisible to the VM, I mean,
before complaining about write throttling the excessive worthless amount
of locked buffers must be fixed and so I did and it works very well from
the feedback I had so far. 

You can take 2.4.21pre4aa3 and benchmark it as you want if you think I'm
totally wrong, the elevator-lowlatency should be trivial to apply and
backout (benchmarking against pre4 would be unfair).

Andrea
