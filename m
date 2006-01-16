Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWAPIgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWAPIgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAPIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:36:11 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:31155 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932229AbWAPIgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:36:10 -0500
Date: Mon, 16 Jan 2006 09:35:42 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <20060115042449.GA9871@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44L0.0601160926360.4219-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Bill Huey wrote:

> On Wed, Jan 11, 2006 at 06:25:36PM +0100, Esben Nielsen wrote:
> > So how many locks do we have to worry about? Two.
> > One for locking the lock. One for locking various PI related data on the
> > task structure, as the pi_waiters list, blocked_on, pending_owner - and
> > also prio.
> > Therefore only lock->wait_lock and sometask->pi_lock will be locked at the
> > same time. And in that order. There is therefore no spinlock deadlocks.
> > And the code is simpler.
>
> Ok, got a question. How do deal with the false reporting and handling of
> a lock circularity window involving the handoff of task A's BKL to another
> task B ? Task A is blocked trying to get a mutex owned by task B, task A
> is block B since it owns BKL which task B is contending on. It's not a
> deadlock since it's a hand off situation.
>
I am not precisely sure what you mean by "false reporting".

Handing off BKL is done in schedule() in sched.c. I.e. if B owns a normal
mutex, A will give BKL to B when A calls schedule() in the down-operation
of that mutex.

> I didn't see any handling of this case in the code and I was wondering
> if the traversal logic you wrote avoids this case as an inherent property
> and I missed that stuff ?

The stuff is in kernel/sched.c and lib/kernel_lock.c.


>
> bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

