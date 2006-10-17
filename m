Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWJQP3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWJQP3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWJQP3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:29:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53770 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751138AbWJQP3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:29:43 -0400
Date: Tue, 17 Oct 2006 11:29:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061017012448.GB1781@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610171115500.6016-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Paul E. McKenney wrote:

> > The reason I don't like "conditionally precedes" is because it suggests
> > the ordering is not automatic even in the single-CPU case.
> 
> Aside from MMIO accesses, why would you be using memory barriers in the
> single-CPU case?

Obviously you wouldn't.  But you might be fooled into doing so if you saw
the term "conditionally precedes" together with an explanation that the
"condition" requires a memory barrier to be present.  You might also draw
this erroneous conclusion if you are on an SMP system but your variable is
accessed by only one of the CPUs.

>  If you aren't using memory barriers, then just plain
> "precedes" works fine -- "conditionally precedes" applies only to memory
> barriers acting on normal memory (again, MMIO is handled specially).

No, no!  Taken out of context this sentence looks terribly confused.  
Read it again and you'll see what I mean.  (Think about what it says for
people who don't use memory barriers on SMP systems.)  Here's a much more
accurate statement:

	If you are in the single-CPU case then just plain "precedes" 
	works fine for normal memory accesses (MMIO is handled
	specially).

	But when multiple CPUs access the same variable all ordering
	is "conditional"; each CPU must use a memory barrier to
	guarantee the desired ordering.

Alan

