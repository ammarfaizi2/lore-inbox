Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVLTOfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVLTOfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVLTOfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:35:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11319 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751070AbVLTOfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:35:08 -0500
Date: Tue, 20 Dec 2005 09:35:07 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <43A81132.8040703@yahoo.com.au>
X-X-Sender: nico@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Nick Piggin wrote:

> Nicolas Pitre wrote:
> > On Tue, 20 Dec 2005, Nick Piggin wrote:
> 
> > > Considering that on UP, the arm should not need to disable interrupts
> > > for this function (or has someone refuted Linus?), how about:
> > 
> > 
> > Kernel preemption.
> > 
> 
> preempt_disable() ?

Sure, and we're now more costly than the current implementation with irq 
disabling.

If we go with simple mutexes that's because there is a gain, even a huge 
one on ARM, especially for the fast uncontended case.  If you guys 
insist on making things so generic and rigid then there is no gain 
anymore worth the bother.


Nicolas
