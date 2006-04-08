Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWDHALI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDHALI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWDHALI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:11:08 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:33202 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751342AbWDHALH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:11:07 -0400
Message-ID: <4436FF98.3050604@bigpond.net.au>
Date: Sat, 08 Apr 2006 10:11:04 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu>
In-Reply-To: <20060406073753.GA18349@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 8 Apr 2006 00:11:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Darren Hart <darren@dvhart.com> wrote:
> 
>> My last mail specifically addresses preempt-rt, but I'd like to know 
>> people's thoughts regarding this issue in the mainline kernel.  Please 
>> see my previous post "realtime-preempt scheduling - rt_overload 
>> behavior" for a testcase that produces unpredictable scheduling 
>> results.
> 
> the rt_overload feature i intend to push upstream-wards too, i just 
> didnt separate it out of -rt yet.
> 
> "RT overload scheduling" is a totally orthogonal mechanism to the SMP 
> load-balancer (and this includes smpnice too) that is more or less 
> equivalent to having a 'global runqueue' for real-time tasks, without 
> the SMP overhead associated with that. If there is no "RT overload" [the 
> common case even on Linux systems that _do_ make use of RT tasks 
> occasionally], the new mechanism is totally inactive and there's no 
> overhead. But once there are more RT tasks than CPUs, the scheduler will 
> do "global" decisions for what RT tasks to run on which CPU.

Is this good enough?  Isn't it possible with the current 
try_to_wake_up() implementation (with or without smpnice) for two RT 
tasks to end up on the same CPU even when there are less RT tasks than CPUs?

> To put even 
> less overhead on the mainstream kernel, i plan to introduce a new 
> SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
> make much sense to extend SCHED_RR in that direction.]

I wouldn't have thought a new policy was necessary.  Why not just do 
this for all SCHED_FIFO (or even all RT) tasks?

BTW Does any body in the real world actually use SCHED_RR?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
