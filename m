Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUJIKmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUJIKmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 06:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJIKmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 06:42:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:14752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266680AbUJIKms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 06:42:48 -0400
X-Authenticated: #911537
Date: Sat, 9 Oct 2004 12:47:02 +0200
From: torbenh@gmx.de
To: linux-kernel@vger.kernel.org
Subject: voluntary-preempt T3 latency spikes with fan speed change
Message-ID: <20041009104702.GA14649@mobilat.informatik.uni-bremen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi...

i am seeing latency spikes (ie jack xruns) when the fan of my 
asus l3d laptop changes speed.

is there any chance to fix this ?
i have turned off acpi in the kernel, as this gives me latency spikes
all over.

i am quite new to the VP patches, and want to help where i can.

i also got a quite strange latency trace here:

could someone sched some light on this please ?


preemption latency trace v1.0.7 on 2.6.9-rc3-mm2-VP-T1
-------------------------------------------------------
 latency: 4579 us, entries: 45 (45)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: ardour/5244, uid:1000 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x19/0x60
 => ended at:   irq_exit+0x3c/0x50
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (<415a3011>)
00010000 0.000ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.000ms (+0.002ms): mask_and_ack_8259A (__do_IRQ)
00010001 0.002ms (+0.000ms): redirect_hardirq (__do_IRQ)
00010000 0.002ms (+0.000ms): handle_IRQ_event (__do_IRQ)
00010000 0.003ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010001 0.003ms (+0.006ms): mark_offset_tsc (timer_interrupt)
00010001 0.010ms (+0.000ms): do_timer (timer_interrupt)
00010001 0.010ms (+0.000ms): update_wall_time (do_timer)
00010001 0.010ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 0.011ms (+0.000ms): update_process_times (timer_interrupt)
00010001 0.011ms (+0.000ms): update_one_process (update_process_times)
00010001 0.011ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.011ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.012ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.012ms (+0.000ms): sched_clock (scheduler_tick)
00010002 0.013ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 0.013ms (+0.000ms): dequeue_task (scheduler_tick)
00010002 0.013ms (+0.000ms): effective_prio (scheduler_tick)
00010002 0.013ms (+0.000ms): enqueue_task (scheduler_tick)
00010001 0.013ms (+0.000ms): preempt_schedule (scheduler_tick)
00010001 0.014ms (+0.000ms): profile_tick (timer_interrupt)
00010000 0.014ms (+4.561ms): preempt_schedule (timer_interrupt)
00010001 4.576ms (+0.000ms): note_interrupt (__do_IRQ)
00010001 4.576ms (+0.000ms): end_8259A_irq (__do_IRQ)
00010001 4.576ms (+0.000ms): enable_8259A_irq (__do_IRQ)
00010001 4.577ms (+0.000ms): preempt_schedule (__do_IRQ)
00010000 4.577ms (+0.000ms): preempt_schedule (__do_IRQ)
00010000 4.577ms (+0.000ms): irq_exit (do_IRQ)
00000001 4.577ms (+0.000ms): do_softirq (irq_exit)
00000001 4.577ms (+0.000ms): __do_softirq (do_softirq)
00000001 4.577ms (+0.000ms): wake_up_process (do_softirq)
00000001 4.577ms (+0.000ms): try_to_wake_up (wake_up_process)
00000001 4.577ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000002 4.578ms (+0.000ms): activate_task (try_to_wake_up)
00000002 4.578ms (+0.000ms): sched_clock (activate_task)
00000002 4.578ms (+0.000ms): recalc_task_prio (activate_task)
00000002 4.579ms (+0.000ms): effective_prio (recalc_task_prio)
00000002 4.579ms (+0.000ms): enqueue_task (activate_task)
00000001 4.579ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 4.579ms (+0.000ms): sub_preempt_count (irq_exit)
00000001 4.580ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 4.580ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 4.580ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

-- 
torben Hohn
http://galan.sourceforge.net -- The graphical Audio language
