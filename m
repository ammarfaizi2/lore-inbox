Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWILOlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWILOlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWILOlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:41:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:14814 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030229AbWILOlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:41:44 -0400
Date: Tue, 12 Sep 2006 07:42:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060912144204.GC1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060911162059.GA1496@us.ibm.com> <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <32145.1158051703@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32145.1158051703@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 10:01:43AM +0100, David Howells wrote:
> Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > 2.	All stores to a given single memory location will be perceived
> > 	as having occurred in the same order by all CPUs.
> 
> Does that take into account a CPU combining or discarding coincident memory
> operations?

I believe so.

> For instance, a CPU asked to issue two writes to the same location may discard
> the first if it hasn't done it yet.

If I understand your example correctly, in that case, all CPUs would agree
that the given CPU's stores happened consecutively.  Yes, they might not
see the intermediate value, but their view of the sequence of values
would be consistent with the given CPU's pair of stores having happened
at a specific place in the sequence of values.

This is not peculiar to this situation -- consider the following:

	CPU 0		CPU 1		CPU 2		CPU 3

	A=1
			Q1=A				Q3=A
					A=2
							A=3
			Q2=A				Q4=A

None of the CPUs saw CPU 2's first assignment A=2, but all of their
reads are consistent with the 1,2,3 sequence of values.  Your example
(if I understand it correctly) is simply a special case where the
pair of assignments happened on a single CPU.

							Thanx, Paul
