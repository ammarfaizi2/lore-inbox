Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281652AbRKPXrh>; Fri, 16 Nov 2001 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281653AbRKPXr1>; Fri, 16 Nov 2001 18:47:27 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:53682 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281652AbRKPXrO>; Fri, 16 Nov 2001 18:47:14 -0500
Date: Fri, 16 Nov 2001 15:47:01 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
Message-ID: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011116122005.E1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161419180.998-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111161419180.998-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Nov 16, 2001 at 02:44:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 02:44:30PM -0800, Davide Libenzi wrote:
> 
> I do not use a separate queue coz, if it's single, it becomes a common
> lock for all CPUs.
> RT tasks are scheduled as usual and the only problem arises in
> reschedule_idle() when an RT task is pushed onto the run queue when
> 1) on its CPU it is _not_ running the idle
> 2) on its CPU is running another RT task with higher priority
> 
> In that case a "good CPU" discovery loop is triggered, the task is moved
> on that CPU runqueue, need_resched is set, an IPI is sent and on return
> from the remote CPU IPI  path the RT task is run.
> A good solution would be ( i'm not doing it now ), in setscheduler() to
> move the task in a way to have an even distribution of RT tasks among
> CPUs.
> 
> - Davide

Davide,

Suppose you have a 2 CPU system with 4 runnable tasks.  3 of these
tasks are realtime with the same realtime priority and the other is
an ordinary SCHED_OTHER task.  The task distribution on the runqueues
looks something like this.

CPU 0             CPU 1
---------         ---------
RT Task A         RT Task B
Other Task C      RT Task D

Task A and Task B are currently running on the 2 CPUs.  Now, Task A
voluntarily gives up CPU 0 and Task B is still running on CPU 1.
At this point, Task D should be chosen to run on CPU 0.  Correct?
Isn't this a required RT semantic?  I'm curious how you plan on
accomplishing this.

Regards,
-- 
Mike
