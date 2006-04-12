Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWDLKlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWDLKlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWDLKlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:41:24 -0400
Received: from dial169-27.awalnet.net ([213.184.169.27]:31749 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S932139AbWDLKlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:41:24 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 13:39:40 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604121117.01393.a1426z@gawab.com> <200604121936.16584.kernel@kolivas.org>
In-Reply-To: <200604121936.16584.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604121339.40563.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wednesday 12 April 2006 18:17, Al Boldi wrote:
> > Con Kolivas wrote:
> > > Single heavily cpu bound computationally intensive tasks (think
> > > rendering etc).
> >
> > Why do you need a switch for that?
>
> Because avoiding doing need_resched and reassessing priority at less
> regular intervals means less overhead, and there is always something else
> running on a pc. At low loads the longer timeslices and delayed preemption
> contribute considerably to cache warmth and throughput. Comparing
> staircase's sched_compute mode on kernbench at "optimal loads" (make -j4 x
> num_cpus) showed the best throughput of all the schedulers tested.

Great!

> > > Sorry I don't understand what you mean. Why do you say it's not fair
> > > (got a testcase?). What do you mean by "definitely not smooth". What
> > > is smoothness and on what workloads is it not smooth? Also by ia you
> > > mean what?
> >
> > ia=interactivity i.e: responsiveness under high load.
> > smooth=not jumpy i.e: run '# gears & morph3d & reflect &' w/o stutter
>
> Installed and tested here just now. They run smoothly concurrently here.
> Are you testing on staircase15?

staircase14.2-test3.  Are you testing w/ DRM?  If not then all mesa requests 
will be queued into X, and then runs as one task (check top d.1)

> > fair=non hogging i.e: spreading cpu-load across tasks evenly (top d.1)
>
> Only unblocked processes/threads where one depends on the other don't get
> equal share, which is as broken a testcase as relying on sched_yield. I
> have not seen a testcase demonstrating unfairness on current staircase.
> top shows me fair cpu usage.

Try ping -A (10x).  top d.1 should show skewed times.  If you have a fast 
machine, you may have to increase the load.

> > > Again I don't understand. Just how heavy a load is heavy? Your
> > > testcases are already in what I would call stratospheric range. I
> > > don't personally think a cpu scheduler should be optimised for load
> > > infinity. And how are you defining efficient? You say it doesn't
> > > "look" efficient? What "looks" inefficient about it?
> >
> > The idea here is to expose inefficiencies by driving the system into
> > saturation, and although staircase is more efficient than the default
> > 2.6 scheduler, it is obviously less efficient than spa.
>
> Where do you stop calling something saturation and start calling it
> absurd? By your reckoning staircase is stable to loads of 300 on one cpu.
> spa being stable to higher loads is hardly comparable given the
> interactivity disparity between it and staircase. A compromise is one that
> does both very well; not one perfectly and the other poorly.
>
> > > You want tunables? The only tunable in staircase is rr_interval which
> > > (in -ck) has an on/off for big/small (sched_compute) since most other
> > > numbers in between (in my experience) are pretty meaningless. I could
> > > export rr_interval directly instead... I've not seen a good argument
> > > for doing that. Got one?
> >
> > Smoothness control, maybe?
>
> Have to think about that one. I'm not seeing a smoothness issue.
>
> > > However there are no other tunables at all (just look at
> > > the code). All tasks of any nice level have available the whole
> > > priority range from 100-139 which appears as PRIO 0-39 on top.
> > > Limiting that (again) changes the semantics.
> >
> > Yes, limiting this could change the semantics for the sake of fairness,
> > it's up to you.
>
> There is no problem with fairness that I am aware of.

Let's see after you retry the tests.

Thanks!

--
Al

