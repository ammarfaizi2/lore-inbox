Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVDDF4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDDF4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDF4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:56:41 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:13496 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261723AbVDDF4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:56:31 -0400
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
	benchmark result on recent 2.6 kernels]
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, kenneth.w.chen@intel.com, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050403205558.753f2b55.pj@engr.sgi.com>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	 <20050402145351.GA11601@elte.hu> <20050402215332.79ff56cc.pj@engr.sgi.com>
	 <20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com>
	 <20050403071227.666ac33d.pj@engr.sgi.com> <20050403152413.GA26631@elte.hu>
	 <20050403160807.35381385.pj@engr.sgi.com> <4250A195.5030306@yahoo.com.au>
	 <20050403205558.753f2b55.pj@engr.sgi.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 15:56:24 +1000
Message-Id: <1112594184.5077.9.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 20:55 -0700, Paul Jackson wrote:

> But if we knew the CPU hierarchy in more detail, and if we had some
> other use for that detail (we don't that I know), then I take it from
> your comment that we should be reluctant to push those details into the
> sched domains.  Put them someplace else if we need them.
> 

In a sense, the information *is* already there - in node_distance.
What I think should be done is probably to use node_distance when
calculating costs, and correlate that with sched-domains as best
we can.

I've got an idea of how to do it, but I'll wait until Ingo gets the
fundamentals working wel before I have a look.

> 
> One question - how serious do you view difference in migration cost
> between say 21.7 and 25.3, two of the cacheflush times I reported on a
> small SN2?
> 
> I'm guessing that this is probably below the noise threshold, at least
> as far as scheduler domains, schedulers and migration care, unless and
> until some persuasive measurements show a situation in which it matters.
> 

Yes, likely below noise. There is an issue with a behavioural
transition point in the wakeup code where you might see good
behaviour with 21 and bad with 25, or vice versa on some workloads.
This is fixed in the scheduler patches coming through -mm though.

But I wasn't worried so much about the absolute value not being
right, rather it maybe not being deterministic. So maybe depending
on what CPU gets assigned what cpuid, you might get different
values on identical machines.

> As you say - not an exact science.
> 



