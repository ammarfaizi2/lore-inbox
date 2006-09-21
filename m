Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWIUBnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWIUBnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWIUBnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:43:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39318 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750959AbWIUBnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:43:04 -0400
Date: Wed, 20 Sep 2006 18:43:55 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060921014355.GI1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060919200116.GJ1310@us.ibm.com> <Pine.LNX.4.44L0.0609191634480.4631-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609191634480.4631-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 04:38:19PM -0400, Alan Stern wrote:
> On Tue, 19 Sep 2006, Paul E. McKenney wrote:
> 
> > > Maybe I'm missing something. But if the same CPU loads the value
> > > before the store becomes visible to cache coherency, it might see
> > > the value out of any order any of the other CPUs sees.
> > 
> > Agreed.  But the CPUs would have to refer to a fine-grained synchronized
> > timebase or to some other variable in order to detect the fact that there
> > were in fact multiple different values for the same variable at the same
> > time (held in the different store queues).
> 
> Even that wouldn't be illegal.  No one ever said that any particular write 
> becomes visible to all CPUs at the same time.

Agreed.  But this would be outside of the cache-coherence protocol.

That said, cross-CPU timing measurements have been very helpful to
me in the past when messing with memory ordering.  Spooky to be able
to prove that a single variable really does have multiple values at
a single point in time, from the perspectives of different CPUs!  ;-)

> > If the CPUs looked only at that one single variable being stored to,
> > could they have inconsistent opinions about the order of values that
> > this single variable took on?  My belief is that they could not.
> 
> Yes, I think this must be right.  If a store is hung up in a CPU's store 
> buffer, it will mask later stores by other CPUs (i.e., prevent them from 
> becoming visible to the CPU that owns the store buffer).  Hence all stores 
> that _do_ become visible will appear in a consistent order.
> 
> But my knowledge of outlandish hardware is extremely limited, so don't 
> take my word as gospel.

All the hardware that I have had intimate knowledge of has adhered to
this constraint.

							Thanx, Paul
