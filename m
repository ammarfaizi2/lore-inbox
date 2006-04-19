Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWDSRsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWDSRsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWDSRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:48:14 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47766 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750999AbWDSRsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:48:14 -0400
Subject: Re: BUG with 2.6.16-rt17
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060419124652.42147536@mango.fruits>
References: <20060419124652.42147536@mango.fruits>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 13:48:04 -0400
Message-Id: <1145468884.17085.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 12:46 +0200, Florian Schmidt wrote:
> Hi,
> 
> i found the time to build and boot into 2.6.16-rt17 and i got a BUG:
> 
> softirq-hrtmono/9[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.
> c:162
>  [<b0103ec5>] show_trace+0x25/0x30 (20)
>  [<b0103ef3>] dump_stack+0x23/0x30 (20)
>  [<b011840b>] __WARN_ON+0x6b/0xb0 (40)
>  [<b013ca39>] check_monotonic_clock+0x119/0x130 (52)
>  [<b013ddca>] __get_monotonic_clock+0xaa/0xc0 (60)
>  [<b013dfe1>] get_monotonic_clock+0x21/0x50 (32)
>  [<b011bca8>] it_real_fn+0x58/0xa0 (48)
>  [<b0130f34>] run_hrtimer_softirq+0xc4/0x270 (60)
>  [<b011de74>] ksoftirqd+0x104/0x1c0 (48)
>  [<b012d4cc>] kthread+0xdc/0xe0 (48)
>  [<b0100e55>] kernel_thread_helper+0x5/0x10 (268615708)
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<b01183c0>] .... __WARN_ON+0x20/0xb0
> .....[<b013ca39>] ..   ( <= check_monotonic_clock+0x119/0x130)
> 
> ------------------------------
> | showing all locks held by: |  (softirq-hrtmono/9 [effd07c0,  98]):
> ------------------------------
> 

Ingo,

I've been running with John Stultz's patch for a bit (the one with
cycle_wrap_bucket), and it seems to solve the problems I've had with
monotonic_clock going backwards.  Maybe it's time to pull that into -rt.

-- Steve


