Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVJGXI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVJGXI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVJGXI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:08:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63180 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750888AbVJGXI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:08:57 -0400
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <5bdc1c8b0510071047o741eb4d7vb73ed0e6d9e44aa3@mail.gmail.com>
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
	 <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
	 <5bdc1c8b0510061907w372cb406x45140b01e4011c4a@mail.gmail.com>
	 <20051007114848.GE857@elte.hu>
	 <5bdc1c8b0510070944p5a09f7f2m4965f3e0ddda21f7@mail.gmail.com>
	 <1128705805.17981.42.camel@mindpipe>
	 <5bdc1c8b0510071047o741eb4d7vb73ed0e6d9e44aa3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 18:08:35 -0400
Message-Id: <1128722916.17981.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 10:47 -0700, Mark Knecht wrote:
> On 10/7/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-10-07 at 09:44 -0700, Mark Knecht wrote:
> > > Hi Ingo,
> > >    OK, I've been running -rt10 for the last couple of hours on a new
> > > kernel without SMP. No xruns so far at 64/2. I'm doing all the normal
> > > stuff. emerge sync, building some code outside of portage, playing
> > > music. Very good so far, but it will likely take 4-6 hours for me to
> > > be more sure saying it was just SMP latencies.
> >
> > IIRC you posted some traces that implied the migration thread was
> > involved.
> >
> > Lee
> 
> No Lee, I don't think I've posted any traces myself. Possibly someone else?
> 

I was thinking of this trace that Fernando posted on 9/26 in the LKML
thread "jack, PREEMPT_DESKTOP, delayed interrupts?".  Note move_tasks
and load_balance_newidle near the end.  I never saw an explanation of
this:

# cat /proc/latency_trace
preemption latency trace v1.1.5 on 2.6.13-0.3.rdtd.rhfc4.ccrmasmp
--------------------------------------------------------------------
 latency: 10852 us, #70/70, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1
#P:2)
    -----------------
    | task: qjackctl-4797 (uid:743 nice:0 policy:1 rt_prio:61)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
   <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    0us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    0us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    0us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    0us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    1us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    3us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    3us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    3us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    3us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    3us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    5us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    6us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    6us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    6us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    6us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    6us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3    8us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3    9us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3    9us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3    9us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3    9us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   11us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   11us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   12us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   12us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   12us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   12us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   13us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   13us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   13us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   14us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   14us : MacPrivateStat (SkPnmiGetStruct)
   <...>-4593  1Dnh3   14us : MacUpdate (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   14us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   14us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   17us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   18us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   18us : SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   20us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   20us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   20us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   22us : GetStatVal (MacPrivateStat)
   <...>-4593  1Dnh3   22us : GetPhysStatVal (GetStatVal)
   <...>-4593  1Dnh3   22us+: SkGmMacStatistic (GetPhysStatVal)
   <...>-4593  1Dnh3   24us!: MacPrivateStat (SkPnmiGetStruct)
softirq--8     0Dnh4 9901us : trace_change_sched_cpu (1 0 0)
softirq--8     0Dnh4 9901us : _raw_spin_unlock (trace_change_sched_cpu)
softirq--8     0Dnh3 9902us : enqueue_task (move_tasks)
softirq--8     0Dnh3 9902us : resched_task (move_tasks)
softirq--8     0Dnh3 9902us : _raw_spin_unlock (load_balance_newidle)
softirq--8     0Dnh2 9902us : preempt_schedule (_raw_spin_unlock)
   <...>-4797  0Dnh2 9903us : __switch_to (__schedule)
   <...>-4797  0Dnh2 9904us : __schedule <softirq--8> (62 26)
   <...>-4797  0Dnh2 9904us : _raw_spin_unlock_irq (__schedule)
   <...>-4797  0...1 9904us : trace_stop_sched_switched (__schedule)
   <...>-4797  0Dnh1 9905us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-4797  0Dnh2 9905us : trace_stop_sched_switched <<...>-4797> (26
0)
   <...>-4797  0Dnh2 9905us : trace_stop_sched_switched (__schedule)

