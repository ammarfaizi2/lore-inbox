Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263470AbUJ3Dst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbUJ3Dst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbUJ3Dst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:48:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17599 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263470AbUJ3Dso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:48:44 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1099107364.1551.7.camel@krustophenia.net>
References: <20041029163155.GA9005@elte.hu>
	 <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <20041030003122.03bcf01b@mango.fruits.de>
	 <1099107364.1551.7.camel@krustophenia.net>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 23:48:40 -0400
Message-Id: <1099108122.1551.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:36 -0400, Lee Revell wrote:
> Ingo, here are some of my traces with the same settings.  These do seem
> to correspond to the xruns.  Many of them look tty related - could the
> recent changes to the tty layer be responsible?  Possibly this has
> nothing to do with RT preempt, but is an unrelated bug in -mm?  The
> xruns do seem to correspond to display activity such as switching tabs
> in gnome-terminal. 
> 

OK here is a trace that might explain the xruns:

preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.14
-------------------------------------------------------
 latency: 476 us, entries: 260 (260)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: jackd/1726, uid:1000 nice:0 policy:1 rt_prio:10
    -----------------
 => started at: try_to_wake_up+0x4c/0x100 <c01126ec>
 => ended at:   finish_task_switch+0x27/0xb0 <c0112b77>
=======>
    4 80000000 0.000ms (+0.000ms): (49) ((98))
    4 80000000 0.000ms (+0.000ms): (835) ((4))
    4 80000000 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    4 80000000 0.001ms (+0.000ms): preempt_schedule (__do_IRQ)
    4 80000000 0.001ms (+0.000ms): irq_exit (do_IRQ)
    4 80000000 0.002ms (+0.000ms): do_softirq (irq_exit)
    4 80000000 0.002ms (+0.075ms): __do_softirq (do_softirq)
    4 80000000 0.078ms (+0.000ms): do_IRQ (_mmx_memcpy)
    4 80000000 0.078ms (+0.000ms): do_IRQ ((0))
    4 80000000 0.079ms (+0.002ms): mask_and_ack_8259A (__do_IRQ)
    4 80000000 0.081ms (+0.000ms): preempt_schedule (__do_IRQ)
    4 80000000 0.082ms (+0.000ms): redirect_hardirq (__do_IRQ)
    4 80000000 0.082ms (+0.000ms): preempt_schedule (__do_IRQ)
    4 80000000 0.083ms (+0.000ms): handle_IRQ_event (__do_IRQ)
    4 80000000 0.083ms (+0.000ms): timer_interrupt (handle_IRQ_event)
    4 80000000 0.084ms (+0.003ms): mark_offset_tsc (timer_interrupt)
    4 80000000 0.088ms (+0.001ms): preempt_schedule (mark_offset_tsc)
    4 80000000 0.089ms (+0.000ms): preempt_schedule (mark_offset_tsc)
    4 80000000 0.089ms (+0.000ms): do_timer (timer_interrupt)
    4 80000000 0.090ms (+0.000ms): update_process_times (timer_interrupt)
    4 80000000 0.090ms (+0.000ms): update_one_process (update_process_times)
    4 80000000 0.091ms (+0.000ms): run_local_timers (update_process_times)
    4 80000000 0.091ms (+0.000ms): raise_softirq (update_process_times)
    4 80000000 0.091ms (+0.000ms): scheduler_tick (update_process_times)
    4 80000000 0.092ms (+0.001ms): sched_clock (scheduler_tick)
    4 80000000 0.093ms (+0.000ms): preempt_schedule (scheduler_tick)
    4 80000000 0.093ms (+0.000ms): profile_hit (timer_interrupt)
    4 80000000 0.094ms (+0.000ms): preempt_schedule (timer_interrupt)
    4 80000000 0.094ms (+0.000ms): note_interrupt (__do_IRQ)
    4 80000000 0.095ms (+0.000ms): end_8259A_irq (__do_IRQ)
    4 80000000 0.095ms (+0.001ms): enable_8259A_irq (__do_IRQ)
    4 80000000 0.097ms (+0.000ms): preempt_schedule (__do_IRQ)
    4 80000000 0.097ms (+0.000ms): preempt_schedule (__do_IRQ)
    4 80000000 0.098ms (+0.000ms): irq_exit (do_IRQ)
    4 80000000 0.098ms (+0.000ms): do_softirq (irq_exit)
    4 80000000 0.098ms (+0.371ms): __do_softirq (do_softirq)
    4 00000000 0.470ms (+0.000ms): preempt_schedule (_mmx_memcpy)
    4 80000000 0.470ms (+0.000ms): __schedule (preempt_schedule)
    4 80000000 0.470ms (+0.000ms): profile_hit (__schedule)
    4 80000000 0.471ms (+0.001ms): sched_clock (__schedule)
  835 80000000 0.472ms (+0.000ms): __switch_to (__schedule)
  835 80000000 0.473ms (+0.000ms): (4) ((835))
  835 80000000 0.473ms (+0.000ms): (98) ((49))
  835 80000000 0.473ms (+0.000ms): finish_task_switch (__schedule)
  835 80000000 0.474ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
  835 80000000 0.474ms (+0.849ms): (835) ((49))
  835 80000000 1.324ms (+0.000ms): do_IRQ (finish_task_switch)
  835 80000000 1.324ms (+0.001ms): do_IRQ ((0))
  835 80000000 1.325ms (+0.002ms): mask_and_ack_8259A (__do_IRQ)
  835 80000000 1.328ms (+0.000ms): redirect_hardirq (__do_IRQ)
  835 80000000 1.329ms (+0.000ms): handle_IRQ_event (__do_IRQ)
  835 80000000 1.329ms (+0.001ms): timer_interrupt (handle_IRQ_event)
  835 80000000 1.330ms (+0.004ms): mark_offset_tsc (timer_interrupt)
  835 80000000 1.335ms (+0.000ms): do_timer (timer_interrupt)
  835 80000000 1.335ms (+0.000ms): update_process_times (timer_interrupt)
  835 80000000 1.336ms (+0.000ms): update_one_process (update_process_times)
  835 80000000 1.336ms (+0.000ms): run_local_timers (update_process_times)
  835 80000000 1.337ms (+0.000ms): raise_softirq (update_process_times)

Lee

