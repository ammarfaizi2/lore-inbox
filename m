Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUIAPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUIAPXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUIAPXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:23:05 -0400
Received: from lax-gate4.raytheon.com ([199.46.200.233]:8816 "EHLO
	lax-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S266854AbUIAPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:22:50 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Wed, 1 Sep 2004 10:21:24 -0500
Message-ID: <OFC12F3DB5.BA677210-ON86256F02.00545B49-86256F02.00545B58@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/01/2004 10:21:34 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>... Need to increase that data area so
>#define PERCPU_ENOUGH_ROOM 196608
>or something similar (should leave about 50K free for modules).
>
>I will rebuild with this change plus the latest of the others.

This booted fine today.

I reported the results of the audio patch separately. That seems to have
removed the audio latencies I saw previously.

A Whopper!
==========

A latency trace > 20 msec was seen (once). It starts pretty bad and then
gets stuck in a 1 msec loop.

preemption latency trace v1.0.2
-------------------------------
 latency: 23120 us, entries: 406 (406)
    -----------------
    | task: latencytest/4999, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: del_timer+0x4c/0x150
 => ended at:   del_timer+0xf2/0x150
=======>
00000001 0.000ms (+0.000ms): del_timer (del_singleshot_timer_sync)
00000001 0.700ms (+0.700ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 0.700ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 0.701ms (+0.000ms): profile_hook (profile_tick)
00010002 0.701ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.702ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 0.702ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 0.702ms (+0.000ms): update_one_process (update_process_times)
00010001 0.703ms (+0.000ms): run_local_timers (update_process_times)
00010001 0.703ms (+0.000ms): raise_softirq (update_process_times)
00010001 0.703ms (+0.000ms): scheduler_tick (update_process_times)
00010001 0.703ms (+0.000ms): sched_clock (scheduler_tick)
00010001 0.704ms (+0.001ms): rebalance_tick (scheduler_tick)
00000002 0.704ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 0.705ms (+0.000ms): __do_softirq (do_softirq)
00000002 0.705ms (+0.000ms): wake_up_process (do_softirq)
00000002 0.705ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 0.705ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.706ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.706ms (+0.000ms): sched_clock (activate_task)
00000003 0.706ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.706ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.706ms (+0.000ms): enqueue_task (activate_task)
00010001 1.301ms (+0.594ms): do_IRQ (.text.lock.timer)
00010002 1.302ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010002 1.302ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010003 1.302ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010003 1.302ms (+0.000ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010002 1.315ms (+0.013ms): generic_redirect_hardirq (do_IRQ)
00010001 1.315ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 1.316ms (+0.000ms): usb_hcd_irq (generic_handle_IRQ_event)
00010001 1.316ms (+0.000ms): uhci_irq (usb_hcd_irq)
00010001 1.316ms (+0.000ms): usb_hcd_irq (generic_handle_IRQ_event)
00010001 1.317ms (+0.000ms): uhci_irq (usb_hcd_irq)
00010001 1.317ms (+0.000ms): snd_audiopci_interrupt
(generic_handle_IRQ_event)
00010001 1.319ms (+0.001ms): snd_pcm_period_elapsed
(snd_audiopci_interrupt)
00010003 1.319ms (+0.000ms): snd_ensoniq_playback1_pointer
(snd_pcm_period_elapsed)
00010003 1.321ms (+0.001ms): snd_pcm_playback_silence
(snd_pcm_period_elapsed)
00010003 1.321ms (+0.000ms): __wake_up (snd_pcm_period_elapsed)
00010004 1.321ms (+0.000ms): __wake_up_common (__wake_up)
00010004 1.322ms (+0.000ms): default_wake_function (__wake_up_common)
00010004 1.322ms (+0.000ms): try_to_wake_up (__wake_up_common)
00010004 1.322ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010001 1.323ms (+0.000ms): kill_fasync (snd_pcm_period_elapsed)
00010002 1.323ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 1.323ms (+0.000ms): end_level_ioapic_irq (do_IRQ)
00010002 1.323ms (+0.000ms): unmask_IO_APIC_irq (do_IRQ)
00010003 1.324ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00010003 1.324ms (+0.000ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00000002 1.338ms (+0.013ms): do_softirq (do_IRQ)
00000002 1.338ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.699ms (+0.361ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 1.700ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 1.700ms (+0.000ms): profile_hook (profile_tick)
00010002 1.700ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 1.700ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 1.700ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 1.701ms (+0.000ms): update_one_process (update_process_times)
00010001 1.701ms (+0.000ms): run_local_timers (update_process_times)
00010001 1.701ms (+0.000ms): raise_softirq (update_process_times)
00010001 1.701ms (+0.000ms): scheduler_tick (update_process_times)
00010001 1.701ms (+0.000ms): sched_clock (scheduler_tick)
00010001 1.702ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 1.702ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 1.702ms (+0.000ms): __do_softirq (do_softirq)
00000001 2.699ms (+0.996ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 2.699ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 2.699ms (+0.000ms): profile_hook (profile_tick)
00010002 2.699ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 2.699ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 2.700ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 2.700ms (+0.000ms): update_one_process (update_process_times)
00010001 2.700ms (+0.000ms): run_local_timers (update_process_times)
00010001 2.700ms (+0.000ms): raise_softirq (update_process_times)
00010001 2.700ms (+0.000ms): scheduler_tick (update_process_times)
00010001 2.701ms (+0.000ms): sched_clock (scheduler_tick)
00010001 2.701ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 2.701ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 2.701ms (+0.000ms): __do_softirq (do_softirq)
00010001 2.759ms (+0.057ms): do_IRQ (.text.lock.timer)
00010002 2.759ms (+0.000ms): mask_and_ack_level_ioapic_irq (do_IRQ)
00010002 2.759ms (+0.000ms): mask_IO_APIC_irq
(mask_and_ack_level_ioapic_irq)
00010003 2.760ms (+0.000ms): __mask_IO_APIC_irq (mask_IO_APIC_irq)
00010003 2.760ms (+0.000ms): __modify_IO_APIC_irq (__mask_IO_APIC_irq)
00010002 2.773ms (+0.013ms): generic_redirect_hardirq (do_IRQ)
00010001 2.773ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010001 2.773ms (+0.000ms): usb_hcd_irq (generic_handle_IRQ_event)
00010001 2.774ms (+0.000ms): uhci_irq (usb_hcd_irq)
00010001 2.774ms (+0.000ms): usb_hcd_irq (generic_handle_IRQ_event)
00010001 2.774ms (+0.000ms): uhci_irq (usb_hcd_irq)
00010001 2.775ms (+0.000ms): snd_audiopci_interrupt
(generic_handle_IRQ_event)
00010001 2.776ms (+0.001ms): snd_pcm_period_elapsed
(snd_audiopci_interrupt)
00010003 2.777ms (+0.000ms): snd_ensoniq_playback1_pointer
(snd_pcm_period_elapsed)
00010003 2.778ms (+0.001ms): snd_pcm_playback_silence
(snd_pcm_period_elapsed)
00010003 2.779ms (+0.001ms): snd_pcm_format_set_silence
(snd_pcm_playback_silence)
00010003 2.780ms (+0.000ms): snd_pcm_format_set_silence
(snd_pcm_playback_silence)
00010003 2.781ms (+0.000ms): xrun (snd_pcm_period_elapsed)
00010003 2.781ms (+0.000ms): snd_pcm_stop (xrun)
00010003 2.782ms (+0.000ms): snd_pcm_action (snd_pcm_stop)
00010003 2.783ms (+0.000ms): snd_pcm_action_single (snd_pcm_action)
00010003 2.783ms (+0.000ms): snd_pcm_pre_stop (snd_pcm_action_single)
00010003 2.783ms (+0.000ms): snd_pcm_do_stop (snd_pcm_action_single)
00010003 2.784ms (+0.000ms): snd_ensoniq_trigger (snd_pcm_do_stop)
00010003 2.786ms (+0.001ms): snd_pcm_post_stop (snd_pcm_action_single)
00010003 2.786ms (+0.000ms): snd_pcm_trigger_tstamp (snd_pcm_post_stop)
00010003 2.787ms (+0.000ms): do_gettimeofday (snd_pcm_trigger_tstamp)
00010003 2.787ms (+0.000ms): get_offset_tsc (do_gettimeofday)
00010003 2.788ms (+0.000ms): snd_timer_notify (snd_pcm_post_stop)
00010003 2.789ms (+0.001ms): snd_pcm_tick_set (snd_pcm_post_stop)
00010003 2.790ms (+0.000ms): snd_pcm_system_tick_set (snd_pcm_post_stop)
00010003 2.790ms (+0.000ms): del_timer (snd_pcm_post_stop)
00010003 2.791ms (+0.000ms): __wake_up (snd_pcm_action_single)
00010004 2.791ms (+0.000ms): __wake_up_common (__wake_up)
00010004 2.791ms (+0.000ms): default_wake_function (__wake_up_common)
00010004 2.791ms (+0.000ms): try_to_wake_up (__wake_up_common)
00010004 2.791ms (+0.000ms): task_rq_lock (try_to_wake_up)
00010001 2.792ms (+0.000ms): kill_fasync (snd_pcm_period_elapsed)
00010002 2.793ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 2.793ms (+0.000ms): end_level_ioapic_irq (do_IRQ)
00010002 2.793ms (+0.000ms): unmask_IO_APIC_irq (do_IRQ)
00010003 2.793ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00010003 2.793ms (+0.000ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00000002 2.807ms (+0.013ms): do_softirq (do_IRQ)
00000002 2.807ms (+0.000ms): __do_softirq (do_softirq)
00000001 3.698ms (+0.890ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 3.698ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 3.698ms (+0.000ms): profile_hook (profile_tick)
00010002 3.699ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 3.699ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 3.699ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 3.699ms (+0.000ms): update_one_process (update_process_times)
00010001 3.700ms (+0.000ms): run_local_timers (update_process_times)
00010001 3.700ms (+0.000ms): raise_softirq (update_process_times)
00010001 3.700ms (+0.000ms): scheduler_tick (update_process_times)
00010001 3.700ms (+0.000ms): sched_clock (scheduler_tick)
00010001 3.701ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 3.701ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 3.701ms (+0.000ms): __do_softirq (do_softirq)
00000001 4.697ms (+0.996ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 4.698ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 4.698ms (+0.000ms): profile_hook (profile_tick)
00010002 4.698ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 4.698ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 4.698ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 4.699ms (+0.000ms): update_one_process (update_process_times)
00010001 4.699ms (+0.000ms): run_local_timers (update_process_times)
00010001 4.699ms (+0.000ms): raise_softirq (update_process_times)
00010001 4.699ms (+0.000ms): scheduler_tick (update_process_times)
00010001 4.699ms (+0.000ms): sched_clock (scheduler_tick)
00010001 4.700ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 4.700ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 4.700ms (+0.000ms): __do_softirq (do_softirq)
00000001 5.697ms (+0.996ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 5.697ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 5.697ms (+0.000ms): profile_hook (profile_tick)
00010002 5.697ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 5.698ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 5.698ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 5.698ms (+0.000ms): update_one_process (update_process_times)
00010001 5.698ms (+0.000ms): run_local_timers (update_process_times)
00010001 5.698ms (+0.000ms): raise_softirq (update_process_times)
00010001 5.698ms (+0.000ms): scheduler_tick (update_process_times)
(this cycle repeats several times, exited as follows)
00000001 21.686ms (+0.996ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 21.686ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 21.686ms (+0.000ms): profile_hook (profile_tick)
00010002 21.686ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 21.687ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 21.687ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 21.687ms (+0.000ms): update_one_process (update_process_times)
00010001 21.687ms (+0.000ms): run_local_timers (update_process_times)
00010001 21.687ms (+0.000ms): raise_softirq (update_process_times)
00010001 21.687ms (+0.000ms): scheduler_tick (update_process_times)
00010001 21.688ms (+0.000ms): sched_clock (scheduler_tick)
00010001 21.688ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 21.688ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 21.688ms (+0.000ms): __do_softirq (do_softirq)
00000001 22.685ms (+0.996ms): smp_apic_timer_interrupt (.text.lock.timer)
00010001 22.685ms (+0.000ms): profile_tick (smp_apic_timer_interrupt)
00010001 22.685ms (+0.000ms): profile_hook (profile_tick)
00010002 22.686ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 22.686ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)
00010001 22.686ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010001 22.686ms (+0.000ms): update_one_process (update_process_times)
00010001 22.686ms (+0.000ms): run_local_timers (update_process_times)
00010001 22.686ms (+0.000ms): raise_softirq (update_process_times)
00010001 22.687ms (+0.000ms): scheduler_tick (update_process_times)
00010001 22.687ms (+0.000ms): sched_clock (scheduler_tick)
00010001 22.687ms (+0.000ms): rebalance_tick (scheduler_tick)
00000002 22.687ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000002 22.688ms (+0.000ms): __do_softirq (do_softirq)
00000001 23.120ms (+0.432ms): sub_preempt_count (del_timer)
00000001 23.121ms (+0.000ms): update_max_trace (check_preempt_timing)

TSC mcount
==========

>From your patch, added several mcount() calls to mark_offset_tsc.
To summarize the trace results, here is a table that reports the
delta times for each location. Each row represents one of the dozen
trace outputs per latency trace. Row columns are the file names
(lt.xx) in the tar file. Times are in usec.

     01  03  04  13  16  26  27  31  32  35  37  39
01  000 000 000 069 000 000 000 000 000 081 136 000
02  032 000 000 000 000 000 000 000 000 000 000 000
03  000 000 000 000 000 000 000 000 000 000 000 000
04  001 000 000 070 231 139 138 093 252 062 000 067
05  000 000 000 000 000 000 000 000 000 000 000 000
06  042 003 003 004 003 004 004 053 145 076 003 004
07  004 004 004 004 008 004 005 006 010 011 004 005
08  001 001 002 002 008 002 002 002 001 002 001 002
09  000 000 000 000 000 000 000 000 000 000 000 000
10  000 000 000 000 000 000 000 000 000 000 000 000
11  000 000 000 000 000 000 000 000 000 000 000 000
12  000 000 000 061 000 130 129 129 000 000 000 060

NOTE: This is not all the results w/ mark_offset_tsc listed. After the
first few items, I only listed those with significant (>100 usec) delays.

Network Poll
============

I still have a few traces w/ long durations during network poll. Since
you merged that other change into Q6 (and I assume Q7) I will try that
later today.

I will also try to make a modified version of latencytest that does
the extended trace of the write system call (occasionally) to see what
is going on there as well.

For reference, I will send the tar file with all the traces in another
message (not to linux-kernel).

 --Mark

