Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUHSSWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUHSSWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUHSSV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:21:59 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:44455 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267176AbUHSSVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:21:19 -0400
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
References: <20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
From: karl.vogel@seagha.com
Date: Thu, 19 Aug 2004 20:08:46 +0200
In-Reply-To: <20040819073247.GA1798@elte.hu> (Ingo Molnar's message of "Thu,
 19 Aug 2004 09:32:47 +0200")
Message-ID: <m31xi3j901.fsf@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When logging into my Fedora Core 2 box on the console (normal vga text console),
I get the following latency trace: 

(preempt=1 voluntary-preempt=3 elevator=cfq)


preemption latency trace v1.0.1
-------------------------------
 latency: 3568 us, entries: 137 (137)
    -----------------
    | task: setfont/2209, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: voluntary_resched+0x31/0x60
 => ended at:   voluntary_resched+0x31/0x60
=======>
 0.000ms (+0.000ms): touch_preempt_timing (voluntary_resched)
 0.000ms (+0.000ms): vgacon_font_set (con_font_set)
 0.000ms (+0.000ms): vgacon_do_font_op (vgacon_font_set)
 0.057ms (+0.056ms): smp_apic_timer_interrupt (vgacon_do_font_op)
 0.057ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
 0.057ms (+0.000ms): notifier_call_chain (profile_hook)
 0.120ms (+0.063ms): do_IRQ (vgacon_do_font_op)
 0.121ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 0.121ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 0.121ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.121ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.121ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
 0.128ms (+0.006ms): do_timer (timer_interrupt)
 0.128ms (+0.000ms): update_process_times (do_timer)
 0.128ms (+0.000ms): update_one_process (update_process_times)
 0.128ms (+0.000ms): run_local_timers (update_process_times)
 0.128ms (+0.000ms): raise_softirq (update_process_times)
 0.128ms (+0.000ms): scheduler_tick (update_process_times)
 0.128ms (+0.000ms): sched_clock (scheduler_tick)
 0.128ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
 0.128ms (+0.000ms): idle_cpu (rcu_check_callbacks)
 0.129ms (+0.000ms): __tasklet_schedule (scheduler_tick)
 0.129ms (+0.000ms): update_wall_time (do_timer)
 0.129ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 0.129ms (+0.000ms): generic_note_interrupt (do_IRQ)
 0.129ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
 0.130ms (+0.000ms): do_softirq (do_IRQ)
 0.130ms (+0.000ms): __do_softirq (do_softirq)
 0.130ms (+0.000ms): wake_up_process (do_softirq)
 0.130ms (+0.000ms): try_to_wake_up (wake_up_process)
 0.130ms (+0.000ms): task_rq_lock (try_to_wake_up)
 0.130ms (+0.000ms): activate_task (try_to_wake_up)
 0.130ms (+0.000ms): sched_clock (activate_task)
 0.130ms (+0.000ms): recalc_task_prio (activate_task)
 0.130ms (+0.000ms): effective_prio (recalc_task_prio)
 0.130ms (+0.000ms): enqueue_task (activate_task)
 1.058ms (+0.927ms): smp_apic_timer_interrupt (vgacon_do_font_op)
 1.058ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
 1.058ms (+0.000ms): notifier_call_chain (profile_hook)
 1.058ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
 1.058ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
 1.058ms (+0.000ms): __do_softirq (do_softirq)
 1.122ms (+0.063ms): do_IRQ (vgacon_do_font_op)
 1.122ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 1.122ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 1.122ms (+0.000ms): preempt_schedule (do_IRQ)
 1.122ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 1.122ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 1.123ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
 1.129ms (+0.006ms): do_timer (timer_interrupt)
 1.129ms (+0.000ms): update_process_times (do_timer)
 1.129ms (+0.000ms): update_one_process (update_process_times)
 1.129ms (+0.000ms): run_local_timers (update_process_times)
 1.129ms (+0.000ms): raise_softirq (update_process_times)
 1.129ms (+0.000ms): scheduler_tick (update_process_times)
 1.129ms (+0.000ms): sched_clock (scheduler_tick)
 1.129ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
 1.129ms (+0.000ms): idle_cpu (rcu_check_callbacks)
 1.130ms (+0.000ms): update_wall_time (do_timer)
 1.130ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 1.130ms (+0.000ms): generic_note_interrupt (do_IRQ)
 1.130ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
 1.130ms (+0.000ms): preempt_schedule (do_IRQ)
 1.130ms (+0.000ms): do_softirq (do_IRQ)
 1.130ms (+0.000ms): __do_softirq (do_softirq)
 2.059ms (+0.928ms): smp_apic_timer_interrupt (vgacon_do_font_op)
 2.059ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
 2.059ms (+0.000ms): notifier_call_chain (profile_hook)
 2.059ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
 2.059ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
 2.059ms (+0.000ms): __do_softirq (do_softirq)
 2.123ms (+0.063ms): do_IRQ (vgacon_do_font_op)
 2.123ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 2.123ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 2.123ms (+0.000ms): preempt_schedule (do_IRQ)
 2.123ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 2.123ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 2.123ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
 2.130ms (+0.006ms): do_timer (timer_interrupt)
 2.130ms (+0.000ms): update_process_times (do_timer)
 2.130ms (+0.000ms): update_one_process (update_process_times)
 2.130ms (+0.000ms): run_local_timers (update_process_times)
 2.130ms (+0.000ms): raise_softirq (update_process_times)
 2.130ms (+0.000ms): scheduler_tick (update_process_times)
 2.130ms (+0.000ms): sched_clock (scheduler_tick)
 2.130ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
 2.131ms (+0.000ms): idle_cpu (rcu_check_callbacks)
 2.131ms (+0.000ms): dequeue_task (scheduler_tick)
 2.131ms (+0.000ms): effective_prio (scheduler_tick)
 2.131ms (+0.000ms): task_timeslice (scheduler_tick)
 2.131ms (+0.000ms): enqueue_task (scheduler_tick)
 2.131ms (+0.000ms): update_wall_time (do_timer)
 2.131ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 2.131ms (+0.000ms): generic_note_interrupt (do_IRQ)
 2.132ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
 2.132ms (+0.000ms): preempt_schedule (do_IRQ)
 2.132ms (+0.000ms): do_softirq (do_IRQ)
 2.132ms (+0.000ms): __do_softirq (do_softirq)
 3.060ms (+0.927ms): smp_apic_timer_interrupt (vgacon_do_font_op)
 3.060ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
 3.060ms (+0.000ms): notifier_call_chain (profile_hook)
 3.060ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
 3.060ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
 3.060ms (+0.000ms): __do_softirq (do_softirq)
 3.124ms (+0.063ms): do_IRQ (vgacon_do_font_op)
 3.124ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 3.124ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 3.124ms (+0.000ms): preempt_schedule (do_IRQ)
 3.124ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 3.124ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 3.124ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
 3.131ms (+0.006ms): do_timer (timer_interrupt)
 3.131ms (+0.000ms): update_process_times (do_timer)
 3.131ms (+0.000ms): update_one_process (update_process_times)
 3.131ms (+0.000ms): run_local_timers (update_process_times)
 3.131ms (+0.000ms): raise_softirq (update_process_times)
 3.131ms (+0.000ms): scheduler_tick (update_process_times)
 3.131ms (+0.000ms): sched_clock (scheduler_tick)
 3.131ms (+0.000ms): rcu_check_callbacks (scheduler_tick)
 3.131ms (+0.000ms): idle_cpu (rcu_check_callbacks)
 3.131ms (+0.000ms): update_wall_time (do_timer)
 3.131ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 3.132ms (+0.000ms): generic_note_interrupt (do_IRQ)
 3.132ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
 3.132ms (+0.000ms): preempt_schedule (do_IRQ)
 3.132ms (+0.000ms): do_softirq (do_IRQ)
 3.132ms (+0.000ms): __do_softirq (do_softirq)
 3.485ms (+0.353ms): preempt_schedule (vgacon_do_font_op)
 3.486ms (+0.000ms): vgacon_adjust_height (vgacon_font_set)
 3.486ms (+0.000ms): release_console_sem (con_font_set)
 3.486ms (+0.000ms): preempt_schedule (release_console_sem)
 3.486ms (+0.000ms): kfree (con_font_set)
 3.487ms (+0.000ms): copy_to_user (vt_ioctl)
 3.487ms (+0.000ms): __might_sleep (copy_to_user)
 3.487ms (+0.000ms): voluntary_resched (copy_to_user)
 3.487ms (+0.000ms): __might_sleep (voluntary_resched)
 3.487ms (+0.000ms): touch_preempt_timing (voluntary_resched)


$ cat /proc/interrupts
           CPU0
  0:    1286100    IO-APIC-edge  timer
  1:       4572    IO-APIC-edge  i8042
  8:          1    IO-APIC-edge  rtc
  9:         10   IO-APIC-level  acpi
 12:      86351    IO-APIC-edge  i8042
 14:      14089    IO-APIC-edge  ide0
 15:        477    IO-APIC-edge  ide1
 19:      13568   IO-APIC-level  eth0
 20:         94   IO-APIC-level  ehci_hcd, ohci_hcd
 21:          0   IO-APIC-level  ohci_hcd
 22:        593   IO-APIC-level  NVidia nForce3
NMI:          0
LOC:    1286057
ERR:          0
MIS:          0


Machine is an ACER Aspire 1510 notebook
(AMD64 processor running a 32-bit kernel)
