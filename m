Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUIQHV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUIQHV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIQHV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:21:29 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:28141 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268497AbUIQHV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:21:27 -0400
Message-ID: <470b6397040917002148431e02@mail.gmail.com>
Date: Fri, 17 Sep 2004 00:21:27 -0700
From: Tony Lee <tony.p.lee@gmail.com>
Reply-To: Tony Lee <tony.p.lee@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Cc: Bill Huey <bhuey@lnxw.com>, "David S. Miller" <davem@davemloft.net>,
       davidsen@tmr.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040917064321.GA8146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m3vfefa61l.fsf@averell.firstfloor.org>
	 <cic7f9$i4m$1@gatekeeper.tmr.com>
	 <20040916222903.GA4089@nietzsche.lynx.com>
	 <20040916154011.3f0dbd54.davem@davemloft.net>
	 <20040916225102.GA4386@nietzsche.lynx.com>
	 <20040917064321.GA8146@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 08:43:21 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Bill Huey <bhuey@lnxw.com> wrote:
> 
> > Judging from how the Linux code is done and the numbers I get from
> > Bill Irwin in casual conversation, the Linux SMP approach is clearly
> > the right track at this time with it's hand honed per-CPU awareness of
> > things. The only serious problem that spinlocks have as they aren't
> > preemptable, which is what Ingo is trying to fix.
> 
> a clarification: note that the current BKL is a special case. No way do
> i suggest that the BKS is the proper model for any SMP implementation.
> It is a narrow special-case because it wraps historic UP-only kernel
> code.
> 
> our primary multiprocessing primitives are still the following 4:
> lockless data structures, RCU, spinlocks and mutexes. (reverse ordered
> by level of parallelism.) The BKS is basically a fifth method, a special
> type of semaphore that i'd never want to be seen used by any new SMP
> code. It is completely local to sched.c.
> 
>         Ingo

I coded a IPC system before use atomic add + share memory.  
It works very well (fast) on 4 CPU SMP system, since it doesn't use 
any locking API at all.    Very good for resource allocation for 
SMP.     I implemented speciall malloc/free use by ISR, different
prority process
completely without any lock.   Negative side, it use more memory.


-- 
-Tony
Having a lot of fun with Xilinx Virtex Pro II reconfigurable HW + ppc + Linux
