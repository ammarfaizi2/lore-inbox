Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261479AbTCGK31>; Fri, 7 Mar 2003 05:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCGK31>; Fri, 7 Mar 2003 05:29:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37791 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261479AbTCGK30>;
	Fri, 7 Mar 2003 05:29:26 -0500
Date: Fri, 7 Mar 2003 11:39:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Martin Waitz <tali@admingilde.org>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1046993765.715.101.camel@phantasy.awol.org>
Message-ID: <Pine.LNX.4.44.0303071132200.8284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Robert Love wrote:

> > but the kernel should get the chance to frequently reschedule
> > when interactivity is needed.
> 
> I understand your point, but we get that now without using super small
> timeslices.

well, the -A6 patch does reduce the timeslice length, it's certainly one
tool to improve "interactivity" of CPU-bound tasks. At the moment we
cannot reduce it arbitrarily though, because right now the way to
implement different CPU-sharing priorities is via the timeslice
calculator. With 100 msec default timeslices, the biggest difference one
can get is a 10 msec timeslice for a nice +19 task, and a 100 msec
timeslice for a nice 0 task. Ie. a nice +19 CPU-bound task uses up ~10% of
CPU time while a nice 0 task uses up 90% of CPU time, if both are running
at once - roughly.

i have planned to add a new interface to solve this generic problem,
basically a syscall that enables the setting of the default timeslice
length - which gives one more degree of freedom to applications. Games
could set this to a super-low value to get really good 'keypress latency'
even in the presence of other CPU hogs. Compilation jobs would use the
default long timeslices, to maximize caching benefits. And we could
lengthen the timeslice of nice +19 tasks as well. The complexity here is
to decouple the timeslice length from CPU-sharing priorities. I've got
this on my list ...

	Ingo

