Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbULJUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbULJUGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULJUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:06:00 -0500
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:23448 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261803AbULJUEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:04:39 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 14:03:44 -0600
Message-ID: <OF27B09B8B.40A67C86-ON86256F66.006E33A8-86256F66.006E34B3@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/10/2004 02:03:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time, initial test results on -18PK (PREEMPT_DESKTOP, no IRQ
threading).

Again, results running cpu_delay and collecting user triggered traces.

[1] Similar symptoms where I do not get traces that span CPU's plus
the missing trace symptom.

# ./cpu_delay 0.000100
Delay limit set to 0.00010000 seconds
calibrating loop ....
time diff= 0.503365 or 397326229 loops/sec.
Trace activated with 0.000100 second delay.
Trace triggered with 0.000321 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000136 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000139 second delay. [00]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000130 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000240 second delay. [01]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000104 second delay. [02]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000130 second delay. [03]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000109 second delay. [04]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000109 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000155 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000100 second delay. [05]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000105 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000128 second delay. [06]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000123 second delay. [07]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000100 second delay. [08]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000113 second delay. [not recorded]
Trace activated with 0.000100 second delay.
Trace triggered with 0.000136 second delay. [09]

# chrt -f 1 ./get_ltrace.sh 50
Current Maximum is 4965280, limit will be 50.
Resetting max latency from 4965280 to 50.
No new latency samples at Fri Dec 10 13:42:31 CST 2004.
No new latency samples at Fri Dec 10 13:42:41 CST 2004.
No new latency samples at Fri Dec 10 13:42:51 CST 2004.
No new latency samples at Fri Dec 10 13:43:01 CST 2004.
New trace 0 w/ 139 usec latency.
Resetting max latency from 139 to 50.
No new latency samples at Fri Dec 10 13:43:23 CST 2004.
New trace 1 w/ 241 usec latency.
Resetting max latency from 241 to 50.
No new latency samples at Fri Dec 10 13:43:44 CST 2004.
New trace 2 w/ 103 usec latency.
Resetting max latency from 103 to 50.
New trace 3 w/ 130 usec latency.
Resetting max latency from 130 to 50.
No new latency samples at Fri Dec 10 13:44:17 CST 2004.
No new latency samples at Fri Dec 10 13:44:27 CST 2004.
No new latency samples at Fri Dec 10 13:44:37 CST 2004.
New trace 4 w/ 109 usec latency.
Resetting max latency from 109 to 50.
No new latency samples at Fri Dec 10 13:44:58 CST 2004.
New trace 5 w/ 100 usec latency.
Resetting max latency from 100 to 50.
New trace 6 w/ 128 usec latency.
Resetting max latency from 128 to 50.
New trace 7 w/ 123 usec latency.
Resetting max latency from 123 to 50.
New trace 8 w/ 100 usec latency.
Resetting max latency from 100 to 50.
No new latency samples at Fri Dec 10 13:45:54 CST 2004.
New trace 9 w/ 135 usec latency.
Resetting max latency from 135 to 50.

I don't see a significant difference in failures to record when compared
with -18RT (7 vs. 8).

[2] I get no ksoftirqd activity (as expected).

[3] Long sequences of one CPU only was seen again. Though in looking
at these traces I find several incomplete ones like this:

