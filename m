Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUIIToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUIIToN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIITm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:42:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14546 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266836AbUIITdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:33:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com,
       scott@timesys.com
In-Reply-To: <20040909192924.GA1672@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
Content-Type: text/plain
Message-Id: <1094758399.1362.268.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 15:33:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:29, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I get these latencies when I cause the machine to swap by compiling a
> > kernel with make -j32.  They get bigger as the machine gets further
> > into swap.
> > 
> > Every 2.0s: head -60 /proc/latency_trace                                                                                                                             Wed Sep  8 02:51:40 2004
> > 
> > preemption latency trace v1.0.6 on 2.6.9-rc1-bk12-VP-R6
> > --------------------------------------------------
> >  latency: 605 us, entries: 5 (5)  [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
> >     -----------------
> >     | task: kswapd0/35, uid:0 nice:0 policy:0 rt_prio:0
> >     -----------------
> >  => started at: get_swap_page+0x23/0x490
> >  => ended at:   get_swap_page+0x13f/0x490
> > =======>
> > 00000001 0.000ms (+0.606ms): get_swap_page (add_to_swap)
> > 00000001 0.606ms (+0.000ms): sub_preempt_count (get_swap_page)
> > 00000001 0.606ms (+0.000ms): update_max_trace (check_preempt_timing)
> > 00000001 0.606ms (+0.000ms): _mmx_memcpy (update_max_trace)
> > 00000001 0.607ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)
> 
> yep, the get_swap_page() latency. I can easily trigger 10+ msec
> latencies on a box with alot of swap by just letting stuff swap out. I
> had a quick look but there was no obvious way to break the lock. Maybe
> Andrew has better ideas? get_swap_page() is pretty stupid, it does a
> near linear search for a free slot in the swap bitmap - this not only is
> a latency issue but also an overhead thing as we do it for every other
> page that touches swap.
> 
> rationale: this is pretty much the only latency that we still having
> during heavy VM load and it would Just Be Cool if we fixed this final
> one. audio daemons and apps like jackd use mlockall() so they are not
> affected by swapping.
> 

I believe Scott Wood suggested a fix back when I first reported this,
have to check my mailbox.  Scott?

Lee


