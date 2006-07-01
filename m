Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933068AbWGAALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068AbWGAALA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWGAALA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:11:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:43670 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933068AbWGAAK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:10:59 -0400
Subject: Re: SA_TRIGGER_* vs. SA_SAMPLE_RANDOM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: David Miller <davem@davemloft.net>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151676007.25491.712.camel@localhost.localdomain>
References: <20060629.141703.59468770.davem@davemloft.net>
	 <1151676007.25491.712.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 10:10:29 +1000
Message-Id: <1151712629.27137.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have the same hassle with SA_INTERRUPT. The question arises, if we
> should move the SA_XX flags for interrupts completely out of the signal
> SA name space. Rename to IRQ_xxx and put them into interrupt.h.

Agreed. In addition, if you look specifically at triggers, I've seen so
far:

 - The new SA_* trigger stuff
 - The IRQ_TYPE_* stuff
 - The definitions of bits in struct resource of interrupts in ioport.h
 - The old IRQ_LEVEL
 - Various arch specific things that duplicate it again

In addition, it's different bits with different organisation (for
example, the IRQ_TYPE can express dual edge), etc... 

In my new powerpc IRQ rework, I'm wiping out our own definitions for
triggers and using IRQ_TYPE_* accross the range. I'm howveer not using
the SA_* stuff at all at this point (that is, I'm neither converting the
trigger type of a given interrupt to SA_* and putting it in the
action/desc, nor honoring the SA_* triggers passed in request_irq at
this point). It might be nice to do so, but I find that there is just
way too much confusion at the moment.

Ben.


