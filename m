Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWGGVqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWGGVqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWGGVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:46:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58295 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751257AbWGGVqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:46:52 -0400
Date: Fri, 7 Jul 2006 14:47:25 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, Ingo Molnar <mingo@elte.hu>, tytso@us.ibm.com,
       Darren Hart <dvhltc@us.ibm.com>, oleg@tv-sign.ru,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060707214725.GG1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0607071523330.6793-100000@iolanthe.rowland.org> <1152306686.21787.2163.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152306686.21787.2163.camel@stark>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 02:11:26PM -0700, Matt Helsley wrote:
> On Fri, 2006-07-07 at 15:59 -0400, Alan Stern wrote:
> > On Fri, 7 Jul 2006, Paul E. McKenney wrote:
> 
> <snip>
> 
> > > So, a fourth possibility -- can a call from start_kernel() invoke some
> > > function in yours and Matt's code invoke init_srcu_struct() to get a
> > > statically allocated srcu_struct initialized?  Or, if this is part of
> > > a module, can the module initialization function do this work?
> > > 
> > > (Hey, I had to ask!)
> > 
> > That is certainly a viable approach: just force everyone to use dynamic 
> > initialization.  Changes to existing code would be relatively few.
> 
> 	Works for me. I've been working on patches for Andrew's multi-chain
> proposal and I could use an init function there anyway. Should be faster
> too -- dynamically-allocated per-cpu memory can take advantage of
> node-local memory whereas, to my knowledge, statically-allocated cannot.

Sounds very good to me!  ;-)

> > I'm not sure where the right place would be to add these initialization 
> > calls.  After kmalloc is working but before the relevant notifier chains 
> > get used at all.  Is there such a place?  I guess it depends on which 
> > notifier chains we convert.
> > 
> > We might want to leave some chains using the existing rw-semaphore API.  
> > It's more appropriate when there's a high frequency of write-locking
> > (i.e., things registering or unregistering on the notifier chain).  The 
> > SRCU approach is more appropriate when the chain is called a lot and 
> > needs to have low overhead, but (un)registration is uncommon.  Matt's task 
> > notifiers are a good example.
> 
> Yes, it is an excellent example.

Good!!!  Please let me know how it goes.  I will shelve the idea of
statically allocated per-CPU data for srcu_struct for the moment.
If some other application shows up that needs it, I will revisit.

						Thanx, Paul
