Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUJCHGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUJCHGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUJCHGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:06:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2250 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267734AbUJCHGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:06:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1096786248.1837.4.camel@krustophenia.net>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
	 <1096785457.1837.0.camel@krustophenia.net>
	 <1096786248.1837.4.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1096787179.1837.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 03:06:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-03 at 02:50, Lee Revell wrote:
> On Sun, 2004-10-03 at 02:37, Lee Revell wrote:
> > On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> > > i've released the -S7 VP patch:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> > > 
> > 
> > This one was caused by amlat:
> 
> And here's another produced by "lsof /foo":
> 

Finally, there's this one which makes no sense to me:

preemption latency trace v1.0.7 on 2.6.9-rc2-mm4-VP-S7
-------------------------------------------------------
 latency: 507 us, entries: 45 (45)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: events/0/3, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: kernel_fpu_begin+0x15/0x70
 => ended at:   _mmx_memcpy+0x13a/0x180
=======>
00000001 0.000ms (+0.002ms): kernel_fpu_begin (_mmx_memcpy)
00010001 0.002ms (+0.000ms): do_IRQ (_mmx_memcpy)
00010001 0.002ms (+0.000ms): do_IRQ (<00000000>)

[ timer interrupt stuff ] 

00010001 0.024ms (+0.000ms): preempt_schedule (do_IRQ)
00000002 0.025ms (+0.000ms): do_softirq (do_IRQ)
00000002 0.025ms (+0.000ms): __do_softirq (do_softirq)
00000002 0.025ms (+0.000ms): wake_up_process (do_softirq)
00000002 0.026ms (+0.000ms): try_to_wake_up (wake_up_process)
00000002 0.026ms (+0.000ms): task_rq_lock (try_to_wake_up)
00000003 0.026ms (+0.000ms): activate_task (try_to_wake_up)
00000003 0.027ms (+0.000ms): sched_clock (activate_task)
00000003 0.027ms (+0.000ms): recalc_task_prio (activate_task)
00000003 0.028ms (+0.000ms): effective_prio (recalc_task_prio)
00000003 0.028ms (+0.000ms): enqueue_task (activate_task)
00000002 0.028ms (+0.478ms): preempt_schedule (try_to_wake_up)
00000001 0.507ms (+0.000ms): sub_preempt_count (_mmx_memcpy)
00000001 0.508ms (+0.000ms): update_max_trace (check_preempt_timing)
00000001 0.508ms (+0.000ms): _mmx_memcpy (update_max_trace)
00000001 0.508ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

478 usecs in try_to_wake_up?

Lee

