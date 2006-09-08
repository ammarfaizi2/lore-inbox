Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWIHSlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWIHSlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWIHSlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:41:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35462 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750793AbWIHSlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:41:04 -0400
Date: Fri, 8 Sep 2006 11:40:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060908103529.A9121@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060908103529.A9121@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Siddha, Suresh B wrote:

> > +#endif
> > +}
> 
> Is there a reason why this is not made inline?

Just did not think of it.

> > +			struct rq *rq;
> > +
> > +			if (!cpu_isset(i, *cpus))
> > +				continue;
> 
> In normal conditions can we make this "cpus" argument NULL and only set/use it
> when we run into pinned condition? That will atleast avoid unnecessary memory
> test bit operations in the normal case.

The balancing operation is not that frequent and having to treat a special 
case in the callers would make code more complicated and likely offset the
gains in this function.

Fix up the declaration of cpu_of()

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/kernel/sched.c	2006-09-08 11:38:35.852594785 -0700
+++ linux-2.6.18-rc5-mm1/kernel/sched.c	2006-09-08 11:39:29.182308471 -0700
@@ -269,7 +269,7 @@ struct rq {
 
 static DEFINE_PER_CPU(struct rq, runqueues);
 
-int cpu_of(struct rq *rq)
+static inline int cpu_of(struct rq *rq)
 {
 #ifdef CONFIG_SMP
 	return rq->cpu;

