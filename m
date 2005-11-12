Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVKLVBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVKLVBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVKLVBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:01:05 -0500
Received: from mx1.rowland.org ([192.131.102.7]:5895 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S964807AbVKLVBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:01:04 -0500
Date: Sat, 12 Nov 2005 16:01:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain
 mechanism
In-Reply-To: <20051112192809.GA5296@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0511121559260.6130-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2005, Paul E. McKenney wrote:

> > > > > The above can simply be "n->next = *nl;".  The reason is that this change
> > > > > of state is not visible to RCU readers until after the following statement,
> > > > > and it therefore need not be an RCU-reader-safe assignment.  You only need
> > > > > to use rcu_assign_pointer() when the results of the assignment are
> > > > > immediately visible to RCU readers.
> > > > 
> > > > Correct, the rcu call isn't really needed.  It doesn't hurt perceptibly,
> > > > though, and part of the RCU documentation states:
> > > > 
> > > >  * ...  More importantly, this
> > > >  * call documents which pointers will be dereferenced by RCU read-side
> > > >  * code.
> > > > 
> > > > For that reason, I felt it was worth putting it in.
> > > 
> > > But the following statement does a much better job of documenting the
> > > pointer that is to be RCU-dereferenced.  Duplicate documentation can
> > > be just as confusing as no documentation.
> > 
> > It's not really duplicate documentation since _both_ pointers are to be 
> > RCU-dereferenced.  But maybe you mean that only the second pointer can be 
> > RCU-dereferenced at the time the write occurs?  I don't think that's what 
> > the documentation comment intended.
> 
> I am the guy who wrote that documentation ocmment.  ;-)

In that case I bow to your advice.  :-)

Alan Stern

