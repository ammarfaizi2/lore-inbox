Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSFKA1i>; Mon, 10 Jun 2002 20:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSFKA1h>; Mon, 10 Jun 2002 20:27:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24563 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316580AbSFKA1g>; Mon, 10 Jun 2002 20:27:36 -0400
Subject: Re: [patch] current scheduler bits, 2.5.21
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206110134130.5377-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 10 Jun 2002 17:27:35 -0700
Message-Id: <1023755255.21155.166.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-10 at 17:05, Ingo Molnar wrote:

> Thanks. I've applied your patch with the following additional
> improvements:
> 
> - The spin_unlock_irqrestore path does not have to be split up like the
>   spin_lock path: spin_unlock() + local_irq_restore() ==
>   spin_unlock_irqrestore() ... this is true both in task_rq_unlock() and
>   rq_unlock() code.

I know.  The reason I split them up is to maintain consistency through
the way we lock vs unlock and enable vs disable interrupts.  Partly for
style, partly in case we ever decide to hook the different calls in a
different manner.

I do not see this in your patch, though ...

> - in sys_sched_yield() you removed an optimization: the final spin_unlock
>   does not have to check for resched explicitly, we'll call into
>   schedule() anyway. I've introduced a new spin_unlock variant:
>   spin_unlock_no_resched(), which uses preempt_enable_no_resched().

Ah yes, very good.  I was too busy noticing the optimization I _did_ put
in: not calling rq_unlock here as we can just leave interrupts disabled
on return...

Very good.

> otherwise it's looking good. The attached patch is my current tree which
> includes the rq-lock/unlock optimization plus the previous patches
> (race-fix and sync-wakeup), against 2.5.21-vanilla.

Excellent.

	Robert Love

