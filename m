Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbTLNCSv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 21:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTLNCSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 21:18:50 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:40376 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265336AbTLNCSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 21:18:48 -0500
Message-ID: <3FDBC876.3020603@cyberone.com.au>
Date: Sun, 14 Dec 2003 13:18:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au> <brgeo7$huv$1@gatekeeper.tmr.com>
In-Reply-To: <brgeo7$huv$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <3FDAB517.4000309@cyberone.com.au>,
>Nick Piggin  <piggin@cyberone.com.au> wrote:
>
>| Possibly. But it restricts your load balancing to a specific case, it
>| eliminates any possibility of CPU affinity: 4 running threads on 1 HT
>| CPU for example, they'll ping pong from one cpu to the other happily.
>
>Huh? I hope you meant sibling and not CPU, here.
>

It was late when I wrote that! You are right, of course.

>
>
>| I could get domains to do the same thing, but at the moment a CPU only looks
>| at its sibling's runqueue if they are unbalanced or is about to become idle.
>| I'm pretty sure domains can do anything shared runqueues can. I don't know
>| if you're disputing this or not?
>
>Shared runqueues sound like a simplification to describe execution units
>which have shared resourses and null cost of changing units. You can do
>that by having a domain which behaved like that, but a shared runqueue
>sounds better because it would eliminate the cost of even considering
>moving a process from one sibling to another.
>

You are correct, however it would be a miniscule cost advantage,
possibly outweighed by the shared lock, and overhead of more
changing of CPUs (I'm sure there would be some cost).

>
>Sorry if I'm mixing features of Con/Nick/Ingo approaches here, I just
>spent some time looking at the code for several approaches, thinking
>about moving jobs from the end of the runqueue vs. the head, in terms of
>fair vs. overall cache impact.
>
>| >But this is my point.  Scheduling is one part of the problem.  I want
>| >to be able to have the arch-specific code feed in a description of
>| >memory and cpu distances, bandwidths and whatever, and have the
>| >scheduler, slab allocator, per-cpu data allocation, page cache, page
>| >migrator and anything else which cares adjust itself based on that.
>
>And would shared runqueues not fit into that model?
>

Shared runqueues could be built from that model

>
>
>| (Plus two threads / siblings per CPU, right?)
>| 
>| I agree with you here. You know, we could rename struct sched_domain, add
>| a few fields to it and it becomes what you want. Its a _heirachical set_
>| of _sets of cpus sharing a certian property_ (underlining to aid grouping.
>| 
>| Uniform access to certian memory ranges could easily be one of these
>| properties. There is already some info about the amount of cache shared,
>| that also could be expanded on.
>| 
>| (Perhaps some exotic architecture  would like scheduling and memory a bit
>| more decoupled, but designing for *that* before hitting it would be over
>| engineering).
>| 
>| I'm not going to that because 2.6 doesn't need a generalised topology
>| because nothing makes use of it. Perhaps if something really good came up
>| in 2.7, there would be a case for backporting it. 2.6 does need improvements
>| to the scheduler though.
>
>| But if sched domains are accepted, there is no need for shared runqueues,
>| because as I said they can do anything sched domains can, so the code would
>| just be a redundant specialisation - unless you specifically wanted to share
>| locks & data with siblings.
>
>I doubt the gain would be worth the complexity, but what do I know?
>

Sorry I didn't follow, gain and complexity of what?

Earlier in the thread Ingo thought my approach is simpler. code size is the
same size, object size for my patch is significantly smaller, and it does
more. Benchmarks have so far shown that my patch is as performant as shared
runqueues.


