Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUHMHjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUHMHjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUHMHjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:39:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60319 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269017AbUHMHjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:39:49 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040812235116.GA27838@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
Content-Type: text/plain
Message-Id: <1092382825.3450.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 03:40:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 19:51, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>      
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6

Here's another weird one.  This happens when you create a new tab in
gnome-terminal, which causes a fork().

preemption latency trace v1.0
-----------------------------
 latency: 613 us, entries: 697 (697)
 process: gnome-terminal/3467, uid: 1000
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): do_IRQ (common_interrupt)
 0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.003ms (+0.003ms): generic_redirect_hardirq (do_IRQ)
 0.004ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.004ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.005ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 0.011ms (+0.006ms): do_timer (timer_interrupt)
 0.011ms (+0.000ms): update_process_times (do_timer)
 0.012ms (+0.000ms): update_one_process (update_process_times)
 0.012ms (+0.000ms): run_local_timers (update_process_times)
 0.012ms (+0.000ms): raise_softirq (update_process_times)
 0.013ms (+0.000ms): scheduler_tick (update_process_times)
 0.013ms (+0.000ms): sched_clock (scheduler_tick)
 0.014ms (+0.001ms): task_timeslice (scheduler_tick)
 0.015ms (+0.000ms): update_wall_time (do_timer)
 0.015ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 0.017ms (+0.001ms): generic_note_interrupt (do_IRQ)
 0.017ms (+0.000ms): end_8259A_irq (do_IRQ)
 0.017ms (+0.000ms): enable_8259A_irq (do_IRQ)
 0.019ms (+0.001ms): do_softirq (do_IRQ)
 0.019ms (+0.000ms): __do_softirq (do_softirq)
 0.019ms (+0.000ms): wake_up_process (do_softirq)
 0.020ms (+0.000ms): try_to_wake_up (wake_up_process)
 0.020ms (+0.000ms): task_rq_lock (try_to_wake_up)
 0.020ms (+0.000ms): activate_task (try_to_wake_up)
 0.021ms (+0.000ms): sched_clock (activate_task)
 0.021ms (+0.000ms): recalc_task_prio (activate_task)
 0.022ms (+0.000ms): effective_prio (recalc_task_prio)
 0.022ms (+0.000ms): enqueue_task (activate_task)
 0.023ms (+0.000ms): preempt_schedule (try_to_wake_up)
 0.024ms (+0.000ms): preempt_schedule (copy_page_range)
 0.024ms (+0.000ms): preempt_schedule (copy_page_range)
 0.025ms (+0.000ms): preempt_schedule (copy_page_range)
 0.026ms (+0.000ms): preempt_schedule (copy_page_range)

...about 400+ of the same deleted...

 0.459ms (+0.000ms): preempt_schedule (copy_page_range)
 0.459ms (+0.000ms): preempt_schedule (copy_page_range)
 0.460ms (+0.000ms): preempt_schedule (copy_page_range)
 0.461ms (+0.000ms): preempt_schedule (copy_page_range)
 0.461ms (+0.000ms): preempt_schedule (copy_page_range)
 0.461ms (+0.000ms): check_preempt_timing (touch_preempt_timing)

Lee

