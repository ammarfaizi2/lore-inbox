Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTBQOkh>; Mon, 17 Feb 2003 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTBQOhC>; Mon, 17 Feb 2003 09:37:02 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16103 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267199AbTBQOIm>;
	Mon, 17 Feb 2003 09:08:42 -0500
Date: Mon, 17 Feb 2003 15:17:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] set_cpus_allowed needs cpu_online_map BUG check
In-Reply-To: <Pine.LNX.4.50.0302170250430.18087-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302171516400.24394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:

> We don't want to try and migrate to offline cpus, so BUG() on it.

agreed. Not much code should be exposed to the possibility of CPUs going
away.

	Ingo

> diff -u -r1.1.1.1 sched.c
> --- linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
> +++ linux-2.5.61-trojan/kernel/sched.c	15 Feb 2003 16:04:51 -0000
> @@ -2200,11 +2221,8 @@
>  	migration_req_t req;
>  	runqueue_t *rq;
>  
> -#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
> -	new_mask &= cpu_online_map;
> -	if (!new_mask)
> +	if (!(new_mask & cpu_online_map))
>  		BUG();
> -#endif
>  
>  	rq = task_rq_lock(p, &flags);
>  	p->cpus_allowed = new_mask;
> 

