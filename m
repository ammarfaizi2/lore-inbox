Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUIIQzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUIIQzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIIQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:53:36 -0400
Received: from slartibartfast.pa.net ([66.59.111.182]:46271 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S266310AbUIIQte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:49:34 -0400
Date: Thu, 9 Sep 2004 12:45:50 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: MOLNAR Ingo <mingo@elte.hu>, William Stearns <wstearns@pobox.com>
Subject: 2.6.9-rc1-bk15-VP-R9 latency traces
Message-ID: <Pine.LNX.4.58.0409091227020.4188@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Ingo,
	Thanks for all your work on latency.

	I just rebooted my Dell Inspiron 8200 into 2.6.9-rc1-bk15-VP-R9
(using your bk12-R9 patch on top of bk15).  I got three latency traces
during boot.  I realize you're not as worried about those, but I thought
I'd report them anyways.
CONFIG_PREEMPT_TIMING=y
CONFIG_LATENCY_TRACE=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y

	This one came out of /proc/latency_trace, from running
"/sbin/hdparm -u 1 -c 1 -m 16 /dev/hda".
	How do I clear this one out so that I can see others in the
future?

preemption latency trace v1.0.7 on 2.6.9-rc1-bk15-VP-R9
-------------------------------------------------------
 latency: 2999367 us, entries: 4000 (14351891)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: hdparm/2265, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: cond_resched+0x13/0x75
 => ended at:   sys_ioctl+0xdf/0x29e
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched)
00000001 0.000ms (+0.002ms): ide_find_setting_by_ioctl (generic_ide_ioctl)
00000001 0.002ms (+0.000ms): ide_write_setting (generic_ide_ioctl)
00000001 0.003ms (+0.594ms): ide_spin_wait_hwgroup (ide_write_setting)
00010001 0.597ms (+0.000ms): do_IRQ (ide_spin_wait_hwgroup)
00010001 0.597ms (+0.000ms): do_IRQ (<00000000>)
00010002 0.597ms (+0.003ms): mask_and_ack_8259A (do_IRQ)
00010002 0.600ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.600ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 0.601ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 0.601ms (+0.005ms): mark_offset_tsc (timer_interrupt)
00010002 0.606ms (+0.000ms): do_timer (timer_interrupt)
00010002 0.607ms (+0.000ms): update_process_times (do_timer)
00010002 0.607ms (+0.000ms): update_one_process (update_process_times)
00010002 0.607ms (+0.000ms): run_local_timers (update_process_times)
00010002 0.607ms (+0.000ms): raise_softirq (update_process_times)
00010002 0.607ms (+0.000ms): scheduler_tick (update_process_times)
00010002 0.608ms (+0.000ms): sched_clock (scheduler_tick)
00010003 0.608ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 0.609ms (+0.000ms): update_wall_time (do_timer)
00010002 0.609ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 0.609ms (+0.000ms): smp_local_timer_interrupt (timer_interrupt)
00010002 0.609ms (+0.000ms): profile_tick (smp_local_timer_interrupt)
00010002 0.609ms (+0.000ms): profile_hook (profile_tick)
00010003 0.610ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.610ms (+0.000ms): profile_hit (smp_local_timer_interrupt)
00010002 0.610ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 0.610ms (+0.000ms): end_8259A_irq (do_IRQ)
00010002 0.611ms (+0.001ms): enable_8259A_irq (do_IRQ)
00000002 0.612ms (+0.000ms): do_softirq (do_IRQ)
00000002 0.612ms (+0.000ms): __do_softirq (do_softirq)
00000002 0.612ms (+0.000ms): wake_up_process (do_softirq)
00000002 0.612ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 0.612ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.613ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.613ms (+0.000ms): sched_clock (activate_task)
00000003 0.613ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.613ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.614ms (+0.000ms): enqueue_task (activate_task)
00000002 0.614ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.615ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 0.615ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 0.615ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)

[large number of these deleted]

