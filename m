Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWILOyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWILOyv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWILOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:54:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44737 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030225AbWILOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:54:50 -0400
Date: Tue, 12 Sep 2006 07:55:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060912145509.GE1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060911162059.GA1496@us.ibm.com> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <32145.1158051703@warthog.cambridge.redhat.com> <200609121222.01260.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609121222.01260.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:22:00PM +0200, Oliver Neukum wrote:
> Am Dienstag, 12. September 2006 11:01 schrieb David Howells:
> > Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > 
> > > 2.	All stores to a given single memory location will be perceived
> > > 	as having occurred in the same order by all CPUs.
> > 
> > Does that take into account a CPU combining or discarding coincident memory
> > operations?
> > 
> > For instance, a CPU asked to issue two writes to the same location may discard
> > the first if it hasn't done it yet.
> 
> Does it make sense? If you do:
> mov #x, $a
> wmb
> mov #y, $b
> wmb
> mov #z, $a
> 
> The CPU must not discard any write. If you do
> 
> mov #x, $a
> mov #y, $b
> wmb
> mov #z, $a
> 
> The first store to $a is superfluous if you have only inter-CPU
> issues in mind.

In both cases, the CPU might "discard" the write, if there are no intervening
reads or writes to the same location.  The only difference between your
two examples is the ordering of the first store to $a and the store to $b.
In your first example, other CPUs must see the first store to $a as happening
first, while in your second example, other CPUs might see the store to $b
as happening first.

							Thanx, Paul
