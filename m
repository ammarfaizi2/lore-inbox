Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTATJPW>; Mon, 20 Jan 2003 04:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTATJPW>; Mon, 20 Jan 2003 04:15:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63723 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262038AbTATJPV>;
	Mon, 20 Jan 2003 04:15:21 -0500
Date: Mon, 20 Jan 2003 10:28:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <200301190009.32245.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0301201022540.2585-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Jan 2003, Erich Focht wrote:

> The results:
> - kernbench UserTime is best for the 2.5.59 scheduler (623s). IngoB0
>   best value 627.33s for idle=20ms, busy=2000ms.
> - hackbench: 2.5.59 scheduler is significantly better for all
>   measurements.
> 
> I suppose this comes from the fact that the 2.5.59 version has the
> chance to load_balance across nodes when a cpu goes idle. No idea what
> other reason it could be... Maybe anybody else?

this shows that agressive idle-rebalancing is the most important factor. I
think this means that the unification of the balancing code should go into
the other direction: ie. applying the ->nr_balanced logic to the SMP
balancer as well.

kernelbench is the kind of benchmark that is most sensitive to over-eager
global balancing, and since the 2.5.59 ->nr_balanced logic produced the
best results, it clearly shows it's not over-eager. hackbench is one that
is quite sensitive to under-balancing. Ie. trying to maximize both will
lead us to a good balance.

	Ingo

