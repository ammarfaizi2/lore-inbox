Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUH3J1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUH3J1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUH3J1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:27:43 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:49413 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S267583AbUH3J1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:27:36 -0400
Message-ID: <4132F302.7030706@fr.thalesgroup.com>
Date: Mon, 30 Aug 2004 11:27:30 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: voluntary-preempt-2.6.8.1-P9 : big latency when logging on console
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net> <20040828121413.GB17908@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a 1.6ms latency every time I log in with P9.

Here are the traces. The PC is a P4@3GHz with half a gigabyte of memory and a 
SuperMicro i875p motherboard. The graphics board is integrated which might be 
relevant to this issue since I see vt_ioctl in the backtrace.

I can reproduce the problem every time I try to.

    thank you for your help,

	Pierre-Olivier Gaillard



Aug 30 11:17:40 canopus kernel: (setfont/2332): new 1647 us maximum-latency 
critical section.
Aug 30 11:17:40 canopus kernel:  => started at: <voluntary_resched+0x35/0x70>
Aug 30 11:17:40 canopus kernel:  => ended at:   <voluntary_resched+0x35/0x70>
Aug 30 11:17:40 canopus kernel:  [<c015a0e4>] check_preempt_timing+0x1a4/0x240
Aug 30 11:17:40 canopus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 30 11:17:40 canopus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 30 11:17:40 canopus kernel:  [<c015a1b6>] touch_preempt_timing+0x36/0x40
Aug 30 11:17:40 canopus kernel:  [<c015a1b6>] touch_preempt_timing+0x36/0x40
Aug 30 11:17:40 canopus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 30 11:17:40 canopus kernel:  [<c0229b61>] copy_to_user+0x31/0x90
Aug 30 11:17:40 canopus kernel:  [<c026f143>] vt_ioctl+0x1433/0x1b80
Aug 30 11:17:40 canopus kernel:  [<c01a1027>] .text.lock.pipe+0xf/0xc8
Aug 30 11:17:40 canopus kernel:  [<c0174714>] handle_mm_fault+0x154/0x360
Aug 30 11:17:40 canopus kernel:  [<c015a119>] check_preempt_timing+0x1d9/0x240
Aug 30 11:17:40 canopus kernel:  [<c015a2b8>] sub_preempt_count+0x48/0x60
Aug 30 11:17:40 canopus kernel:  [<c018cd43>] fget+0xe3/0x180
Aug 30 11:17:40 canopus kernel:  [<c026dd10>] vt_ioctl+0x0/0x1b80
Aug 30 11:17:40 canopus kernel:  [<c02668ad>] tty_ioctl+0x57d/0x670
Aug 30 11:17:40 canopus kernel:  [<c01a8cdd>] sys_ioctl+0x23d/0x400
Aug 30 11:17:40 canopus kernel:  [<c018ba10>] sys_read+0x50/0x80
Aug 30 11:17:40 canopus kernel:  [<c0107bfd>] sysenter_past_esp+0x52/0x71

