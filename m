Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTLJRsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTLJRsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:48:43 -0500
Received: from holomorphy.com ([199.26.172.102]:4067 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263788AbTLJRsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:48:35 -0500
Date: Wed, 10 Dec 2003 09:47:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210174757.GK19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch> <20031209193801.GF19856@holomorphy.com> <20031210135829.GA18370@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210135829.GA18370@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> Actually, I'm rather well on my way wrapping things up. I documented
> in detail how much 2.6 sucks in this area and where the potential for
> improvements would have likely been, but now I've got a deadline to
> meet and other things on my plate.

Well, it'd be nice to see the code, then.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> For me this discussion just confirmed that my approach fails to draw much
> interest, either because there are better alternatives or because heavy
> paging and medium thrashing are generally not considered interesting
> problems.

They're worthwhile; I didn't even realize there were such problems until
you pointed them out. I had presumed it was due to physical scanning.


On Tue, 09 Dec 2003 11:38:01 -0800, William Lee Irwin III wrote:
>> This assessment is inaccurate. The performance metrics are not entirely
>> useless, and it's rather trivial to recover data useful for modern
>> scenarios based on them. The driving notion from the iron age (I guess

On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> I said _strategies_ rather than papers or research because I realize
> that the metrics can be an important part of the modern picture. It's
> just the ancient recipes that once solved the problem that are useless
> for typical modern usage patterns.

Hmm. There were a wide variety of algorithms.


On Tue, 09 Dec 2003 11:38:01 -0800, William Lee Irwin III wrote:
>> The above explains how and why they are relevant.
>> It's also not difficult to understand why it goes wrong: the operation
>> is too expensive.

On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> What goes wrong is that once you start suspending tasks, you have a
> hard time telling the interactive tasks apart from the batch load.
> This may not be much of a problem on a 10x overcommit system, because
> that's presumably quite unresponsive anyway, but it does matter a lot if
> you have an interactive system that just crossed the border to thrashing.

It's effectively a form of longer-term process scheduling.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> Our apparent differences come from the fact that we try to solve
> different problems as you correctly noted: You are concerned with
> extreme overcommit, while I am concerned that 2.6 takes several times
> longer than 2.4 to complete a task under slight overcommit.

Yes, my focus is pushing back the point of true thrashing as opposed to
the interior points of the range.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> I have no reason to doubt that load control will help you solve your
> problem. It may help with medium thrashing and it might even keep
> latency within reasonable bounds. I do think, however, that we should
> investigate _first_ how we lost over 50% of the performance we had in
> 2.5.40 for both compile benchmarks.

Perfectly reasonable.


On Tue, 09 Dec 2003 11:38:01 -0800, William Lee Irwin III wrote:
>> Well, I guess I might as well help with your paper. If the demotion
>> criteria you're using are anything like what you posted, they risk
>> invalidating the results, since they're apparently based on something
>> worse than random.

On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> Worse than random may still improve throughput, though, compared to
> doing nothing, right? And I did measure improvements.

I didn't see any of the methods compared to no load control, so I don't
have any information on that.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> There are variables other than the demotion criteria that I found can
> be important, to name a few:
> - Trigger: Under which circumstances is suspending any processes
>   considered? How often?

This is generally part of the load control algorithm, but it
essentially just tries to detect levels of overcommitment that would
degrade performance so it can resolve them.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> - Eviction: Does regular pageout take care of the memory of a suspended
>   process, or are pages marked old or even unmapped upon stunning?

This is generally unmapping and evicting upon suspension. The effect
isn't immediate anyway, since io is required, and batching the work for
io contiguity etc. is a fair amount of savings, so there's little or no
incentive to delay this apart from keeping io rates down to where user
io and VM io aren't in competition.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> - Release: Is the stunning queue a simple FIFO? How long do the
>   processes stay there? Does a process get a bonus after it's woken up
>   again -- bigger quantum, chunk of free memory, prepaged working set
>   before stunning?

It's a form of process scheduling. Memory scheduling policies are not
discussed very much in the sources I can get at, so some synthesis may
be required unless material can be found on that, but in general this
isn't a very interesting problem (at least not since the 70's or earlier).

FreeBSD has an implementation of some of this we can all look at,
though it doesn't illustrate a number of the concepts.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> There's quite a bit of complexity involved and many variables will depend
> on the scenario. Sort of like interactivity, except lots of people were
> affected by the interactivity tuning and only few will notice and test
> load control.

It's basically just process scheduling, so I don't see an issue there.


On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> The key question with regards to load control remains: How do you keep a
> load controled system responsive? Cleverly detect interactive processes
> and spare them, or wake them up again quickly enough? How? Or is the
> plan to use load control where responsiveness doesn't matter anyway?

It's more in the interest of graceful degradation and relative
improvement than meeting absolute response time requirements. i.e.
making the best of a bad situation. Interactivity heuristics would
presumably be part of a memory scheduling policy as they are for a cpu
scheduling policy, but there is some missing information there. I
suppose that's where synthesis is required.


-- wli
