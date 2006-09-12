Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWILQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWILQMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWILQMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:12:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50053 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030265AbWILQMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:12:07 -0400
Date: Tue, 12 Sep 2006 09:12:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060912161226.GG1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060911162059.GA1496@us.ibm.com> <200609121222.01260.oliver@neukum.org> <20060912145509.GE1291@us.ibm.com> <200609121707.32078.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609121707.32078.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 05:07:31PM +0200, Oliver Neukum wrote:
> Am Dienstag, 12. September 2006 16:55 schrieb Paul E. McKenney:
> > On Tue, Sep 12, 2006 at 12:22:00PM +0200, Oliver Neukum wrote:
> > > Am Dienstag, 12. September 2006 11:01 schrieb David Howells:
> > > > Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > > 
> > > > > 2.	All stores to a given single memory location will be perceived
> > > > > 	as having occurred in the same order by all CPUs.
> > > > 
> > > > Does that take into account a CPU combining or discarding coincident memory
> > > > operations?
> > > > 
> > > > For instance, a CPU asked to issue two writes to the same location may discard
> > > > the first if it hasn't done it yet.
> > > 
> > > Does it make sense? If you do:
> > > mov #x, $a
> > > wmb
> > > mov #y, $b
> > > wmb
> > > mov #z, $a
> > > 
> > > The CPU must not discard any write. If you do
> > > 
> > > mov #x, $a
> > > mov #y, $b
> > > wmb
> > > mov #z, $a
> > > 
> > > The first store to $a is superfluous if you have only inter-CPU
> > > issues in mind.
> > 
> > In both cases, the CPU might "discard" the write, if there are no intervening
> > reads or writes to the same location.  The only difference between your
> 
> How can it know that?

If the CPU starts off owning both cache lines, and if there are no intervening
invalidation requests from other CPUs, then the writing CPU knows that there
could not possibly have been any intervening writes.

> > two examples is the ordering of the first store to $a and the store to $b.
> > In your first example, other CPUs must see the first store to $a as happening
> > first, while in your second example, other CPUs might see the store to $b
> > as happening first.
> 
> There's no way in the second case a CPU might tell whether the first
> write ever happened.

With one important exception -- the CPU that did the write knows.
There is no requirement that each and every CPU see each and every write.
The only requirement is that the sequence of values that each CPU sees
for a single given variable is consistent with that of each other CPU.

							Thanx, Paul
