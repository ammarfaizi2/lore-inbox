Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWISRkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWISRkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWISRkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:40:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10248 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030386AbWISRkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:40:15 -0400
Date: Tue, 19 Sep 2006 13:40:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <45101CF3.5070207@yahoo.com.au>
Message-ID: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Nick Piggin wrote:

> >>(P1):	If each CPU performs a series of stores to a single shared variable,
> >>	then the series of values obtained by the a given CPUs stores and
> >>	loads must be consistent with that obtained by each of the other
> >>	CPUs.  It may or may not be possible to deduce a single global
> >>	order from the full set of such series.
> > 
> > 
> > Suppose three CPUs respectively write the values 1, 2, and 3 to a single 
> > variable.  Are you saying that some CPU A might see the values 1,2 (in 
> > that order), CPU B might see 2,3 (in that order), and CPU C might see 3,1 
> > (in that order)?  Each CPU's view would be consistent with each of the 
> > others but there would not be any global order.
> > 
> > Somehow I don't think that's what you intended.  In general the actual
> > situation is much messier, with some writes masking others for some CPUs 
> > in such a way that whenever two CPUs both see the same two writes, they 
> > see them in the same order.  Is that all you meant to say?
> 
> I don't think that need be the case if one of the CPUs that has written
> the variable forwards the store to a subsequent load before it reaches
> the cache coherency (I could be wrong here). So if that is the case, then
> your above example would be correct.

I don't understand your comment.  Are you saying it's possible for two 
CPUs to observe the same two writes and see them occurring in opposite 
orders?

> But if I'm wrong there, I think Paul's statement holds even if all
> stores to a single cacheline are always instantly coherent (and thus do
> have some global ordering). Consider a variation on your example where
> one CPU loads 1,2 and another loads 1,3. What's the order?

Again I don't follow.  If one CPU sees 1,2 and another sees 1,3 then there
are two possible global orderings: 1,2,3 and 1,3,2.  Both are consistent
with what each CPU sees.  If a third CPU sees 2,3 then the only consistent 
ordering is 1,2,3.

But in the example I gave there are no global orderings consistent with
all the observations.  Nevertheless, my example is isn't ruled out by what
Paul wrote.  So could my example arise on a real system?

Alan

