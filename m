Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWBURJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWBURJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWBURJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:09:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:10939 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932329AbWBURJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:09:27 -0500
Subject: Re: 2.6.15-rt17
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20060221155548.GA30146@elte.hu>
References: <20060221155548.GA30146@elte.hu>
Content-Type: text/plain
Organization: IBM
Date: Tue, 21 Feb 2006 11:23:40 -0600
Message-Id: <1140542620.21876.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 16:55 +0100, Ingo Molnar wrote:
> i have released the 2.6.15-rt17 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> lots of changes all across the map. There are several bigger changes:
> 
> the biggest change is the new PI code from Esben Nielsen, Thomas 
> Gleixner and Steven Rostedt. This big rework simplifies and streamlines 
> the PI code, and fixes a couple of bugs and races:
> 
>   - only the top priority waiter on a lock is enqueued into the pi_list
>     of the task which holds the lock. No more pi list walking in the
>     boost case.
> 
>   - simpler locking rules
> 
>   - fast Atomic acquire for the non contended case and atomic release 
>     for non waiter case is fully functional now
> 
>   - use task_t references instead of thread_info pointers
> 
>   - BKL handling for semaphore style locks changed so that BKL is
>     dropped before the scheduler is entered and reaquired in the return
>     path. This solves a possible deadlock situation in the BKL reacquire
>     path of the scheduler.
> 
> another change is the reworking of the SLAB code: it now closely matches 
> the upstream SLAB code, and it should now work on NUMA systems too 
> (untested though).
> 
> the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
> code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
> fix was to rework the tasklet code to get rid of the 'retrigger 
> softirqs' approach.
> 
> other changes: various hrtimers fixes, latency tracer enhancements - and 
> more. (Robust-futexes are not expected to work in this release.)
> 
> please report any new breakages, and re-report any old breakages as 
> well.
> 
> to build a 2.6.15-rt17 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17

http://people.redhat.com/mingo/realtime-preempt/patch-2.6.16-rt17 ???

-tim

> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

