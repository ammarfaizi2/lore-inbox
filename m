Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUITTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUITTsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUITTsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:48:45 -0400
Received: from novell.stoldgods.nu ([193.45.238.241]:64972 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S267283AbUITTsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:48:02 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Date: Mon, 20 Sep 2004 21:47:07 +0200
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
References: <20040906110626.GA32320@elte.hu> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
In-Reply-To: <20040919122618.GA24982@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409202147.13109.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

On Sunday 19 September 2004 14.26, Ingo Molnar wrote:
> i've released the -S1 VP patch:
>
>  
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-
>S1
>
> NOTE: this patch is against Andrew's -mm tree and the VP patchset will
> stay based on -mm until the merging process has been finished.
>

I got this trace on my laptop (first time I'm testing VP):

preemption latency trace v1.0.7 on 2.6.9-rc2-mm1-VP-S1
-------------------------------------------------------
 latency: 1658 us, entries: 150 (150)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: powersaved/3542, uid:0 nice:10 policy:0 rt_prio:0
    -----------------
 => started at: acpi_ec_write+0x62/0x1c9
 => ended at:   acpi_ec_write+0x19a/0x1c9
=======>
00000001 0.000ms (+0.000ms): acpi_ec_write (acpi_ec_space_handler)
00000001 0.000ms (+0.000ms): acpi_hw_low_level_write (acpi_ec_write)
00000001 0.000ms (+0.001ms): acpi_os_write_port (acpi_hw_low_level_write)
00000001 0.001ms (+0.000ms): acpi_ec_wait (acpi_ec_write)
00000001 0.002ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 0.002ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 0.003ms (+0.000ms): __const_udelay (acpi_ec_wait)
00000001 0.004ms (+0.000ms): __delay (acpi_ec_wait)
00000001 0.004ms (+0.099ms): delay_pmtmr (__delay)
00000001 0.103ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 0.103ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
...
00000001 1.320ms (+0.000ms): __const_udelay (acpi_ec_wait)
00000001 1.320ms (+0.000ms): __delay (acpi_ec_wait)
00000001 1.321ms (+0.099ms): delay_pmtmr (__delay)
00000001 1.420ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 1.420ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 1.422ms (+0.000ms): acpi_hw_low_level_write (acpi_ec_write)
00000001 1.422ms (+0.001ms): acpi_os_write_port (acpi_hw_low_level_write)
00000001 1.423ms (+0.000ms): acpi_ec_wait (acpi_ec_write)
00000001 1.423ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 1.424ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 1.425ms (+0.000ms): __const_udelay (acpi_ec_wait)
00000001 1.425ms (+0.000ms): __delay (acpi_ec_wait)
00000001 1.425ms (+0.099ms): delay_pmtmr (__delay)
00000001 1.525ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 1.525ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 1.526ms (+0.000ms): acpi_hw_low_level_write (acpi_ec_write)
00000001 1.527ms (+0.001ms): acpi_os_write_port (acpi_hw_low_level_write)
00000001 1.528ms (+0.000ms): acpi_ec_wait (acpi_ec_write)
00000001 1.528ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 1.529ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 1.530ms (+0.000ms): __const_udelay (acpi_ec_wait)
00000001 1.530ms (+0.000ms): __delay (acpi_ec_wait)
00000001 1.530ms (+0.099ms): delay_pmtmr (__delay)
00000001 1.630ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 1.630ms (+0.001ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 1.632ms (+0.000ms): smp_apic_timer_interrupt (acpi_ec_write)
00010001 1.632ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 1.632ms (+0.000ms): profile_hook (profile_tick)
00010002 1.632ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 1.633ms (+0.001ms): profile_hit (smp_apic_timer_interrupt)
00010001 1.634ms (+0.000ms): do_IRQ (acpi_ec_write)
00010001 1.634ms (+0.000ms): do_IRQ (<00000000>)
00010002 1.635ms (+0.002ms): mask_and_ack_8259A (do_IRQ)
00010002 1.637ms (+0.000ms): redirect_hardirq (do_IRQ)
00010001 1.638ms (+0.000ms): handle_IRQ_event (do_IRQ)
00010001 1.638ms (+0.000ms): timer_interrupt (handle_IRQ_event)
00010002 1.638ms (+0.002ms): mark_offset_pmtmr (timer_interrupt)
00010002 1.641ms (+0.000ms): do_timer (timer_interrupt)
00010002 1.641ms (+0.000ms): update_process_times (do_timer)
00010002 1.641ms (+0.000ms): update_one_process (update_process_times)
00010002 1.642ms (+0.000ms): run_local_timers (update_process_times)
00010002 1.642ms (+0.000ms): raise_softirq (update_process_times)
00010002 1.642ms (+0.000ms): scheduler_tick (update_process_times)
00010002 1.643ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 1.643ms (+0.000ms): update_wall_time (do_timer)
00010002 1.643ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 1.644ms (+0.000ms): note_interrupt (do_IRQ)
00010002 1.644ms (+0.000ms): end_8259A_irq (do_IRQ)
00010002 1.644ms (+0.001ms): enable_8259A_irq (do_IRQ)
00000002 1.645ms (+0.000ms): do_softirq (do_IRQ)
00000002 1.646ms (+0.000ms): __do_softirq (do_softirq)
00000002 1.646ms (+0.000ms): wake_up_process (do_softirq)
00000002 1.646ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 1.646ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 1.647ms (+0.000ms): activate_task (try_to_wake_up)
00000003 1.647ms (+0.000ms): sched_clock (activate_task)
00000003 1.647ms (+0.000ms): task_priority (activate_task)
00000003 1.648ms (+0.000ms): task_sleep_avg (task_priority)
00000003 1.648ms (+0.000ms): enqueue_task (activate_task)
00000002 1.648ms (+0.001ms): preempt_schedule (try_to_wake_up)
00010001 1.650ms (+0.000ms): do_IRQ (acpi_ec_write)
00010001 1.650ms (+0.000ms): do_IRQ (<00000009>)
00010002 1.650ms (+0.003ms): mask_and_ack_8259A (do_IRQ)
00010002 1.654ms (+0.000ms): preempt_schedule (do_IRQ)
00010002 1.654ms (+0.000ms): redirect_hardirq (do_IRQ)
00010002 1.654ms (+0.000ms): wake_up_process (redirect_hardirq)
00010002 1.654ms (+0.000ms): try_to_wake_up (wake_up_process)
00010002 1.655ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010003 1.655ms (+0.000ms): activate_task (try_to_wake_up)
00010003 1.655ms (+0.000ms): sched_clock (activate_task)
00010003 1.655ms (+0.000ms): task_priority (activate_task)
00010003 1.656ms (+0.000ms): task_sleep_avg (task_priority)
00010003 1.656ms (+0.000ms): enqueue_task (activate_task)
00010002 1.656ms (+0.000ms): preempt_schedule (try_to_wake_up)
00010001 1.657ms (+0.000ms): preempt_schedule (do_IRQ)
00000002 1.657ms (+0.000ms): do_softirq (do_IRQ)
00000002 1.657ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.658ms (+0.000ms): sub_preempt_count (acpi_ec_write)
00000001 1.658ms (+0.000ms): update_max_trace (check_preempt_timing)


I don't know if anything can be done about it, but I get lots of them.
The computer is a Intel P-M 1.5GHz with 512MB RAM.


/Magnus M‰‰tt‰
