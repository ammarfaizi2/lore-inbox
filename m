Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWGGVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWGGVQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGGVQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:16:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:63944 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932286AbWGGVQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:16:39 -0400
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
From: Matt Helsley <matthltc@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0607071523330.6793-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0607071523330.6793-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 14:11:26 -0700
Message-Id: <1152306686.21787.2163.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 15:59 -0400, Alan Stern wrote:
> On Fri, 7 Jul 2006, Paul E. McKenney wrote:

<snip>

> > So, a fourth possibility -- can a call from start_kernel() invoke some
> > function in yours and Matt's code invoke init_srcu_struct() to get a
> > statically allocated srcu_struct initialized?  Or, if this is part of
> > a module, can the module initialization function do this work?
> > 
> > (Hey, I had to ask!)
> 
> That is certainly a viable approach: just force everyone to use dynamic 
> initialization.  Changes to existing code would be relatively few.

	Works for me. I've been working on patches for Andrew's multi-chain
proposal and I could use an init function there anyway. Should be faster
too -- dynamically-allocated per-cpu memory can take advantage of
node-local memory whereas, to my knowledge, statically-allocated cannot.

> I'm not sure where the right place would be to add these initialization 
> calls.  After kmalloc is working but before the relevant notifier chains 
> get used at all.  Is there such a place?  I guess it depends on which 
> notifier chains we convert.
> 
> We might want to leave some chains using the existing rw-semaphore API.  
> It's more appropriate when there's a high frequency of write-locking
> (i.e., things registering or unregistering on the notifier chain).  The 
> SRCU approach is more appropriate when the chain is called a lot and 
> needs to have low overhead, but (un)registration is uncommon.  Matt's task 
> notifiers are a good example.

Yes, it is an excellent example.

> Alan Stern

Cheers,
	-Matt Helsley

