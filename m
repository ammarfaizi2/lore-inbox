Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293367AbSCECBm>; Mon, 4 Mar 2002 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293330AbSCECBN>; Mon, 4 Mar 2002 21:01:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:13453 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293299AbSCECAk>; Mon, 4 Mar 2002 21:00:40 -0500
To: Andrea Arcangeli <andrea@suse.de>
cc: Gerrit Huizenga <gh@us.ibm.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.4.19pre1aa1 
In-Reply-To: Your message of Tue, 05 Mar 2002 01:19:07 +0100.
             <20020305011907.V20606@dualathlon.random> 
Date: Mon, 04 Mar 2002 18:00:28 -0800
Message-Id: <E16i4Fg-00014S-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In message <20020305011907.V20606@dualathlon.random>, > : Andrea Arcangeli writ
es:
> On Mon, Mar 04, 2002 at 03:09:51PM -0800, Gerrit Huizenga wrote:
> > 
> > In message <20020304232544.P20606@dualathlon.random>, > : Andrea Arcangeli writ
> > es:
> > > it's better to make sure to use all available ram in all nodes instead
> > > of doing migrations when the local node is low on mem. But this again
> > > depends on the kind of numa system, I'm considering the new numas, not
> > > the old ones with the huge penality on the remote memory.
> > 
> > Andrea, don't forget that the "old" NUMAs will soon be the "new" NUMAs
> > again.  The internal bus and clock speeds are still quite likely to
> > increase faster than the speeds of most interconnects.  And even quite
> 
> For various reasons I think we'll never go back to "old" NUMA in the
> long run.
 
Do those reasons involve new advances in physics?  How close can you
put, say, 4 CPUs?  How physically close together can you put, say
64 CPUs?  How fast can you arbitrate sharing/cache coherency on an
interconnect?  How fast does, say, Intel, increase the clock rate of
a processor?  How fast does the bus rate for the same chip increase?
How fast does the interconnect speed increase?  How fast is the L1
cache?  L2?  L3?  L4?

Basically, the trend seems to be hierarcies of latency and bandwidth,
and the more loads arbitrating in a given level of the hierarchy, the
longer the greater the latency.  In part, the physics and the cost
of technologies seem to force a hierarchical approach.

I'm not sure why you think Physics won't dictate a return to the
previous differences in latency, especially since several vendors
are already working in that space...

> > a few "big SMP" machines today are really somewhat NUMA-like with a
> > 2 to 1 - remote to local memory latency (e.g. the Corollary interconnect
> > used on a lot of >4-way IA32 boxes is not as fast as the two local
> > busses).
> 
> there's a reason for that.
> 
> > So, desiging for the "new" NUMAs is fine if your code goes into
> > production this year.  But if it is going into production in two to
> > three years, you might want to be thinking about some greater memory
> > latency ratios for the upcoming hardware configurations...
> 
> Disagree, but don't take me wrong, I'm not really suggesting to design
> for new numa only. I think linux should support both equally well, so
> some heuristic like in the scheduler will be mostly the same, but they
> will need different heuristics in some other place. For example the
> "less frequently used ram migration instead of taking advantage of free
> memory in the other nodes first" should fall in the old numa category.

This is where I think some of the topology representation work will
help (lse and the sourceforge large system foundry).  Various systems
will have various types of hierarchies in memory access, latency and
bandwidth.  I agree that heurestics may need to be tuned per arch type,
but look well at the history of hardware development and be aware that
a past trend has been that local and remote bus speeds and memory access
latencies have tended to stair step - with local busses stepping up much
more quickly and interconnect stepping up much more slowly.  And with
some architectures using three and four levels of hierarchy, the differences
between local and really, really remote will typically increase over a
five year (or so) window.

gerrit
