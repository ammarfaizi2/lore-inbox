Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUCUHaa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 02:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbUCUHaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 02:30:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22656 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263616AbUCUHa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 02:30:28 -0500
Date: Sun, 21 Mar 2004 08:31:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
Message-ID: <20040321073119.GA4165@elte.hu>
References: <40525C1F.5030705@cyberone.com.au> <20040319095047.GA6301@elte.hu> <405AC456.1070806@cyberone.com.au> <405D1433.4000904@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405D1433.4000904@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


your patch looks interesting. 

wrt. making a fully scalable MM read side:

perphaps RCU could be used to make lookup access to the vma tree and
lookup of the pagetables lockless. This would make futexes (and
pagefaults) fundamentally scalable.

another option would be to introduce a rwsem which is read-scalable, but
this would pessimise writes quite as bad as brlocks did. I'm not sure
how acceptable that is.

	Ingo

* Nick Piggin <piggin@cyberone.com.au> wrote:

> 
> 
> Nick Piggin wrote:
> 
> >
> >That would be interesting, yes. I have (somewhere) a patch
> >that wakes up the semaphore's waiters outside its spinlock.
> >I think that only gave about 5% or so improvement though.
> >
> >
> 
> Here is a cleaned up patch for comments. It is untested at the
> moment because I don't have access to the 16-way NUMAQ now. It
> moves waking of the waiters outside the spinlock.
> 
> I think it gave about 5-10% improvement when the rwsem gets
> really contended. Not as much as I had hoped, but every bit
> helps.
> 
> The rwsem-spinlock.c code could use the same optimisation too.
> 


