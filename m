Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUGBCyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUGBCyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 22:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUGBCyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 22:54:17 -0400
Received: from holomorphy.com ([207.189.100.168]:8123 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266389AbUGBCyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 22:54:13 -0400
Date: Thu, 1 Jul 2004 19:53:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, mpm@selenic.com, paul@linuxaudiosystems.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040702025359.GH21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Andrew Morton <akpm@osdl.org>, mpm@selenic.com,
	paul@linuxaudiosystems.com, linux-kernel@vger.kernel.org
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040701180356.GI5414@waste.org> <20040701181401.GB21066@holomorphy.com> <20040701154554.30063e97.akpm@osdl.org> <20040702004538.GF21066@holomorphy.com> <40E4BC89.8000206@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E4BC89.8000206@bigpond.net.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I've not seen much deep material there. Policy tweaks seem to be
>> what's gone on in mainline, and frankly most of the purported rewrites
>> are just that. I guess the ones that nuked the duelling queue silliness
>> are trying qualify but even they're leaving the load balancer untouched
>> and are carrying over large fractions of their predecessors unaltered.

On Fri, Jul 02, 2004 at 11:38:17AM +1000, Peter Williams wrote:
> That's because it's not all bad (or the problems are minor and can wait 
> until later).

Whatever that has to do with, it doesn't really make the fiddling around
going on even noticeable. Hell, I do end-luserish crap too (amazing, I
actually appear to need luserspace to get code written) I've yet to see
a visible change in scheduler behavior in that context across all of
2.4 and 2.5 (and in fact since the earliest Linux kernels I've ever run)
apart from a reduction in cpu time spent in the scheduler itself
associated with (you guessed it) the merge of the incremental epoch
expiry stuff mingo did around early 2.5 (or at least that's the best
description I can come up with the algorithm, as it doesn't resemble any
of the normal algorithms). I suspect widespread placebo effects.


William Lee Irwin III wrote:
>> The stuff that's gone around looks minor. It's not like they're teaching
>> sched.c to play cpu tetris for gang scheduling or Kalman filtering
>> profiling feedback to stripe tasks using different cpu resources across
>> SMT siblings or playing graph games to meet RT deadlines, so it doesn't
>> look like very much at all is going on to me.

On Fri, Jul 02, 2004 at 11:38:17AM +1000, Peter Williams wrote:
> To my mind, scheduling and load balancing are ALMOST orthogonal 
> concepts.  Scheduling is concerned with doing a useful job within a 
> single CPU and load balancing is about distributing tasks/load among the 
> available CPUs.  To a large extent these are independent and are being 
> worked on separately.  I am one of those fiddling with the schedulers 
> but I'm leaving load balancing alone as it seems to me that the NUMA and 
> hyper threading developers are the main players for that component.
> To my mind the only contribution the scheduler component MAY want to 
> make to load balancing would be to have some say in which tasks are 
> chosen for migration.  I don't think that any of the currently proposed 
> schedulers have a strong need to change the current mechanism(s) for 
> selecting which tasks get migrated.  If you think otherwise please share 
> your thoughts?

That's an expedient program structure. There is no independence. Those
are examples of things that would have qualified as having been remotely
visible changes and not myriads of infinitesimal intra-queue twiddlings.

No, I don't want to touch scheduling policy (or anything else infested
with such massive quantities of holy penguin pee) with a 10-foot pole.


William Lee Irwin III wrote:
>> It's pretty obvious why everyone and their brother is grinding out
>> purported scheduler rewrites: the code is self-contained,

On Fri, Jul 02, 2004 at 11:38:17AM +1000, Peter Williams wrote:
> The main reason is that the standard scheduler is a bit of a mess. The 
> fact that the code is self contained just makes it easier to modify 
> without touching lots of files. It's not the reason why the changes are 
> being tried.

It means the barrier to entry is very low.


William Lee Irwin III wrote:
>> however,
>> nothing interesting is coming of all this. Never been for have so many
>> patches been written against the same file, accomplishing so little.

s/been for/before/

I wonder why I've started making homophone errors only in the past 5 years
where beforehand they were very rare. It's not like I started sounding out
words when I read or anything idiotic like that.


-- wli
