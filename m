Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUIIVJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUIIVJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUIIVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:07:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51425 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266196AbUIIVCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:02:12 -0400
Subject: Re: voluntary-preemption: understanding latency trace
From: Lee Revell <rlrevell@joe-job.com>
To: Kevin Hilman <kjh-lkml@hilman.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <83656nk9mk.fsf@www2.muking.org>
References: <83656nk9mk.fsf@www2.muking.org>
Content-Type: text/plain
Message-Id: <1094763737.1362.325.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 17:02:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 06:41, Kevin Hilman wrote:
> I'm seeing a mismatch between my manually-measured timings and the
> timings I see in /proc/latency_trace.
> 
> I've got a SCHED_FIFO kernel thread at the highest priority
> (MAX_USER_RT_PRIO-1) and it's sleeping on a wait queue.  The wake is
> called from an ISR.  Since this thread is the highest priority in the
> system, I expect it to run before the ISR threads and softIRQ threads
> etc. 
> 
> In the ISR I sample sched_clock() just before the call to wake_up()
> and in the thread I sample sched_clock() again just after the call to
> sleep.  I'm seeing an almost 4ms latency between the call to wake_up
> and the actual wakeup.  However, in /proc/latency_trace, the worst
> latency I see during the running of this test is <500us.
> 
> I must be misunderstanding how the latency traces are
> started/stopped.  Can anyone shed some light?  Thanks.
> 
> My current setup is using -R5, running on a PII 400MHz system.
> 

Ingo, any ideas here?  Looks like maybe the use of sched_clock is the
problem.

Lee

