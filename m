Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286584AbSAFAta>; Sat, 5 Jan 2002 19:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSAFAtU>; Sat, 5 Jan 2002 19:49:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57864 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286584AbSAFAtM>; Sat, 5 Jan 2002 19:49:12 -0500
Date: Sat, 5 Jan 2002 16:47:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201051242080.1607-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201051643050.24370-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Davide Libenzi wrote:
>
> No Ingo the fact that you coded the patch this time does not really change
> the workloads, once you've a per-cpu run queue and lock. The thing that
> makes big servers to suffer in the common queue plus the cache coherency
> traffic due the common lock.

What do the per-CPU queue patches look like? I agree with Davide that it
seems much more sensible from a scalability standpoint to allow O(n)  (or
whatever) but with local queues. That should also very naturally give CPU
affinity ;)

The problem with local queues is how to sanely break the CPU affinity
when it needs breaking. Which is not necessarily all that often, but
clearly does need to happen.

It would be nice to have the notion of a cluster scheduler with a clear
"transfer to another CPU" operation, and actively trying to minimize the
number of transfers.

What are those algorithms like? This are must have tons of scientific
papers.

		Linus

