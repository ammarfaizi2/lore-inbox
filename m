Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbUKPWIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUKPWIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKPWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:05:35 -0500
Received: from pop.gmx.de ([213.165.64.20]:58285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261859AbUKPWDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:03:55 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 23:04:43 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116230443.452497b9@mango.fruits.de>
In-Reply-To: <20041116224257.GB27550@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<20041116223243.43feddf4@mango.fruits.de>
	<20041116224257.GB27550@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 23:42:57 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> this is either a false positive, or we missed a preemption. To see which
> one, could you apply the attached patch and try to reproduce this long
> trace? The new trace will tell us whether need_resched is set during
> that ~1 msec window.

hmm, the output doens't look so much different (or am i just blind?). maybe
i need to do make clean before building with this patch applied?

flo


preemption latency trace v1.0.7 on 2.6.10-rc2-mm1-RT-V0.7.27-10
-------------------------------------------------------
 latency: 992 us, entries: 22 (22)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: IRQ 0/2, uid:0 nice:0 policy:1 rt_prio:49
    -----------------
 => started at: try_to_wake_up+0x51/0x170 <c010f3a1>
 => ended at:   finish_task_switch+0x51/0xb0 <c010f911>
=======>
    5 80010004 0.000ms (+0.000ms): trace_start_sched_wakeup (try_to_wake_up)
    5 88010003 0.000ms (+0.000ms): (50) ((98))
    5 88010003 0.000ms (+0.000ms): (2) ((5))
    5 88010003 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
    5 88010003 0.000ms (+0.000ms): (0) ((1))
    5 88010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    5 88010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
    5 88010001 0.000ms (+0.000ms): preempt_schedule (__do_IRQ)
    5 88010001 0.000ms (+0.000ms): irq_exit (do_IRQ)
    5 88000002 0.000ms (+0.000ms): do_softirq (irq_exit)
    5 88000002 0.001ms (+0.990ms): __do_softirq (do_softirq)
    5 08000000 0.991ms (+0.000ms): preempt_schedule (_mmx_memcpy)
    5 98000000 0.991ms (+0.000ms): __schedule (preempt_schedule)
    5 98000000 0.991ms (+0.000ms): profile_hit (__schedule)
    5 98000001 0.991ms (+0.000ms): sched_clock (__schedule)
    2 80000002 0.991ms (+0.000ms): __switch_to (__schedule)
    2 80000002 0.991ms (+0.000ms): (5) ((2))
    2 80000002 0.992ms (+0.000ms): (98) ((50))
    2 80000002 0.992ms (+0.000ms): finish_task_switch (__schedule)
    2 80000001 0.992ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
    2 80000001 0.992ms (+0.001ms): (2) ((50))
    2 80000001 0.993ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)

