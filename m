Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbUKQSW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUKQSW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUKQSUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:20:44 -0500
Received: from brown.brainfood.com ([146.82.138.61]:63387 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262399AbUKQSTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:19:35 -0500
Date: Wed, 17 Nov 2004 12:18:53 -0600 (CST)
From: Adam Heath <adam@doogie.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-10
In-Reply-To: <20041117124234.GA25956@elte.hu>
Message-ID: <Pine.LNX.4.58.0411171214220.11137@gradall.private.brainfood.com>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
 <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
 <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
 <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu>
 <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu>
 <20041117124234.GA25956@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Ingo Molnar wrote:

>
> i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
> 	http://redhat.com/~mingo/realtime-preempt/
>
> this is a fixes & latency-reduction release.
>
> Changes since a -V0.7.27-3:

Running .26-5.  Been running almost 2 days.  All small latency values.  Then,
just a few minutes ago, got a 133us value:

preemption latency trace v1.0.7 on 2.6.10-rc1-mm3-RT-V0.7.26-5
-------------------------------------------------------
 latency: 133 us, entries: 41 (41)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: IRQ 15/19, uid:0 nice:-10 policy:1 rt_prio:46
    -----------------
 => started at: try_to_wake_up+0x5a/0x110 <c0115f1a>
 => ended at:   finish_task_switch+0x51/0xc0 <c0116401>
=======>
    0 80000000 00000000 [0284618592175289] 0.000ms (+0.000ms): trace_start_sched_wakeup+0x8e/0xc0 <c013623e> (try_to_wake_up+0x5a/0x110 <c0115f1a>)
    0 80000000 00000001 [0284618592175411] 0.000ms (+0.000ms): <00000034> (<0000008c>)
    0 80000000 00000002 [0284618592175481] 0.000ms (+0.000ms): <00000013> (<00000000>)
    0 80000000 00000003 [0284618592175763] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (try_to_wake_up+0xf6/0x110 <c0115fb6>)
    0 80000000 00000004 [0284618592175975] 0.000ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (__do_IRQ+0x13d/0x170 <c013f3cd>)
    0 80000000 00000005 [0284618592176118] 0.000ms (+0.127ms): irq_exit+0xb/0x50 <c013f10b> (do_IRQ+0x53/0x70 <c01080d3>)
    0 80000000 00000006 [0284618592387634] 0.127ms (+0.000ms): do_IRQ+0x0/0x70 <c0108080> (<0000a253>)
    0 80000000 00000007 [0284618592387690] 0.127ms (+0.000ms): do_IRQ+0x0/0x70 <c0108080> (<0000000e>)
    0 80000000 00000008 [0284618592387909] 0.128ms (+0.001ms): mask_and_ack_8259A+0xe/0x110 <c010b98e> (__do_IRQ+0x86/0x170 <c013f316>)
    0 80000000 00000009 [0284618592390653] 0.129ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (__do_IRQ+0x86/0x170 <c013f316>)
    0 80000000 0000000a [0284618592390834] 0.129ms (+0.000ms): redirect_hardirq+0xe/0xa0 <c013f15e> (__do_IRQ+0xbe/0x170 <c013f34e>)
    0 80000000 0000000b [0284618592390971] 0.129ms (+0.000ms): wake_up_process+0xb/0x30 <c0115fdb> (redirect_hardirq+0x6e/0xa0 <c013f1be>)
    0 80000000 0000000c [0284618592391058] 0.129ms (+0.000ms): try_to_wake_up+0xe/0x110 <c0115ece> (wake_up_process+0x2b/0x30 <c0115ffb>)
    0 80000000 0000000d [0284618592391145] 0.130ms (+0.000ms): task_rq_lock+0xb/0x30 <c0115a8b> (try_to_wake_up+0x27/0x110 <c0115ee7>)
    0 80000000 0000000e [0284618592391351] 0.130ms (+0.000ms): activate_task+0x11/0xa0 <c0115df1> (try_to_wake_up+0x5a/0x110 <c0115f1a>)
    0 80000000 0000000f [0284618592391455] 0.130ms (+0.000ms): sched_clock+0x14/0x80 <c01103c4> (activate_task+0x1c/0xa0 <c0115dfc>)
    0 80000000 00000010 [0284618592391614] 0.130ms (+0.000ms): recalc_task_prio+0xe/0x190 <c0115c5e> (activate_task+0x32/0xa0 <c0115e12>)
    0 80000000 00000011 [0284618592391773] 0.130ms (+0.000ms): effective_prio+0x8/0x60 <c0115bf8> (recalc_task_prio+0x98/0x190 <c0115ce8>)
    0 80000000 00000012 [0284618592391929] 0.130ms (+0.000ms): enqueue_task+0x12/0x50 <c0115bb2> (activate_task+0x6c/0xa0 <c0115e4c>)
    0 80000000 00000013 [0284618592392059] 0.130ms (+0.000ms): trace_start_sched_wakeup+0xe/0xc0 <c01361be> (try_to_wake_up+0x5a/0x110 <c0115f1a>)
    0 80000000 00000014 [0284618592392333] 0.130ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (try_to_wake_up+0x5a/0x110 <c0115f1a>)
    0 80000000 00000015 [0284618592392439] 0.130ms (+0.000ms): <00000034> (<0000008c>)
    0 80000000 00000016 [0284618592392510] 0.130ms (+0.000ms): <00000012> (<00000000>)
    0 80000000 00000017 [0284618592392714] 0.130ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (try_to_wake_up+0xf6/0x110 <c0115fb6>)
    0 80000000 00000018 [0284618592392916] 0.131ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (__do_IRQ+0x13d/0x170 <c013f3cd>)
    0 80000000 00000019 [0284618592393022] 0.131ms (+0.000ms): irq_exit+0xb/0x50 <c013f10b> (do_IRQ+0x53/0x70 <c01080d3>)
    0 80000000 0000001a [0284618592393709] 0.131ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (apm_bios_call_simple+0xd5/0xf0 <c0110ff5>)
    0 80000000 0000001b [0284618592393899] 0.131ms (+0.000ms): apm_do_busy+0xb/0x40 <c01111eb> (cpu_idle+0x4c/0x70 <c0103f9c>)
    0 80000000 0000001c [0284618592393987] 0.131ms (+0.000ms): apm_bios_call_simple+0xe/0xf0 <c0110f2e> (apm_do_busy+0x2e/0x40 <c011120e>)
    0 80000000 0000001d [0284618592394648] 0.132ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (apm_bios_call_simple+0xd5/0xf0 <c0110ff5>)
    0 00000000 0000001e [0284618592394819] 0.132ms (+0.000ms): preempt_schedule+0x11/0x80 <c02bbb81> (cpu_idle+0x64/0x70 <c0103fb4>)
    0 80000000 0000001f [0284618592394966] 0.132ms (+0.000ms): __schedule+0xe/0x6b0 <c02bb38e> (preempt_schedule+0x58/0x80 <c02bbbc8>)
    0 80000000 00000020 [0284618592395053] 0.132ms (+0.000ms): profile_hit+0x9/0x50 <c011bec9> (__schedule+0x43/0x6b0 <c02bb3c3>)
    0 80000000 00000021 [0284618592395254] 0.132ms (+0.000ms): sched_clock+0x14/0x80 <c01103c4> (__schedule+0x70/0x6b0 <c02bb3f0>)
   19 80000000 00000022 [0284618592395691] 0.132ms (+0.000ms): __switch_to+0xe/0x190 <c01049ae> (__schedule+0x2fc/0x6b0 <c02bb67c>)
   19 80000000 00000023 [0284618592395824] 0.132ms (+0.000ms): <00000000> (<00000013>)
   19 80000000 00000024 [0284618592395876] 0.132ms (+0.000ms): <0000008c> (<00000034>)
   19 80000000 00000025 [0284618592395941] 0.132ms (+0.000ms): finish_task_switch+0x14/0xc0 <c01163c4> (__schedule+0x345/0x6b0 <c02bb6c5>)
   19 80000000 00000026 [0284618592396082] 0.133ms (+0.000ms): trace_stop_sched_switched+0x14/0x190 <c0136284> (finish_task_switch+0x51/0xc0 <c0116401>)
   19 80000000 00000027 [0284618592396150] 0.133ms (+0.002ms): <00000013> (<00000034>)
   19 80000000 00000028 [0284618592399999] 0.135ms (+0.000ms): trace_stop_sched_switched+0x133/0x190 <c01363a3> (finish_task_switch+0x51/0xc0 <c0116401>)

Note the jump in irq_exit/do_IRQ.

I have .27-11 installed, but hadn't rebooted yet into it.  Will compile .28-0,
and hopefully boot into it today.

