Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281599AbRKPWfx>; Fri, 16 Nov 2001 17:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281597AbRKPWfn>; Fri, 16 Nov 2001 17:35:43 -0500
Received: from [208.129.208.52] ([208.129.208.52]:50181 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281603AbRKPWfb>;
	Fri, 16 Nov 2001 17:35:31 -0500
Date: Fri, 16 Nov 2001 14:44:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
In-Reply-To: <20011116122005.E1152@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0111161419180.998-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Mike Kravetz wrote:

> As you may know, a few of us are experimenting with multi-runqueue
> scheduler implementations.  One area of concern is where to place
> realtime tasks.  It has been my assumption, that POSIX RT semantics
> require a specific ordering of tasks such as SCHED_FIFO and SCHED_RR.
> To accommodate this ordering, I further believe that the simplest
> solution is to ensure that all realtime tasks reside on the same
> runqueue.  In our MQ scheduler we have a separate runqueue for all
> realtime tasks.  The problem is that maintaining a separate realtime
> runqueue is a pain and results in some fairly complex/ugly code.
>
> Since I'm not a realtime expert, I would like to ask if my assumption
> about strict ordering of RT tasks is accurate.  Also, is anyone aware
> of other ways to approach this problem?

I do not use a separate queue coz, if it's single, it becomes a common
lock for all CPUs.
RT tasks are scheduled as usual and the only problem arises in
reschedule_idle() when an RT task is pushed onto the run queue when
1) on its CPU it is _not_ running the idle
2) on its CPU is running another RT task with higher priority

In that case a "good CPU" discovery loop is triggered, the task is moved
on that CPU runqueue, need_resched is set, an IPI is sent and on return
from the remote CPU IPI  path the RT task is run.
A good solution would be ( i'm not doing it now ), in setscheduler() to
move the task in a way to have an even distribution of RT tasks among
CPUs.




- Davide



