Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277807AbRJWPv4>; Tue, 23 Oct 2001 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277806AbRJWPvq>; Tue, 23 Oct 2001 11:51:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60942 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S277805AbRJWPvc>; Tue, 23 Oct 2001 11:51:32 -0400
Date: Tue, 23 Oct 2001 11:46:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] A nicer nice scheduling
In-Reply-To: <Pine.LNX.4.10.10110221821120.25216-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.3.96.1011023113659.26730B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Mark Hahn wrote:

> > the idle process were another thing instead of just a low priority
> > process, it could be treated in some special ways WRT memory management.
> 
> why?  it's clearly optimal to discard pages from ultra-high-prio
> processes as well.  the best choice of pages to discard seems to 
> mainly depend on frequency or recency of use.
> 
> there's no reason that nice (or better yet, mmnice)
> couldn't be used in VM choices.

If the current load is high the idle process will get no time, and its
pages are best swapped. Choosing to do this (or not) is one of the things
I meant by special treatment. More information can mean better choices.
 
> > not bad if it produces better results. I always thought per-process page
> > fault rates would be useful, if some weighted attention to that would
> > reduce the total system i/o rate.
> 
> they existed around 2.3.40, I think.  it's not clear that this kind
> of information is really that useful, since "process that's causing
> lots of faults" is sometimes the one you want to give *more* memory to,
> and sometimes one you want to starve.

Exactly my point, I didn't recall that it had been tried. But clearly if
you have several processes which are long running and one has a much
higher fault rate than the others, there is certainly a possibility that
the systyem will run better by giving that process more RSS.
 
> > Anyway, that was my thinking, if the load is high a true idle process
> > could be treated as a special case, including running a small number of
> > them instead of having a lot of low priority processes doing not much if
> > too many were started. I can remember batch processing, and for real idle
> > jobs that's not a bad thing.
> 
> I think there are vanishingly few procs that could tolerate batch
> behavior these days, at least in the desktop/server domain.
> and the textbook answer is that this sort of thing should be 
> handled by a separte scheduler (usually they're called short-term
> and long-term) - that is, if you have a special workload that naturally
> like batches, then you should have a higher-level queue-manager
> (perl would be plenty) that submits a single job to the short-term
> manager and lets it run to completion.

But that's not an idle process, it competes with the rest of the system.
There are quite a few systems on which I'd love to run things like
setiathome, ray tracing, etc, if they wouldn't impact the CPU to
production. Obviously this only applies if the system has enough memory,
but in general that's true.
 
> in fact, the only case I can think of where batching still takes 
> place is number-crunching.  and I would dearly love to have better
> control over the mini-supercomputer I run (112 alphas!).

Even if batching meant running only one "idle process" at a time for,
perhaps, ten seconds at a go, then running the next. At least they
wouldn't compete with other jobs, and would be likely to get some actual
work done while running.

I think the idle task has merit, but I admit it's mainly because I have
lots of things I'd like to run on big servers as long as they didn't hurt.
Kernel compiles, for instance, if they didn't hurt response.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

