Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWDLISl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWDLISl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWDLISl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:18:41 -0400
Received: from dial169-140.awalnet.net ([213.184.169.140]:24581 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S932104AbWDLISk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:18:40 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 11:17:01 +0300
User-Agent: KMail/1.5
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604120841.43459.a1426z@gawab.com> <200604121622.02341.kernel@kolivas.org>
In-Reply-To: <200604121622.02341.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604121117.01393.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 12 Apr 2006 03:41 pm, Al Boldi wrote:
> > Con Kolivas wrote:
> > > Which is fine because sched_compute isn't designed for heavily
> > > multithreaded usage.
> >
> > What's it good for?
>
> Single heavily cpu bound computationally intensive tasks (think rendering
> etc).

Why do you need a switch for that?

> > > The same mechanism that is responsible for
> > > maintaining fairness is also responsible for creating its
> > > interactivity. That's what I mean by "interactive by design", and what
> > > makes it different from extracting interactivity out of other designs
> > > that have some form of estimator to add unfairness to create that
> > > interactivity.
> >
> > Yes, but staircase isn't really fair, and it's definitely not smooth. 
> > You are trying to get ia by aggressively attacking priority which kills
> > smoothness, and is only fair with a short run-queue.
>
> Sorry I don't understand what you mean. Why do you say it's not fair (got
> a testcase?). What do you mean by "definitely not smooth". What is
> smoothness and on what workloads is it not smooth? Also by ia you mean
> what?

ia=interactivity i.e: responsiveness under high load.
smooth=not jumpy i.e: run '# gears & morph3d & reflect &' w/o stutter
fair=non hogging i.e: spreading cpu-load across tasks evenly (top d.1)

> > > I know you're _very_ keen on the idea of some autotuning but I think
> > > this is the wrong thing to autotune. The whole point of staircase is
> > > it's a simple design without any interactivity estimator. It uses pure
> > > cpu accounting to change priority and that is a percentage which is
> > > effectively already tuned to the underlying cpu. Any
> > > benchmarking/aggressiveness "tuning" would undo the (effectively) very
> > > simple design.
> >
> > I like simple designs.  They tend to keep things to the point and aid
> > efficiency.  But staircase doesn't look efficient to me under heavy
> > load, and I would think this may be easily improved.
>
> Again I don't understand. Just how heavy a load is heavy? Your testcases
> are already in what I would call stratospheric range. I don't personally
> think a cpu scheduler should be optimised for load infinity. And how are
> you defining efficient? You say it doesn't "look" efficient? What "looks"
> inefficient about it?

The idea here is to expose inefficiencies by driving the system into 
saturation, and although staircase is more efficient than the default 2.6 
scheduler, it is obviously less efficient than spa.

> > Also, can you export  lowest/best prio as well as timeslice and friends
> > to procfs/sysfs?
>
> You want tunables? The only tunable in staircase is rr_interval which (in
> -ck) has an on/off for big/small (sched_compute) since most other numbers
> in between (in my experience) are pretty meaningless. I could export
> rr_interval directly instead... I've not seen a good argument for doing
> that. Got one? 

Smoothness control, maybe?

> However there are no other tunables at all (just look at
> the code). All tasks of any nice level have available the whole priority
> range from 100-139 which appears as PRIO 0-39 on top. Limiting that
> (again) changes the semantics.

Yes, limiting this could change the semantics for the sake of fairness, it's 
up to you.

> And another round of thanks :) But many more questions.

No problem.

Thanks!

--
Al

