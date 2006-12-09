Return-Path: <linux-kernel-owner+w=401wt.eu-S936802AbWLIK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936802AbWLIK2s (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936803AbWLIK2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:28:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36950 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936798AbWLIK2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:28:47 -0500
Date: Sat, 9 Dec 2006 11:26:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061209102652.GA16607@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207205407.b4e356aa.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > +		if (cpu != -1)
> > > +			mutex_lock(&workqueue_mutex);
> > 
> > events/4 thread itself wanting the same mutex above?
> 
> Could do, not sure.  I'm planning on converting all the locking around 
> here to preempt_disable() though.

please at least use an owner-recursive per-CPU lock, not a naked 
preempt_disable()! The concurrency rules for data structures changed via 
preempt_disable() are quite hard to sort out after the fact. 
(preempt_disable() is too opaque, it doesnt attach data structure to 
critical section, like normal locks do.)

	Ingo
