Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275338AbTHSEHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275339AbTHSEHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:07:22 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:49555 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275338AbTHSEHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:07:15 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F419449.4070104@cyberone.com.au>
References: <1061261666.2094.15.camel@orbiter>
	 <3F419449.4070104@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1061266033.2900.43.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 00:07:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >this is contrary to all process scheduling theory i've read, and also
> >contrary to my intuition.
> Yep.

Yep? What this ack does mean? Books, papers and old unix ways are wrong?
or beyond this theory, practice shows otherwise?

> Its done this way because this is really how the priorities are
> enforced. With some complicated exceptions, every task will be
> allowed to complete 1 timeslice before any task completes 2
> (assuming they don't block).
> 
> So higher priority tasks need bigger timeslices.

Frankly i don't get this part. Maybe i should study the code more, or
perhaps you have an illuminating explanation?

Anyway i always tought linux default timeslice of 100 ms is way too long
for desktop uses. Starting with this in mind, i think that a 10 ms
timeslice should bring back good interactive feel, and by using longer
timeslices for (lower prio) cpu-bound processes, we can save some costly
context switches.

Unfortunatly i'm unable to test those ideas right now but i share them,
maybe it can help other's work.

- (previously mentionned) higher prio tasks should use small timeslices
and lower prio tasks, longer ones. i think, maybe falsely, that this can
lower context switch rate for cpu-bound tasks. by using up to 200 ms
slices instead of 10 ms...

- (previously mentionned) use dynamic priority to calculate timeslice
length.

- maybe adjust the max timeslice length depending on how many tasks are
running/ready.

- timeslices in cycles, instead of ticks, to scale with cpu_khz. maybe
account for the cpu caches size to decide the larger timeslice length.

- a /proc tunable might be needed to let the user choose the
interactivity vs efficiency compromise. for example, with 100 background
tasks, does the user want the most efficiency or prefer wasting some
cycles to get a smoother progress between jobs?

- nanoseconds, or better, cycle accurate (rdtsc) timeslice accouting, it
may help heuristics.

- maybe add some instrumentations, like keeping static and dynamic
priorities, task_struct internal variables and other relevant data for
all processes with each scheduling decisions, that a userspace program
can capture and analyse, to better fine-tune the heuristics.

- lastly, it may be usefull to better encapsulate the scheduler to ease
adding alternative scheduler, much like the i/o schedulers work...


Eric St-Laurent