preemption latency trace v1.1.4 on 2.6.10-rc2-mm3-V0.7.32-18PK
--------------------------------------------------------------------
 latency: 139 us, #55/55, CPU#1 | (M:preempt VP:0, KP:1, SP:0 HP:0 #P:2)
    -----------------
    | task: cpu_delay-3517 (uid:0 nice:0 policy:1 rt_prio:30)
    -----------------
 => started at: <00000000>
 => ended at:   <00000000>

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
<unknown-0     0d.h1    0탎 : do_nmi (default_idle)
<unknown-0     0d.h1    0탎 : do_nmi (_raw_spin_lock_irqsave)
<unknown-3517  1d.H2    0탎 : do_nmi (default_idle)
<unknown-0     0d.h1    0탎 : do_nmi (<00200246>)
<unknown-3517  1d.H2    0탎+: do_nmi ((514))
<unknown-0     0...1    3탎 : default_idle (cpu_idle)
<unknown-3517  1d.H2    3탎 : do_IRQ (c013a0cc 0 0)
<unknown-3517  1d.H2    3탎 : _raw_spin_lock (__do_IRQ)
<unknown-3517  1d.H3    4탎 : ack_edge_ioapic_irq (__do_IRQ)
<unknown-3517  1d.H3    4탎 : redirect_hardirq (__do_IRQ)
<unknown-3517  1d.H3    5탎 : _raw_spin_unlock (__do_IRQ)
<unknown-3517  1d.H2    5탎 : handle_IRQ_event (__do_IRQ)
<unknown-3517  1d.H2    5탎 : timer_interrupt (handle_IRQ_event)
<unknown-3517  1d.H2    6탎 : _raw_spin_lock (timer_interrupt)
<unknown-3517  1d.H3    6탎 : mark_offset_tsc (timer_interrupt)
<unknown-3517  1d.H3    7탎 : _raw_spin_lock (mark_offset_tsc)
<unknown-3517  1d.H4    7탎+: _raw_spin_lock_irqsave (mark_offset_tsc)
<unknown-3517  1d.H5   13탎 : _raw_spin_unlock_irqrestore (mark_offset_tsc)
<unknown-3517  1d.H4   14탎 : _raw_spin_unlock (mark_offset_tsc)
<unknown-3517  1d.H3   14탎+: _raw_spin_lock_irqsave (timer_interrupt)
<unknown-3517  1d.H4   18탎 : _raw_spin_unlock_irqrestore (timer_interrupt)
<unknown-3517  1d.H3   18탎 : do_timer (timer_interrupt)
<unknown-3517  1d.H3   19탎 : _raw_spin_unlock (timer_interrupt)
<unknown-3517  1d.H2   19탎 : _raw_spin_lock (__do_IRQ)
<unknown-3517  1d.H3   20탎 : note_interrupt (__do_IRQ)
<unknown-3517  1d.H3   20탎 : end_edge_ioapic_irq (__do_IRQ)
<unknown-3517  1d.H3   21탎 : _raw_spin_unlock (__do_IRQ)
<unknown-3517  1d.H2   21탎 : irq_exit (do_IRQ)
<unknown-3517  1d.s2   21탎 < (0)
<unknown-3517  1..s1   22탎 : mod_timer (rt_check_expire)
<unknown-3517  1..s1   23탎 : __mod_timer (rt_check_expire)
<unknown-3517  1..s1   23탎 : _raw_spin_lock_irqsave (__mod_timer)
<unknown-3517  1d.s2   24탎 : _raw_spin_lock (__mod_timer)
<unknown-3517  1d.s3   24탎 : internal_add_timer (__mod_timer)
<unknown-3517  1d.s3   25탎 : _raw_spin_unlock (__mod_timer)
<unknown-3517  1d.s2   25탎 : _raw_spin_unlock_irqrestore (__mod_timer)
<unknown-3517  1..s1   26탎 : cond_resched_all (run_timer_softirq)
<unknown-3517  1..s1   26탎 : cond_resched_softirq (run_timer_softirq)
<unknown-3517  1..s1   26탎 : _raw_spin_lock_irq (run_timer_softirq)
<unknown-3517  1..s1   27탎 : _raw_spin_lock_irqsave (run_timer_softirq)
<unknown-3517  1d.s2   28탎 : _raw_spin_unlock_irq (run_timer_softirq)
<unknown-3517  1..s1   29탎 : __wake_up (run_timer_softirq)
<unknown-3517  1..s1   29탎 : _raw_spin_lock_irqsave (__wake_up)
<unknown-3517  1d.s2   29탎 : __wake_up_common (__wake_up)
<unknown-3517  1d.s2   30탎 : _raw_spin_unlock_irqrestore
(run_timer_softirq)
<unknown-3517  1..s1   30탎 : cond_resched_all (___do_softirq)
<unknown-3517  1..s1   30탎 : cond_resched_softirq (___do_softirq)
<unknown-3517  1d...   31탎 < (0)
<unknown-3517  1d...   32탎+< (0)
<unknown-3517  1....   35탎 > sys_gettimeofday (00000000 00000000 0000007b)
<unknown-3517  1....   35탎 : sys_gettimeofday (sysenter_past_esp)
<unknown-3517  1....   35탎 : user_trace_stop (sys_gettimeofday)
<unknown-3517  1...1   36탎 : user_trace_stop (sys_gettimeofday)
<unknown-3517  1...1   36탎 : _raw_spin_lock_irqsave (user_trace_stop)
<unknown-3517  1d..2   37탎 : _raw_spin_unlock_irqrestore (user_trace_stop)

I assume that since it does not start with user_trace_start (or something
like that) that the missing portion is the first portion.

[4] Not sure if I can make the same comment on -18PK as I did for -18RT
on changing CPU's [since I understand we do not have the opportunity to
do so unless the IRQ's are threaded].

[5] The trace output cosmetic problems are on PREEMPT_DESKTOP as well.

Traces to come shortly in a separate message.
  --Mark

