Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVBXRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVBXRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVBXRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:53:53 -0500
Received: from calma.pair.com ([209.68.1.95]:21514 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S262435AbVBXRxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:53:31 -0500
Date: Thu, 24 Feb 2005 12:53:31 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Mike Galbraith <EFAULT@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224175331.GA18723@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30111.1109237503@www1.gmx.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmmm... Are you suggesting it is OK for a kernel to get nearly completely
> > hosed and for not fully utilize all the processors in the system because
> > of one SCHED_FIFO thread?
> 
> Sure.  You specifically directed the scheduler to run your thread at a
> higher priority than anything else.  The way I see it, you used root's
> perogative to shoot himself in the foot.  You could also have used root's
> perogative to don steel toed shoes(set important kernel threads to a higher
> priority) before pulling the trigger.

No, I specifically directed the scheduler to run my thread at a higher 
priority than any other userspace application.  The fact that I wrote it 
in userspace and not in kernel space implies that I am OK with the kernel
stopping me sometimes when _it_ has work to do.  If I wanted something
higher priority than the kernel I would have written something in kernel
space instead.

>   SCHED_FIFO thread are supposed to preempt
> > all other userspace threads... not the kernel itself.
> 
> Not so.  The scheduler makes do distinction between user and kernel threads
> of execution.

That is SOOOO broken it isn't even funny.

> If you think that's broken, you'll _love_ Ingo's IRQ threads.  While testing
> one of his recent (slightly buggy)unpriveleged-user-does-RT patches in an
> IRQ threadified kernel, I ran a user SCHED_FIFO task at higher than the IRQ0
> thread... if my box had been an embeded washing machine controller instead
> of a desktop box, it'd have been a classic case of "No tickie no washie" :))

Yeah, thats broken too.

Perhaps I don't understand this philosophy you have where the kernel
isn't more important than everything else.  It seems to me like there needs
to be a rigid hierarchy for scheduling, lest you get into deadlock problems:

1.  Kernel preempts all.  There may be some hierarchy of kernel priorities
too, but it isn't important here.
2.  SCHED_FIFO processes preempt all userspace applications.
3.  SCHED_RR.
4.  SCHED_OTHER.

Under no circumstances should any single CPU-bound userspace thread completely 
hose a 64-way SMP box.

Can somebody educate me on why it is correct to do it any other way?

Chad
