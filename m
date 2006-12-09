Return-Path: <linux-kernel-owner+w=401wt.eu-S936471AbWLITrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936471AbWLITrr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936476AbWLITrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:47:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44054 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936471AbWLITrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:47:46 -0500
Date: Sat, 9 Dec 2006 11:47:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: vatsa@in.ibm.com, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-Id: <20061209114723.138b6e89.akpm@osdl.org>
In-Reply-To: <20061209102652.GA16607@elte.hu>
References: <200612061726.14587.bjorn.helgaas@hp.com>
	<20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
	<20061207205407.b4e356aa.akpm@osdl.org>
	<20061209102652.GA16607@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 11:26:52 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > > +		if (cpu != -1)
> > > > +			mutex_lock(&workqueue_mutex);
> > > 
> > > events/4 thread itself wanting the same mutex above?
> > 
> > Could do, not sure.  I'm planning on converting all the locking around 
> > here to preempt_disable() though.
> 
> please at least use an owner-recursive per-CPU lock,

a wot?

> not a naked 
> preempt_disable()! The concurrency rules for data structures changed via 
> preempt_disable() are quite hard to sort out after the fact. 
> (preempt_disable() is too opaque,

preempt_disable() is the preferred way of holding off cpu hotplug.

> it doesnt attach data structure to 
> critical section, like normal locks do.)

the data structure is the CPU, and its per-cpu data.  And cpu_online_map.
