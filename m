Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWILPHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWILPHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWILPHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:07:14 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:45269 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1030199AbWILPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:07:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: paulmck@us.ibm.com
Subject: Re: Uses for memory barriers
Date: Tue, 12 Sep 2006 17:07:31 +0200
User-Agent: KMail/1.8
Cc: David Howells <dhowells@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <20060911162059.GA1496@us.ibm.com> <200609121222.01260.oliver@neukum.org> <20060912145509.GE1291@us.ibm.com>
In-Reply-To: <20060912145509.GE1291@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121707.32078.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. September 2006 16:55 schrieb Paul E. McKenney:
> On Tue, Sep 12, 2006 at 12:22:00PM +0200, Oliver Neukum wrote:
> > Am Dienstag, 12. September 2006 11:01 schrieb David Howells:
> > > Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > 
> > > > 2.	All stores to a given single memory location will be perceived
> > > > 	as having occurred in the same order by all CPUs.
> > > 
> > > Does that take into account a CPU combining or discarding coincident memory
> > > operations?
> > > 
> > > For instance, a CPU asked to issue two writes to the same location may discard
> > > the first if it hasn't done it yet.
> > 
> > Does it make sense? If you do:
> > mov #x, $a
> > wmb
> > mov #y, $b
> > wmb
> > mov #z, $a
> > 
> > The CPU must not discard any write. If you do
> > 
> > mov #x, $a
> > mov #y, $b
> > wmb
> > mov #z, $a
> > 
> > The first store to $a is superfluous if you have only inter-CPU
> > issues in mind.
> 
> In both cases, the CPU might "discard" the write, if there are no intervening
> reads or writes to the same location.  The only difference between your

How can it know that?

> two examples is the ordering of the first store to $a and the store to $b.
> In your first example, other CPUs must see the first store to $a as happening
> first, while in your second example, other CPUs might see the store to $b
> as happening first.

There's no way in the second case a CPU might tell whether the first
write ever happened.

	Regards
		Oliver
