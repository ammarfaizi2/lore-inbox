Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWIKTCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWIKTCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWIKTCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:02:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:51412 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964952AbWIKTCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:02:51 -0400
Date: Mon, 11 Sep 2006 12:03:35 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060911190335.GB1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060911162059.GA1496@us.ibm.com> <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609111246110.10623-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 12:50:07PM -0400, Alan Stern wrote:
> On Mon, 11 Sep 2006, Paul E. McKenney wrote:
> 
> > This is a summary of the Linux memory-barrier semantics as I understand
> > them:
> > 
> > 1.	A given CPU will always perceive its own memory operations
> > 	as occuring in program order.
> > 
> > 2.	All stores to a given single memory location will be perceived
> > 	as having occurred in the same order by all CPUs.  This is
> > 	"coherence".  (And this is the property that I was forgetting
> > 	about when I first looked at your second example.)
> ...
> 
> This can't be right.  Together 1 and 2 would obviate the need for wmb().  
> The CPU doing "STORE A; STORE B" will always see the operations occuring
> in program order by 1, and hence every other CPU would always see them
> occurring in the same order by 2 -- even without wmb().

Not so.  A and B are different memory locations, hence #2 does not
apply to the "STORE A; STORE B" sequence.

> Either 2 is too strong, or else what you mean by "perceived" isn't 
> sufficiently clear.

The key phrase is "to a given -single- memory location".  ;-)

A and B are presumably -different- memory locations.  However, if A and
B are aliases for the same memory location, then the wmb() would in fact
be unnecessary.  But, again, I am assuming that they are different, so
that #2 does not apply.

						Thanx, Paul
