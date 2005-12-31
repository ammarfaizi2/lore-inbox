Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLaEAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLaEAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 23:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVLaEAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 23:00:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52180 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932086AbVLaEAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 23:00:17 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
	 <20051230080032.GA26152@elte.hu> <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
	 <1135991732.31111.57.camel@mindpipe>
	 <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 23:00:15 -0500
Message-Id: <1136001615.3050.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 17:39 -0800, Linus Torvalds wrote:
> diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
> index 48d3bce..b107562 100644
> --- a/kernel/rcupdate.c
> +++ b/kernel/rcupdate.c
> @@ -149,11 +149,10 @@ void fastcall call_rcu_bh(struct rcu_hea
>         *rdp->nxttail = head;
>         rdp->nxttail = &head->next;
>         rdp->count++;
> -/*
> - *  Should we directly call rcu_do_batch() here ?
> - *  if (unlikely(rdp->count > 10000))
> - *      rcu_do_batch(rdp);
> - */
> +
> +       if (unlikely(++rdp->count > 100))
> +               set_need_resched();
> +
>         local_irq_restore(flags);
>  } 

This increments rdp->count twice - is that intentional?

Also what was the story deal with the commented out code?

Lee

