Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUHURJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUHURJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUHURJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:09:25 -0400
Received: from main.gmane.org ([80.91.224.249]:41124 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266756AbUHURJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:09:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karl Vogel <karl.vogel@seagha.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6 -- False positive?!
Date: Sat, 21 Aug 2004 19:09:56 +0200
Message-ID: <cg7vju$pok$1@sea.gmane.org>
References: <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d51a4788e.kabel.telenet.be
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if the following is a false positive or not:

preemption latency trace v1.0.1
-------------------------------
 latency: 3022 us, entries: 15 (15)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x27/0x230
 => ended at:   do_IRQ+0x1a3/0x230
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (acpi_processor_idle)
00010001 0.000ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010001 0.000ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010001 2.953ms (+2.952ms): wake_up_process (generic_redirect_hardirq)
00010001 2.953ms (+0.000ms): try_to_wake_up (wake_up_process)
00010001 2.953ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010002 2.953ms (+0.000ms): activate_task (try_to_wake_up)
00010002 2.953ms (+0.000ms): sched_clock (activate_task)
00010002 2.953ms (+0.000ms): recalc_task_prio (activate_task)
00010002 2.953ms (+0.000ms): effective_prio (recalc_task_prio)
00010002 2.953ms (+0.000ms): enqueue_task (activate_task)
00010001 2.954ms (+0.000ms): preempt_schedule (try_to_wake_up)
00010000 2.954ms (+0.000ms): preempt_schedule (do_IRQ)
00000001 2.954ms (+0.000ms): sub_preempt_count (do_IRQ)

The following looks similar:

 latency: 517 us, entries: 29 (29)
    -----------------
    | task: swapper/0, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: do_IRQ+0x27/0x230
 => ended at:   do_IRQ+0x1a3/0x230
=======>
00010000 0.000ms (+0.000ms): do_IRQ (common_interrupt)
00010000 0.000ms (+0.000ms): do_IRQ (acpi_processor_idle)
00010001 0.000ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010001 0.000ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010000 0.000ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 0.000ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.000ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010001 0.009ms (+0.008ms): do_timer (timer_interrupt)
00010001 0.503ms (+0.493ms): update_process_times (do_timer)
00010001 0.503ms (+0.000ms): update_one_process (update_process_times)
00010001 0.503ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.503ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.503ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.504ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.504ms (+0.000ms): update_wall_time (do_timer)
00010001 0.504ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010001 0.504ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010001 0.504ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000001 0.504ms (+0.000ms): do_softirq (do_IRQ)
00000100 0.505ms (+0.000ms): __do_softirq (do_softirq)
00000100 0.505ms (+0.000ms): wake_up_process (do_softirq)
00000100 0.505ms (+0.000ms): try_to_wake_up (wake_up_process)
00000100 0.505ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000101 0.505ms (+0.000ms): activate_task (try_to_wake_up)
00000101 0.505ms (+0.000ms): sched_clock (activate_task)
00000101 0.505ms (+0.000ms): recalc_task_prio (activate_task)
00000101 0.505ms (+0.000ms): effective_prio (recalc_task_prio)
00000101 0.505ms (+0.000ms): enqueue_task (activate_task)
00000001 0.506ms (+0.000ms): sub_preempt_count (do_IRQ)


