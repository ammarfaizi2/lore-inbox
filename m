Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLTTzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLTTzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLTTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:55:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37285 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932066AbVLTTzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:55:14 -0500
Date: Tue, 20 Dec 2005 14:55:13 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <20051220192018.GB24199@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Message-id: <Pine.LNX.4.64.0512201449450.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
 <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
 <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <43A81DD4.30906@yahoo.com.au>
 <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
 <20051220192018.GB24199@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Russell King wrote:

> On Tue, Dec 20, 2005 at 11:35:22AM -0500, Nicolas Pitre wrote:
> > So 14 instructions total with preemption disabling, and that's with the 
> > best implementation possible by open coding everything instead of 
> > relying on generic functions/macros.
> 
> I agree with your analysis Nicolas.
> 
> However, don't forget to compare this with our existing semaphore
> implementation which is 9 instructions, or 8 for the SMP version.
> 
> In total, this means that mutexes will be _FAR MORE EXPENSIVE_ on ARM
> than our semaphores.

I don't follow you at all.  I'm arguing that mutexes are much less 
expensive than any semaphore implementation (except on SMP where 
semaphores and mutexes will probably look the same).

> Forcing architectures down the "lets make everything generic" path
> does not always hack it.  It can't do by its very nature.  Generic
> implementations are *always* sub-optimal and it is pretty clear
> that any gain that mutexes _may_ give is completely wasted on ARM
> by the overhead of having a generic framework imposed upon us.

Agreed.  And that's why I'm suggesting that the mutex locking/unlocking 
fast path should be architecture specific.  And to that effect I'm 
working on a patch against Ingo's mutex code to illustrate my point.

What should still remain generic is the contention fallback.  That's 
where the actual complexity lives and that part doesn't have to be 
optimized for best inline performances.


Nicolas
