Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUHSUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUHSUho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUHSUho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:37:44 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:26265 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267374AbUHSUha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:37:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
References: <20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	<m31xi3j901.fsf@seagha.com>
From: karl.vogel@seagha.com
Date: Thu, 19 Aug 2004 22:37:57 +0200
In-Reply-To: <m31xi3j901.fsf@seagha.com> (karl vogel's message of "Thu, 19
 Aug 2004 20:08:46 +0200")
Message-ID: <m3brh6g8yi.fsf@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following latency trace is generated each time the sound driver is opened
by an application on my box.

# lspci -s 00:06.0
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)

Audio driver:
# lsmod|grep snd
snd_seq                51856  0
snd_intel8x0           30600  0
snd_ac97_codec         66820  1 snd_intel8x0
snd_pcm                88264  1 snd_intel8x0
snd_timer              22596  2 snd_seq,snd_pcm
snd_page_alloc          9288  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6656  1 snd_intel8x0
snd_rawmidi            21156  1 snd_mpu401_uart
snd_seq_device          7176  2 snd_seq,snd_rawmidi
snd                    48804  8 snd_seq,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7840  1 snd



preemption latency trace v1.0.1
-------------------------------
 latency: 50752 us, entries: 267 (267)
    -----------------
    | task: artsd/2502, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: voluntary_resched+0x31/0x60
 => ended at:   sys_ioctl+0xf4/0x2b0
