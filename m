Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVCPK0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVCPK0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVCPK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:26:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59030 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262334AbVCPK0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:26:34 -0500
Date: Wed, 16 Mar 2005 11:26:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-ID: <20050316102603.GA17847@elte.hu>
References: <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org> <20050316101209.GA16893@elte.hu> <Pine.LNX.4.58.0503160520250.11824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503160520250.11824@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > ooh, I'd rather not.  I spent an intense three days removing all the
> > > sleeping locks from ext3 (and three months debugging the result).
> > > Ended up gaining 1000% on 16-way.
> > >
> > > Putting them back in will really hurt the SMP performance.
> >
> > ah. Yeah. Sniff.
> >
> > if we gain 1000% on a 16-way then there's something really wrong about
> > semaphores (or scheduling) though. A semaphore is almost a spinlock, in
> > the uncontended case - and even under contention we really (should) just
> > spend the cycles that we'd spend spinning. There will be some
> > intermediate contention level where semaphores hurt, but 1000% sounds
> > truly excessive.
> >
> 
> Could it possibly be that in the process of removing all the sleeping
> locks from ext3, that Andrew also removed a flaw in ext3 itself that
> is responsible for the 1000% improvement?

i think the chances for that are really remote. I think it must have
been a workload ending up scheduling itself to death, while spinlocks
force atomicity of execution and affinity.

we should be able to see the same scenario with PREEMPT_RT on a 16-way
:-)

	Ingo