00000001 1.592ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.593ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.593ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.593ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.593ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.594ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.594ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.594ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.594ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.595ms (+0.001ms): preempt_schedule (ide_spin_wait_hwgroup)
00010001 1.596ms (+0.000ms): do_IRQ (__mcount)
00010001 1.597ms (+0.000ms): do_IRQ (<00000000>)
00010002 1.597ms (+0.003ms): mask_and_ack_8259A (do_IRQ)
00010002 1.600ms (+0.000ms): preempt_schedule (do_IRQ)
00010002 1.600ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 1.600ms (+0.000ms): preempt_schedule (do_IRQ)
00010001 1.600ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 1.600ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 1.601ms (+0.005ms): mark_offset_tsc (timer_interrupt)
00010003 1.606ms (+0.000ms): preempt_schedule (mark_offset_tsc)
00010002 1.606ms (+0.000ms): preempt_schedule (mark_offset_tsc)
00010002 1.607ms (+0.000ms): do_timer (timer_interrupt)
00010002 1.607ms (+0.000ms): update_process_times (do_timer)
00010002 1.607ms (+0.000ms): update_one_process (update_process_times)
00010002 1.607ms (+0.000ms): run_local_timers (update_process_times)
00010002 1.607ms (+0.000ms): raise_softirq (update_process_times)
00010002 1.607ms (+0.000ms): scheduler_tick (update_process_times)
00010002 1.607ms (+0.000ms): sched_clock (scheduler_tick)
00010003 1.608ms (+0.000ms): task_timeslice (scheduler_tick)
00010002 1.608ms (+0.000ms): preempt_schedule (scheduler_tick)
00010002 1.608ms (+0.000ms): update_wall_time (do_timer)
00010002 1.608ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 1.609ms (+0.000ms): smp_local_timer_interrupt (timer_interrupt)
00010002 1.609ms (+0.000ms): profile_tick (smp_local_timer_interrupt)
00010002 1.609ms (+0.000ms): profile_hook (profile_tick)
00010003 1.609ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 1.609ms (+0.000ms): preempt_schedule (profile_tick)
00010002 1.609ms (+0.000ms): profile_hit (smp_local_timer_interrupt)
00010001 1.610ms (+0.000ms): preempt_schedule (timer_interrupt)
00010002 1.610ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 1.610ms (+0.000ms): end_8259A_irq (do_IRQ)
00010002 1.610ms (+0.001ms): enable_8259A_irq (do_IRQ)
00010002 1.611ms (+0.000ms): preempt_schedule (do_IRQ)
00010001 1.611ms (+0.000ms): preempt_schedule (do_IRQ)
00000002 1.612ms (+0.000ms): do_softirq (do_IRQ)
00000002 1.612ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.613ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.613ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.613ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.613ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.614ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.614ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)

[lots more deleted]

00000001 1.659ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.659ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.659ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.659ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.660ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.660ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.660ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.660ms (+0.000ms): preempt_schedule (ide_spin_wait_hwgroup)
00000001 1.661ms (+2132376.989ms): preempt_schedule (ide_spin_wait_hwgroup)


	Earlier ones that I recovered from the console:

During boot:
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
(swapper/1): new 120557 us maximum-latency critical section.
 => started at: <cond_resched+0x13/0x75>
 => ended at:   <cond_resched+0x13/0x75>
 [<c0139c9c>] touch_preempt_timing+0x3d/0x41
 [<c0139bc9>] check_preempt_timing+0x15f/0x1f5
 [<c04b5789>] cond_resched+0x13/0x75
 [<c0238626>] vt_console_print+0x22b/0x317
 [<c0139c9c>] touch_preempt_timing+0x3d/0x41
 [<c04b5789>] cond_resched+0x13/0x75
 [<c04b5789>] cond_resched+0x13/0x75
 [<c0145f79>] kmem_cache_alloc+0x5f/0x61
 [<c0114fcc>] mcount+0x14/0x18
 [<c024b247>] add_dev+0x2f/0xa6
 [<c024b37c>] parport_daisy_init+0x60/0x202
 [<c0248134>] parport_announce_port+0xe/0xf2
 [<c0114fcc>] mcount+0x14/0x18
 [<c0248144>] parport_announce_port+0x1e/0xf2
 [<c024fc0a>] parport_pc_probe_port+0x4ba/0x730
 [<c0634b6a>] parport_pc_find_isa_ports+0x68/0xa6
 [<c0634be6>] parport_pc_find_ports+0x3e/0x6b
 [<c0634fcd>] parport_pc_init+0xaa/0xac
 [<c0634a7e>] parport_default_proc_register+0x1f/0x2a
 [<c061e80a>] do_initcalls+0x2f/0xbc
 [<c01004c9>] init+0x54/0x174
 [<c0100475>] init+0x0/0x174
 [<c01042c5>] kernel_thread_helper+0x5/0xb
lp0: using parport0 (polling).


ACPI: Power Resource [PADA] (on)
(swapper/1): new 69354 us maximum-latency critical section.
 => started at: <cond_resched+0x13/0x75>
 => ended at:   <cond_resched+0x13/0x75>
 [<c0139c9c>] touch_preempt_timing+0x3d/0x41
 [<c0139bc9>] check_preempt_timing+0x15f/0x1f5
 [<c04b5789>] cond_resched+0x13/0x75
 [<c0139c9c>] touch_preempt_timing+0x3d/0x41
 [<c04b5789>] cond_resched+0x13/0x75
 [<c04b5789>] cond_resched+0x13/0x75
 [<c01461b7>] __kmalloc+0x89/0x90
 [<c0114fcc>] mcount+0x14/0x18
 [<c019058a>] proc_create+0x86/0xd9
 [<c0190789>] create_proc_entry+0x66/0xc9
 [<c06343c5>] i8k_init+0x35/0x6f
 [<c0633104>] misc_init+0x59/0xa9
 [<c061e80a>] do_initcalls+0x2f/0xbc
 [<c01004c9>] init+0x54/0x174
 [<c0100475>] init+0x0/0x174
 [<c01042c5>] kernel_thread_helper+0x5/0xb
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)

	The above came from an untainted kernel.  Please let me know if 
you need any more details.  Thanks again for your work.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Bastard Operators from Hell" anagrams to "Shatterproof Armored Balls"
(Courtesy of Jens Benecke <jens@pinguin.conetix.de>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
