Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUHYKBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUHYKBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 06:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUHYKBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 06:01:08 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:37895 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S266498AbUHYJ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:58:16 -0400
Message-ID: <412C62B1.6070608@fr.thalesgroup.com>
Date: Wed, 25 Aug 2004 11:58:09 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9 : oprofile latency at 3.3ms
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have not seen anybody report this trace, so I hope it is not redundant.
I got this when starting oprofile, but if I stop oprofile and start it again, I 
do not get another trace.
	
	sincerely,

	P.O. Gaillard


Aug 24 13:17:31 centaurus kernel: (mount/2642): new 3381 us maximum-latency 
critical section.
Aug 24 13:17:31 centaurus kernel:  => started at: <voluntary_resched+0x35/0x70>
Aug 24 13:17:31 centaurus kernel:  => ended at:   <voluntary_resched+0x35/0x70>
Aug 24 13:17:31 centaurus kernel:  [<c015a0e4>] check_preempt_timing+0x1a4/0x240
Aug 24 13:17:31 centaurus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 24 13:17:31 centaurus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 24 13:17:31 centaurus kernel:  [<c015a1b6>] touch_preempt_timing+0x36/0x40
Aug 24 13:17:31 centaurus kernel:  [<c015a1b6>] touch_preempt_timing+0x36/0x40
Aug 24 13:17:31 centaurus kernel:  [<c03aca95>] voluntary_resched+0x35/0x70
Aug 24 13:17:31 centaurus kernel:  [<c01d5e4c>] vfs_quota_sync+0x3c/0x610
Aug 24 13:17:31 centaurus kernel:  [<c01dc5aa>] sync_dquots+0x3a/0x70
Aug 24 13:17:31 centaurus kernel:  [<c018da42>] fsync_super+0x32/0xd0
Aug 24 13:17:31 centaurus kernel:  [<c01967b3>] do_remount_sb+0x33/0x140
Aug 24 13:17:31 centaurus kernel:  [<c019771c>] get_sb_single+0x8c/0xc0
Aug 24 13:17:31 centaurus kernel:  [<c01977fa>] do_kern_mount+0xaa/0x180
Aug 24 13:17:31 centaurus kernel:  [<f8a62e70>] oprofilefs_fill_super+0x0/0xa0 
[oprofile]
Aug 24 13:17:31 centaurus kernel:  [<c01be70a>] do_new_mount+0x7a/0xc0
Aug 24 13:17:31 centaurus kernel:  [<c01bf5a9>] do_mount+0x169/0x1b0
Aug 24 13:17:31 centaurus kernel:  [<c01bf394>] copy_mount_options+0x14/0xc0
Aug 24 13:17:31 centaurus kernel:  [<c01bfbce>] sys_mount+0x12e/0x2b0
Aug 24 13:17:31 centaurus kernel:  [<c0107bfd>] sysenter_past_esp+0x52/0x71
Aug 24 13:17:54 centaurus sshd(pam_unix)[2726]: session opened for user tmr by 
(uid=500)

preemption latency trace v1.0.2
-------------------------------
  latency: 400 us, entries: 139 (139)
     -----------------
     | task: mount/2642, uid:0 nice:0 policy:0 rt_prio:0
     -----------------
  => started at: voluntary_resched+0x35/0x70
  => ended at:   voluntary_resched+0x35/0x70
