Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVJCB0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJCB0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVJCB0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:26:16 -0400
Received: from free.hands.com ([83.142.228.128]:20167 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932109AbVJCB0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:26:15 -0400
Date: Mon, 3 Oct 2005 02:26:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003012604.GO6290@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.63.0510021922290.27456@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510021922290.27456@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 07:26:21PM -0400, Rik van Riel wrote:
> On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> > On Sun, Oct 02, 2005 at 05:05:42PM -0400, Rik van Riel wrote:
> 
> > > Linux already has a number of scalable SMP synchronisation
> > > mechanisms. 
> > 
> >  ... and you are tied in to the decisions made by the linux kernel
> >  developers.
> > 
> >  whereas, if you allow something like a message-passing design (such as
> >  in the port of the linux kernel to l4), you have the option to try out
> >  different underlying structures - _without_ having to totally redesign
> >  the infrastructure.
> 
> Infrastructure is not what matters when it comes to SMP
> scalability on modern systems, since lock contention is
> not the primary SMP scalability problem.
> 
> Due to the large latency ratio between L1/L2 cache and
> RAM, the biggest scalability problem is cache invalidation
> and cache bounces.
> 
> Those are not solvable by using another underlying
> infrastructure - they require a reorganization of the
> datastructures on top, the data structures in Linux.

 ... ah, but what about in hardware?  what if you had hardware support
 for

 _plus_ what if you had some other OS primitives implemented
 in hardware, the use of which allowed you to avoid or minimise
 cache invalidation problems?

 not entirely, of course, but enough to make up for SMP's deficiencies.


> Note that message passing is by definition less efficient
> than SMP synchronisation mechanisms that do not require
> data to be exchanged between CPUs, eg. RCU or the use of
> cpu-local data structures.

 how about message passing by reference - a la c++? 

 i.e. using an "out-of-band" parallel message bus, you pass
 the address in a NUMA or SMP area of memory that is granted
 to a specific processor, which says to another processor oh
 something like "you now have access to this memory: by the time
 you get this message i will have already cleared the cache so
 you can get it immediately".

 that sort of thing.

 _and_ you use the parallel message bus to communicate memory
 allocation, locking, etc.

 _and_ you use the parallel message bus to implement semaphores and
 mutexes.

 _and_ if the message is small enough, you just pass the message across
 without going via external memory.

 
 ... but i digress - but enough to demonstrate, i hope, that
 this isn't some "pie-in-the-sky" thing, it's one hint at a
 solution to the problem that a lot of hardware designers haven't
 been able to solve, and up until now they haven't had to even
 _consider_ it.

 and they've avoided the problem by going "multi-core" and going
 "hyperthreading".

 but, at some point, hyperthreading isn't going to cut it, and at some
 point multi-core isn't going to cut it.

 and people are _still_ going to expect to see the monster
 parallelism (32, 64, 128 parallel hardware threads) as
 "one processor".

 the question is - and i iterate it again: can the present
 linux kernel design _cope_ with such monster parallelism?

 answer, at present, as maintained as-it-is, not a chance.

 question _that_ raises: do you _want_ to [make it cope with such
 monster parallelism]?

 and if the answer to that is "no, definitely not", then the
 responsibility can be offloaded onto a microkernel, e.g. the L4
 microkernel, and it _just_ so happens that the linux kernel has already
 been ported to L4.

 i raise this _one_ route - there are surely going to be others.

 i invite you to consider discussing them.
 
 LIKE FRIGGIN ADULTS, unlike the very spiteful comments i've
 received indicate that some people would like to do (no i
 don't count you in that number, rik, just in case you thought
 i was because i'm replying direct to you!).


> >  p.s. yes i do know of a company that has improved on SMP.
> 
> SGI ?  IBM ?
 
 no, they're a startup.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
