Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316679AbSFQECY>; Mon, 17 Jun 2002 00:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSFQECX>; Mon, 17 Jun 2002 00:02:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63216 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316679AbSFQECW>; Mon, 17 Jun 2002 00:02:22 -0400
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0206170525520.2941-100000@e2>
References: <Pine.LNX.4.44.0206170525520.2941-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 21:02:08 -0700
Message-Id: <1024286528.924.52.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 20:49, Ingo Molnar wrote:
smlinkage long sys_sched_yield(void)
>  {
> -	runqueue_t *rq;
> -	prio_array_t *array;
> -
> -	rq = rq_lock(rq);
> +	runqueue_t *rq = rq_lock(rq);
> +	prio_array_t *array = current->array;

Question.  I have always wondered what the C rules are here... is
rq_lock guaranteed to be evaluated before current->array?  I.e., is the
above synonymous with:

	runqueue_t *rq;
	prio_array_t *array;
	rq = rq_lock(rq);
	array = current->array;

...guaranteed?

	Robert Love