preemption latency trace v1.0.2
-------------------------------
  latency: 1647 us, entries: 82 (82)
     -----------------
     | task: setfont/2332, uid:0 nice:0 policy:0 rt_prio:0
     -----------------
  => started at: voluntary_resched+0x35/0x70
  => ended at:   voluntary_resched+0x35/0x70
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (voluntary_resched)
00000001 0.000ms (+0.000ms): vgacon_font_set (con_font_set)
00000001 0.000ms (+0.000ms): vgacon_do_font_op (vgacon_font_set)
00010001 0.084ms (+0.083ms): do_IRQ (vgacon_do_font_op)
00010002 0.084ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010002 0.084ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 0.084ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 0.084ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 0.085ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010002 0.091ms (+0.006ms): do_timer (timer_interrupt)
00010002 0.091ms (+0.000ms): update_process_times (do_timer)
00010002 0.091ms (+0.000ms): update_one_process (update_process_times)
00010002 0.091ms (+0.000ms): run_local_timers (update_process_times)
00010002 0.091ms (+0.000ms): raise_softirq (update_process_times)
00010002 0.092ms (+0.000ms): scheduler_tick (update_process_times)
00010002 0.092ms (+0.000ms): sched_clock (scheduler_tick)
00010002 0.092ms (+0.000ms): update_wall_time (do_timer)
00010002 0.092ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 0.093ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 0.093ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000002 0.093ms (+0.000ms): do_softirq (do_IRQ)
00000002 0.093ms (+0.000ms): __do_softirq (do_softirq)
00000002 0.093ms (+0.000ms): wake_up_process (do_softirq)
00000002 0.094ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 0.094ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.094ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.094ms (+0.000ms): sched_clock (activate_task)
00000003 0.094ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.094ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.094ms (+0.000ms): enqueue_task (activate_task)
00000002 0.095ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000001 0.513ms (+0.418ms): smp_apic_timer_interrupt (vgacon_do_font_op)
00010001 0.513ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010002 0.513ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.513ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
00000002 0.513ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 0.514ms (+0.000ms): __do_softirq (do_softirq)
00010001 1.083ms (+0.569ms): do_IRQ (vgacon_do_font_op)
00010002 1.083ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010002 1.084ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 1.084ms (+0.000ms): preempt_schedule (do_IRQ)
00010001 1.084ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 1.084ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010002 1.084ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010002 1.089ms (+0.004ms): preempt_schedule (mark_offset_pmtmr)
00010002 1.091ms (+0.001ms): preempt_schedule (timer_interrupt)
00010002 1.091ms (+0.000ms): do_timer (timer_interrupt)
00010002 1.091ms (+0.000ms): update_process_times (do_timer)
00010002 1.091ms (+0.000ms): update_one_process (update_process_times)
00010002 1.091ms (+0.000ms): run_local_timers (update_process_times)
00010002 1.091ms (+0.000ms): raise_softirq (update_process_times)
00010002 1.091ms (+0.000ms): scheduler_tick (update_process_times)
00010002 1.091ms (+0.000ms): sched_clock (scheduler_tick)
00010003 1.092ms (+0.000ms): dequeue_task (scheduler_tick)
00010003 1.092ms (+0.000ms): effective_prio (scheduler_tick)
00010003 1.092ms (+0.000ms): task_timeslice (scheduler_tick)
00010003 1.092ms (+0.000ms): enqueue_task (scheduler_tick)
00010002 1.092ms (+0.000ms): preempt_schedule (scheduler_tick)
00010002 1.093ms (+0.000ms): update_wall_time (do_timer)
00010002 1.093ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 1.093ms (+0.000ms): preempt_schedule (timer_interrupt)
00010002 1.093ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 1.093ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010001 1.093ms (+0.000ms): preempt_schedule (do_IRQ)
00000002 1.094ms (+0.000ms): do_softirq (do_IRQ)
00000002 1.094ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.513ms (+0.418ms): smp_apic_timer_interrupt (vgacon_do_font_op)
00010001 1.513ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010002 1.513ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 1.513ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
00000002 1.513ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 1.513ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.645ms (+0.131ms): preempt_schedule (vgacon_do_font_op)
00000001 1.645ms (+0.000ms): vgacon_adjust_height (vgacon_font_set)
00000001 1.646ms (+0.000ms): release_console_sem (con_font_set)
00000001 1.646ms (+0.000ms): preempt_schedule (release_console_sem)
00000001 1.646ms (+0.000ms): kfree (con_font_set)
00000001 1.646ms (+0.000ms): copy_to_user (vt_ioctl)
00000001 1.646ms (+0.000ms): __might_sleep (copy_to_user)
00000001 1.646ms (+0.000ms): voluntary_resched (copy_to_user)
00000001 1.647ms (+0.000ms): __might_sleep (voluntary_resched)
00000001 1.647ms (+0.000ms): touch_preempt_timing (voluntary_resched)

