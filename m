Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTHTQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbTHTQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:28:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3333 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261851AbTHTQ2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:28:50 -0400
Date: Wed, 20 Aug 2003 12:18:39 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Theurer <habanero@us.ibm.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       David Lang <david.lang@digitalinsight.com>,
       Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
In-Reply-To: <200308200859.36164.habanero@us.ibm.com>
Message-ID: <Pine.LNX.3.96.1030820121309.14414C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, Andrew Theurer wrote:

> On Tuesday 19 August 2003 23:11, Bill Davidsen wrote:

> > Hum, I *guess* that if you are using some "mean time between dispatches"
> > to tune time slice you could apply a CPU speed correction, but mixed speed
> > SMP is too corner a case for me. I think if you were tuning time slice by
> > mean time between dispatches (or similar) you could either apply a
> > correction, set affinity low to keep jobs changing CPUs, or just ignore
> > it.
> 
> One could continue this thinking (more load_balance corrections than 
> timeslice, IMO) on to SMT processors, where the throughput of a sibling is 
> highly dependent on what the other siblings are doing in the same core.  For 
> example, in a dual proc system, the first physical cpu with one task will run 
> much faster than the second cpu with 2 tasks.  Actually, using a shared 
> runqueue would probably fix this (something we still don't have in 2.6-test).
> 
> But one other thing, and maybe this has been brought up before (sorry, I have 
> not been following all the discussions), but why are we not altering 
> timeslice based on the runqueue length for that processor?  Would it not make 
> sense, for the sake of good interactivity, to lower all the timeslices when 
> we have a longer runqueue?

The length of the runqueue isn't really the issue, if you have a lot of
interractive processes they may only run a ms or less each. My suggestion
is that the time between dispatches (time spent waiting on the runqueue)
was a better indicator, and that timeslices could be sized based on how
long a process waited for a CPU. And ordering would also be subject to
priority effects, of course.

My thought is that this would tune the system based on current overall
behaviour, and also adjust for CPU clock speed changes, not as rare as
they once were.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