=======>
00000001 0.000ms (+0.000ms): touch_preempt_timing (voluntary_resched)
00000001 0.000ms (+0.000ms): d_rehash (__oprofilefs_create_file)
00000001 0.000ms (+0.000ms): do_remount_sb (get_sb_single)
00000001 0.000ms (+0.000ms): bdev_read_only (do_remount_sb)
00000001 0.001ms (+0.000ms): shrink_dcache_sb (do_remount_sb)
00010002 0.276ms (+0.274ms): do_IRQ (shrink_dcache_sb)
00010003 0.276ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 0.276ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010002 0.277ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010002 0.277ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010003 0.278ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010003 0.282ms (+0.004ms): do_timer (timer_interrupt)
00010003 0.282ms (+0.000ms): update_process_times (do_timer)
00010003 0.283ms (+0.000ms): update_one_process (update_process_times)
00010003 0.283ms (+0.000ms): run_local_timers (update_process_times)
00010003 0.283ms (+0.000ms): raise_softirq (update_process_times)
00010003 0.283ms (+0.000ms): scheduler_tick (update_process_times)
00010003 0.284ms (+0.000ms): sched_clock (scheduler_tick)
00010003 0.285ms (+0.001ms): update_wall_time (do_timer)
00010003 0.285ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010003 0.286ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010003 0.286ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000003 0.287ms (+0.000ms): do_softirq (do_IRQ)
00000003 0.287ms (+0.000ms): __do_softirq (do_softirq)
00000003 0.287ms (+0.000ms): wake_up_process (do_softirq)
00000003 0.287ms (+0.000ms): try_to_wake_up (wake_up_process)
00000003 0.287ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000004 0.288ms (+0.000ms): activate_task (try_to_wake_up)
00000004 0.288ms (+0.000ms): sched_clock (activate_task)
00000004 0.288ms (+0.000ms): recalc_task_prio (activate_task)
00000004 0.288ms (+0.000ms): effective_prio (recalc_task_prio)
00000004 0.288ms (+0.000ms): enqueue_task (activate_task)
00000003 0.289ms (+0.000ms): preempt_schedule (try_to_wake_up)
00000002 0.660ms (+0.370ms): smp_apic_timer_interrupt (shrink_dcache_sb)
00010002 0.660ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010003 0.660ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.661ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
00000003 0.661ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000003 0.661ms (+0.000ms): __do_softirq (do_softirq)
00010002 1.275ms (+0.613ms): do_IRQ (shrink_dcache_sb)
00010003 1.275ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 1.275ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010002 1.276ms (+0.000ms): preempt_schedule (do_IRQ)
00010002 1.276ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010002 1.276ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010003 1.276ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010003 1.279ms (+0.002ms): preempt_schedule (mark_offset_pmtmr)
00010003 1.281ms (+0.001ms): preempt_schedule (timer_interrupt)
00010003 1.281ms (+0.000ms): do_timer (timer_interrupt)
00010003 1.281ms (+0.000ms): update_process_times (do_timer)
00010003 1.281ms (+0.000ms): update_one_process (update_process_times)
00010003 1.281ms (+0.000ms): run_local_timers (update_process_times)
00010003 1.282ms (+0.000ms): raise_softirq (update_process_times)
00010003 1.282ms (+0.000ms): scheduler_tick (update_process_times)
00010003 1.282ms (+0.000ms): sched_clock (scheduler_tick)
00010003 1.283ms (+0.000ms): preempt_schedule (scheduler_tick)
00010003 1.283ms (+0.000ms): update_wall_time (do_timer)
00010003 1.283ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 1.283ms (+0.000ms): preempt_schedule (timer_interrupt)
00010003 1.284ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010003 1.284ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010002 1.284ms (+0.000ms): preempt_schedule (do_IRQ)
00000003 1.284ms (+0.000ms): do_softirq (do_IRQ)
00000003 1.284ms (+0.000ms): __do_softirq (do_softirq)
00000002 1.659ms (+0.375ms): smp_apic_timer_interrupt (shrink_dcache_sb)
00010002 1.659ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010003 1.659ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 1.660ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
00000003 1.660ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000003 1.660ms (+0.000ms): __do_softirq (do_softirq)
00010002 2.275ms (+0.614ms): do_IRQ (shrink_dcache_sb)
00010003 2.275ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 2.275ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010002 2.275ms (+0.000ms): preempt_schedule (do_IRQ)
00010002 2.275ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010002 2.275ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010003 2.276ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010003 2.278ms (+0.002ms): preempt_schedule (mark_offset_pmtmr)
00010003 2.280ms (+0.001ms): preempt_schedule (timer_interrupt)
00010003 2.280ms (+0.000ms): do_timer (timer_interrupt)
00010003 2.280ms (+0.000ms): update_process_times (do_timer)
00010003 2.280ms (+0.000ms): update_one_process (update_process_times)
00010003 2.281ms (+0.000ms): run_local_timers (update_process_times)
00010003 2.281ms (+0.000ms): raise_softirq (update_process_times)
00010003 2.281ms (+0.000ms): scheduler_tick (update_process_times)
00010003 2.281ms (+0.000ms): sched_clock (scheduler_tick)
00010003 2.282ms (+0.000ms): preempt_schedule (scheduler_tick)
00010003 2.282ms (+0.000ms): update_wall_time (do_timer)
00010003 2.282ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 2.282ms (+0.000ms): preempt_schedule (timer_interrupt)
00010003 2.282ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010003 2.283ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010002 2.283ms (+0.000ms): preempt_schedule (do_IRQ)
00000003 2.283ms (+0.000ms): do_softirq (do_IRQ)
00000003 2.283ms (+0.000ms): __do_softirq (do_softirq)
00000002 2.659ms (+0.376ms): smp_apic_timer_interrupt (shrink_dcache_sb)
00010002 2.659ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010003 2.659ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 2.660ms (+0.000ms): preempt_schedule (smp_apic_timer_interrupt)
00000003 2.660ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000003 2.660ms (+0.000ms): __do_softirq (do_softirq)
00010002 3.275ms (+0.615ms): do_IRQ (shrink_dcache_sb)
00010003 3.275ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010003 3.275ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010002 3.276ms (+0.000ms): preempt_schedule (do_IRQ)
00010002 3.276ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010002 3.276ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010003 3.276ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
00010003 3.279ms (+0.002ms): preempt_schedule (mark_offset_pmtmr)
00010003 3.281ms (+0.001ms): preempt_schedule (timer_interrupt)
00010003 3.281ms (+0.000ms): do_timer (timer_interrupt)
00010003 3.281ms (+0.000ms): update_process_times (do_timer)
00010003 3.281ms (+0.000ms): update_one_process (update_process_times)
00010003 3.281ms (+0.000ms): run_local_timers (update_process_times)
00010003 3.281ms (+0.000ms): raise_softirq (update_process_times)
00010003 3.281ms (+0.000ms): scheduler_tick (update_process_times)
00010003 3.281ms (+0.000ms): sched_clock (scheduler_tick)
00010003 3.282ms (+0.000ms): preempt_schedule (scheduler_tick)
00010003 3.282ms (+0.000ms): update_wall_time (do_timer)
00010003 3.282ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 3.282ms (+0.000ms): preempt_schedule (timer_interrupt)
00010003 3.282ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010003 3.283ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00010002 3.283ms (+0.000ms): preempt_schedule (do_IRQ)
00000003 3.283ms (+0.000ms): do_softirq (do_IRQ)
00000003 3.283ms (+0.000ms): __do_softirq (do_softirq)
00000001 3.378ms (+0.095ms): preempt_schedule (do_remount_sb)
00000001 3.379ms (+0.000ms): fsync_super (do_remount_sb)
00000001 3.379ms (+0.000ms): sync_inodes_sb (fsync_super)
00000001 3.379ms (+0.000ms): __read_page_state (sync_inodes_sb)
00000001 3.379ms (+0.000ms): __read_page_state (sync_inodes_sb)
00000002 3.380ms (+0.000ms): sync_sb_inodes (sync_inodes_sb)
00000001 3.380ms (+0.000ms): preempt_schedule (sync_inodes_sb)
00000001 3.380ms (+0.000ms): sync_dquots (fsync_super)
00000001 3.381ms (+0.000ms): vfs_quota_sync (sync_dquots)
00000001 3.381ms (+0.000ms): __might_sleep (vfs_quota_sync)
00000001 3.381ms (+0.000ms): voluntary_resched (vfs_quota_sync)
00000001 3.381ms (+0.000ms): __might_sleep (voluntary_resched)
00000001 3.382ms (+0.000ms): touch_preempt_timing (voluntary_resched)

