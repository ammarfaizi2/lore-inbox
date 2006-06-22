Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWFVTqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWFVTqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWFVTqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:46:15 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:210 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161231AbWFVTqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:46:14 -0400
Date: Thu, 22 Jun 2006 22:46:12 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <Pine.LNX.4.64.0606221241240.31332@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222245150.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222231390.5385@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0606221241240.31332@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:
> > > @@ -298,6 +299,7 @@ struct kmem_list3 {
> > >  	struct array_cache **alien;	/* on other nodes */
> > >  	unsigned long next_reap;	/* updated without locking */
> > >  	int free_touched;		/* updated without locking */
> > > +	atomic_t reclaim;			/* Reclaim in progress */
> > >  };

On Thu, 22 Jun 2006, Christoph Lameter wrote:
> Yes we do not need those if SLAB_RECLAIM is not set.
> 
> We only take the list lock for getting at slab addresses. We want slab 
> operations to continue wile reclaim is in progress.
> 
> The marker does not cost anything on ia64 due to structure alignment. We 
> need to have some way (in the absense of taking the list lock) to know 
> when we have reclaimed all slabs.

Not everyone is IA-64.  The slab allocator is already pretty memory 
hungry so lets try not to make it any worse, ok?

					Pekka
