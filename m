Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934363AbWKUHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbWKUHjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934364AbWKUHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:39:53 -0500
Received: from brick.kernel.dk ([62.242.22.158]:36384 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S934363AbWKUHjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:39:52 -0500
Date: Tue, 21 Nov 2006 08:39:39 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121073938.GI8055@kernel.dk>
References: <20061120201334.GE8055@kernel.dk> <Pine.LNX.4.44L0.0611201629040.7916-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201629040.7916-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2006, Alan Stern wrote:
> On Mon, 20 Nov 2006, Jens Axboe wrote:
> 
> > > > Must we introduce memory allocations in srcu_read_lock()? It makes it
> > > > much harder and nastier for me to use. I'd much prefer a failing
> > > > init_srcu(), seems like a much better API.
> > > 
> > > Paul agrees with you that allocation failures in init_srcu() should be 
> > > passed back to the caller, and I certainly don't mind doing so.
> > > 
> > > However we can't remove the memory allocation in srcu_read_lock().  That
> > > was the point which started this whole thread: the per-cpu allocation
> > > cannot be done statically, and some users of a static SRCU structure can't
> > > easily call init_srcu() early enough.
> > > 
> > > Once the allocation succeeds, the overhead in srcu_read_lock() is minimal.
> > 
> > It's not about the overhead, it's about a potentially problematic
> > allocation.
> 
> I'm not sure what you mean by "problematic allocation".  If you
> successfully call init_srcu_struct then the allocation will be taken care
> of.  Later calls to srcu_read_lock won't experience any slowdowns or
> problems.

That requires init_srcu_struct() to return the error. If it does that,
I'm fine with it.

> Does this answer your objection?  If not, can you explain in more detail 
> what other features you would like?

It does, if the allocation failure in init_srcu_struct() is signalled.

-- 
Jens Axboe

