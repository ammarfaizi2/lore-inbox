Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUJ3NOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUJ3NOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUJ3NOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:14:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:201 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261160AbUJ3NOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:14:50 -0400
Date: Sat, 30 Oct 2004 15:15:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030131507.GA5189@elte.hu>
References: <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <20041030003122.03bcf01b@mango.fruits.de> <20041030005058.136fe94f@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030005058.136fe94f@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> and another one:
> 
> preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.14-rt
> -------------------------------------------------------
>  latency: 225 us, entries: 36 (36)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: jackd/1083, uid:1000 nice:0 policy:1 rt_prio:60
>     -----------------
>  => started at: try_to_wake_up+0x5a/0x110 <c01151ca>
>  => ended at:   finish_task_switch+0x31/0xc0 <c0115691>
> =======>
>   637 80000000 0.000ms (+0.000ms): (39) ((116))
>   637 80000000 0.000ms (+0.000ms): (1083) ((637))
>   637 80000000 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
>   637 80000000 0.000ms (+0.000ms): preempt_schedule (__up_write)
>   637 00000000 0.000ms (+0.000ms): preempt_schedule (up_write_mutex)
>   637 80000000 0.000ms (+0.000ms): __schedule (preempt_schedule)
>   637 80000000 0.000ms (+0.000ms): profile_hit (__schedule)
>   637 80000000 0.000ms (+0.001ms): sched_clock (__schedule)
>  1083 80000000 0.002ms (+0.000ms): __switch_to (__schedule)
>  1083 80000000 0.002ms (+0.000ms): (637) ((1083))
>  1083 80000000 0.002ms (+0.000ms): (116) ((39))
>  1083 80000000 0.002ms (+0.000ms): finish_task_switch (__schedule)
>  1083 80000000 0.002ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
>  1083 80000000 0.002ms (+0.000ms): (1083) ((39))
>  1083 00000000 0.003ms (+0.000ms): bad_range (free_pages_bulk)
>  1083 00000000 0.003ms (+0.000ms): bad_range (free_pages_bulk)
>  1083 00000000 0.003ms (+0.000ms): _mutex_unlock_irqrestore (free_pages_bulk)
>  1083 00000000 0.003ms (+0.000ms): up_mutex (free_pages_bulk)
>  1083 00000000 0.004ms (+0.000ms): up_write_mutex (free_pages_bulk)
>  1083 00000000 0.004ms (+0.000ms): __up_write (up_write_mutex)
>  1083 80000000 0.004ms (+0.000ms): wake_up_process_mutex (__up_write)
>  1083 80000000 0.004ms (+0.000ms): try_to_wake_up (wake_up_process_mutex)
>  1083 80000000 0.004ms (+0.000ms): task_rq_lock (try_to_wake_up)
>  1083 80000000 0.004ms (+0.000ms): activate_task (try_to_wake_up)
>  1083 80000000 0.004ms (+0.000ms): sched_clock (activate_task)
>  1083 80000000 0.004ms (+0.000ms): recalc_task_prio (activate_task)
>  1083 80000000 0.004ms (+0.000ms): effective_prio (recalc_task_prio)
>  1083 80000000 0.004ms (+0.000ms): enqueue_task (activate_task)
>  1083 80000000 0.005ms (+0.000ms): (115) ((39))
>  1083 80000000 0.005ms (+0.006ms): (782) ((1083))
>  1083 00000000 0.011ms (+0.000ms): sys_gettimeofday (syscall_call)
>  1083 00000000 0.011ms (+0.000ms): user_trace_stop (sys_gettimeofday)
>  1083 80000000 0.012ms (+0.000ms): user_trace_stop (sys_gettimeofday)
>  1083 80000000 0.012ms (+0.000ms): update_max_trace (user_trace_stop)
>  1083 80000000 0.012ms (+0.000ms): _mmx_memcpy (update_max_trace)
>  1083 80000000 0.013ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

should have mentioned that in the user-triggered modus you have to do
the latency measurement in userspace. It is only the trace that is
correct, for the time being. This trace shows what i'd expect a jackd
wakeup to look like normally: 13 usecs.

	Ingo
