Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288627AbSADNrb>; Fri, 4 Jan 2002 08:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288628AbSADNrW>; Fri, 4 Jan 2002 08:47:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16009 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288634AbSADNrJ>;
	Fri, 4 Jan 2002 08:47:09 -0500
Date: Fri, 4 Jan 2002 16:44:32 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Lang <david.lang@digitalinsight.com>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <20020104143659.I1561@athlon.random>
Message-ID: <Pine.LNX.4.33.0201041641320.7409-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Andrea Arcangeli wrote:

> +	{
> +		int counter = current->counter;
> +		p->counter = (counter + 1) >> 1;
> +		current->counter = counter >> 1;
> +		p->policy &= ~SCHED_YIELD;
> +		current->policy |= SCHED_YIELD;
>  		current->need_resched = 1;
> +	}

yep - good, this means that applications got some fair testing already.

What i mentioned in the previous email is that on SMP this solution is
still not the optimal one under the current scheduler, because the wakeup
of the child process might end up pushing the process to another (idle)
CPU - worsening the COW effect with SMP-interlocking effects. This is why
i introduced wake_up_forked_process() that knows about this distinction
and keeps the child on the current CPU.

	Ingo

