Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSHSLkE>; Mon, 19 Aug 2002 07:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318317AbSHSLkD>; Mon, 19 Aug 2002 07:40:03 -0400
Received: from f126234.ap.plala.or.jp ([202.212.126.234]:55424 "HELO
	mana.fennel.org") by vger.kernel.org with SMTP id <S318308AbSHSLkD>;
	Mon, 19 Aug 2002 07:40:03 -0400
Date: Mon, 19 Aug 2002 20:43:42 +0900 (JST)
Message-Id: <20020819.204342.100705424.sian@big.or.jp>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bug in yield()
From: Hiroshi Takekawa <sian@big.or.jp>
In-Reply-To: <15712.20532.996267.734044@argo.ozlabs.ibm.com>
References: <15712.20532.996267.734044@argo.ozlabs.ibm.com>
X-Mailer: Mew version 3.0.61 on Emacs 21.3 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIvU0FLQUtJKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

> This patch makes yield() actually call schedule.

The trouble hanging after "Initializing RT netlink socket" which
several report, just gone.  And seems to work fine.

But I wonder whether doing schedule() here is good or not.  In 2.5,
schedule() is done in sys_sched_yield().  I don't know much about
kernel things.  So I just compared...

--
Hiroshi Takekawa <sian@big.or.jp>


> Without this patch, 2.4.20-pre3 will hang on boot for me, looping in
> spawn_ksoftirqd waiting for ksoftirqd to start and calling yield().
> ksoftirqd never gets to run, however, because yield never actually
> calls schedule.  (Note that sys_sched_yield as a syscall is OK because
> the syscall exit path will check current->need_resched and call
> schedule).

> Paul.

> diff -urN linux-2.4/kernel/sched.c pmac/kernel/sched.c
> --- linux-2.4/kernel/sched.c	Wed Aug  7 18:10:01 2002
> +++ pmac/kernel/sched.c	Mon Aug 19 10:39:39 2002
> @@ -1081,6 +1081,7 @@
>  {
>  	set_current_state(TASK_RUNNING);
>  	sys_sched_yield();
> +	schedule();
>  }
 
>  void __cond_resched(void)
