Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSAJGBu>; Thu, 10 Jan 2002 01:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSAJGBm>; Thu, 10 Jan 2002 01:01:42 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:25862 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289348AbSAJGB0>; Thu, 10 Jan 2002 01:01:26 -0500
Date: Wed, 9 Jan 2002 22:06:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor sched-E1 tweaks and questions 
In-Reply-To: <E16OWCo-0000YO-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0201092203370.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Rusty Russell wrote:

> Another question:
>
> 	if (likely(prev != next)) {
> 		rq->nr_switches++;
> 		rq->curr = next;
> 		next->cpu = prev->cpu;
> 		context_switch(prev, next);
> 		/*
> 		 * The runqueue pointer might be from another CPU
> 		 * if the new task was last running on a different
> 		 * CPU - thus re-load it.
> 		 */
> 		barrier();
> 		rq = this_rq();
> 	}
> 	spin_unlock_irq(&rq->lock);
>
> I do not understand this comment.  How can rq (ie. smp_processor_id())
> change?  Nothing sleeps here, and if it DID change, the
> spin_unlock_irq() would be wrong...

If you switch you'll on the stack the rq of the previous cpu
spin_unlock_irq(&rq->lock) is fine if you do not switch and if you switch
you need to reload rq





- Davide