=======>
 0.000ms (+0.000ms): touch_preempt_timing (voluntary_resched)
 0.000ms (+0.000ms): snd_power_wait (snd_pcm_prepare)
 0.000ms (+0.000ms): snd_pcm_action_lock_irq (snd_pcm_prepare)
 0.001ms (+0.000ms): snd_pcm_action_single (snd_pcm_action_lock_irq)
 0.001ms (+0.000ms): snd_pcm_pre_prepare (snd_pcm_action_single)
 0.001ms (+0.000ms): snd_pcm_do_prepare (snd_pcm_action_single)
 0.001ms (+0.000ms): snd_intel8x0_pcm_prepare (snd_pcm_do_prepare)
 0.002ms (+0.000ms): snd_intel8x0_setup_pcm_out (snd_intel8x0_pcm_prepare)
 0.002ms (+0.000ms): igetdword (snd_intel8x0_setup_pcm_out)
 0.002ms (+0.000ms): iputdword (snd_intel8x0_setup_pcm_out)
 0.003ms (+0.000ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 0.003ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 0.003ms (+0.000ms): delay_pmtmr (__delay)
 0.995ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 0.995ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 0.995ms (+0.000ms): delay_pmtmr (__delay)
 1.986ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 1.986ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 1.986ms (+0.000ms): delay_pmtmr (__delay)
 2.978ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 2.978ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 2.978ms (+0.000ms): delay_pmtmr (__delay)
 3.969ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 3.969ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 3.970ms (+0.000ms): delay_pmtmr (__delay)
 4.961ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 4.961ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 4.961ms (+0.000ms): delay_pmtmr (__delay)
 5.953ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 5.953ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 5.953ms (+0.000ms): delay_pmtmr (__delay)
 6.944ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 6.944ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 6.944ms (+0.000ms): delay_pmtmr (__delay)
 7.936ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 7.936ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 7.936ms (+0.000ms): delay_pmtmr (__delay)
 8.927ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 8.927ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 8.927ms (+0.000ms): delay_pmtmr (__delay)
 9.919ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 9.919ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 9.919ms (+0.000ms): delay_pmtmr (__delay)
 10.910ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 10.910ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 10.911ms (+0.000ms): delay_pmtmr (__delay)
 11.902ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 11.902ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 11.902ms (+0.000ms): delay_pmtmr (__delay)
 12.893ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 12.894ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 12.894ms (+0.000ms): delay_pmtmr (__delay)
 13.885ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 13.885ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 13.885ms (+0.000ms): delay_pmtmr (__delay)
 14.877ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 14.877ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 14.877ms (+0.000ms): delay_pmtmr (__delay)
 15.868ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 15.868ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 15.868ms (+0.000ms): delay_pmtmr (__delay)
 16.860ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 16.860ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 16.860ms (+0.000ms): delay_pmtmr (__delay)
 17.851ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 17.851ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 17.851ms (+0.000ms): delay_pmtmr (__delay)
 18.843ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 18.843ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 18.843ms (+0.000ms): delay_pmtmr (__delay)
 19.834ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 19.835ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 19.835ms (+0.000ms): delay_pmtmr (__delay)
 20.826ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 20.826ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 20.826ms (+0.000ms): delay_pmtmr (__delay)
 21.818ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 21.818ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 21.818ms (+0.000ms): delay_pmtmr (__delay)
 22.809ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 22.809ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 22.809ms (+0.000ms): delay_pmtmr (__delay)
 23.801ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 23.801ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 23.801ms (+0.000ms): delay_pmtmr (__delay)
 24.792ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 24.792ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 24.792ms (+0.000ms): delay_pmtmr (__delay)
 25.784ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 25.784ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 25.784ms (+0.000ms): delay_pmtmr (__delay)
 26.775ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 26.775ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 26.776ms (+0.000ms): delay_pmtmr (__delay)
 27.767ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 27.767ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 27.767ms (+0.000ms): delay_pmtmr (__delay)
 28.759ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 28.759ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 28.759ms (+0.000ms): delay_pmtmr (__delay)
 29.750ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 29.750ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 29.750ms (+0.000ms): delay_pmtmr (__delay)
 30.742ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 30.742ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 30.742ms (+0.000ms): delay_pmtmr (__delay)
 31.733ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 31.733ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 31.733ms (+0.000ms): delay_pmtmr (__delay)
 32.725ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 32.725ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 32.725ms (+0.000ms): delay_pmtmr (__delay)
 33.716ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 33.716ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 33.717ms (+0.000ms): delay_pmtmr (__delay)
 34.708ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 34.708ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 34.708ms (+0.000ms): delay_pmtmr (__delay)
 35.700ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 35.700ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 35.700ms (+0.000ms): delay_pmtmr (__delay)
 36.691ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 36.691ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 36.691ms (+0.000ms): delay_pmtmr (__delay)
 37.683ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 37.683ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 37.683ms (+0.000ms): delay_pmtmr (__delay)
 38.674ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 38.674ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 38.674ms (+0.000ms): delay_pmtmr (__delay)
 39.666ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 39.666ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 39.666ms (+0.000ms): delay_pmtmr (__delay)
 40.657ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 40.657ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 40.657ms (+0.000ms): delay_pmtmr (__delay)
 41.649ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 41.649ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 41.649ms (+0.000ms): delay_pmtmr (__delay)
 42.640ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 42.641ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 42.641ms (+0.000ms): delay_pmtmr (__delay)
 43.632ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 43.632ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 43.632ms (+0.000ms): delay_pmtmr (__delay)
 44.624ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 44.624ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 44.624ms (+0.000ms): delay_pmtmr (__delay)
 45.615ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 45.615ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 45.615ms (+0.000ms): delay_pmtmr (__delay)
 46.607ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 46.607ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 46.607ms (+0.000ms): delay_pmtmr (__delay)
 47.598ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 47.598ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 47.598ms (+0.000ms): delay_pmtmr (__delay)
 48.590ms (+0.991ms): __const_udelay (snd_intel8x0_setup_pcm_out)
 48.590ms (+0.000ms): __delay (snd_intel8x0_setup_pcm_out)
 48.590ms (+0.000ms): delay_pmtmr (__delay)
 49.581ms (+0.991ms): iputdword (snd_intel8x0_setup_pcm_out)
 49.582ms (+0.000ms): snd_intel8x0_setup_periods (snd_intel8x0_pcm_prepare)
 49.582ms (+0.000ms): iputdword (snd_intel8x0_setup_periods)
 49.585ms (+0.002ms): iputbyte (snd_intel8x0_setup_periods)
 49.585ms (+0.000ms): iputbyte (snd_intel8x0_setup_periods)
 49.586ms (+0.000ms): iputbyte (snd_intel8x0_setup_periods)
 49.586ms (+0.000ms): snd_pcm_do_reset (snd_pcm_action_single)
 49.586ms (+0.000ms): snd_pcm_lib_ioctl (snd_pcm_do_reset)
 49.586ms (+0.000ms): snd_pcm_lib_ioctl_reset (snd_pcm_do_reset)
 49.587ms (+0.000ms): snd_pcm_post_prepare (snd_pcm_action_single)
 49.587ms (+0.000ms): smp_apic_timer_interrupt (snd_pcm_action_lock_irq)
 49.587ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
 49.588ms (+0.000ms): notifier_call_chain (profile_hook)
 49.588ms (+0.000ms): do_IRQ (snd_pcm_action_lock_irq)
 49.589ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 49.589ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 49.589ms (+0.000ms): wake_up_process (generic_redirect_hardirq)
 49.589ms (+0.000ms): try_to_wake_up (wake_up_process)
 49.589ms (+0.000ms): task_rq_lock (try_to_wake_up)
 49.589ms (+0.000ms): activate_task (try_to_wake_up)
 49.589ms (+0.000ms): sched_clock (activate_task)
 49.590ms (+0.000ms): recalc_task_prio (activate_task)
 49.590ms (+0.000ms): effective_prio (recalc_task_prio)
 49.590ms (+0.000ms): enqueue_task (activate_task)
 49.590ms (+0.000ms): preempt_schedule (try_to_wake_up)
 49.590ms (+0.000ms): preempt_schedule (do_IRQ)
 49.591ms (+0.000ms): do_IRQ (snd_pcm_action_lock_irq)
 49.591ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
 49.591ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 49.591ms (+0.000ms): preempt_schedule (do_IRQ)
 49.591ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 49.591ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 49.592ms (+0.000ms): mark_offset_pmtmr (timer_interrupt)
 49.598ms (+0.006ms): do_timer (timer_interrupt)
 49.598ms (+0.000ms): update_process_times (do_timer)
 49.598ms (+0.000ms): update_one_process (update_process_times)
 49.598ms (+0.000ms): run_local_timers (update_process_times)
 49.598ms (+0.000ms): raise_softirq (update_process_times)
 49.598ms (+0.000ms): scheduler_tick (update_process_times)
 49.598ms (+0.000ms): sched_clock (scheduler_tick)
 49.599ms (+0.000ms): task_timeslice (scheduler_tick)
 49.599ms (+0.000ms): update_wall_time (do_timer)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.599ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.600ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.601ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.602ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 49.603ms (+0.000ms): generic_note_interrupt (do_IRQ)
 49.604ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
 49.604ms (+0.000ms): preempt_schedule (do_IRQ)
 49.604ms (+0.000ms): do_softirq (do_IRQ)
 49.604ms (+0.000ms): __do_softirq (do_softirq)
 49.604ms (+0.000ms): wake_up_process (do_softirq)
 49.604ms (+0.000ms): try_to_wake_up (wake_up_process)
 49.604ms (+0.000ms): task_rq_lock (try_to_wake_up)
 49.604ms (+0.000ms): activate_task (try_to_wake_up)
 49.604ms (+0.000ms): sched_clock (activate_task)
 49.604ms (+0.000ms): recalc_task_prio (activate_task)
 49.605ms (+0.000ms): effective_prio (recalc_task_prio)
 49.605ms (+0.000ms): enqueue_task (activate_task)
 49.605ms (+0.000ms): preempt_schedule (snd_pcm_action_lock_irq)
 49.605ms (+0.000ms): sub_preempt_count (sys_ioctl)


sound/pci/intel8x0.c contains:

                if (chip->device_type == DEVICE_NFORCE) {
                        /* reset to 2ch once to keep the 6 channel data in alignment,
                         * to start from Front Left always
                         */
                        iputdword(chip, ICHREG(GLOB_CNT), (cnt & 0xcfffff));
                        mdelay(50); /* grrr... */
                } else if (chip->device_type == DEVICE_INTEL_ICH4) {

So I guess it's that mdelay(50) which is generating these (each time the
device is opened).

