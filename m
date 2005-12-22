Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVLVV4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVLVV4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVLVV4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:56:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43142 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030335AbVLVV43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:56:29 -0500
Date: Thu, 22 Dec 2005 13:54:57 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-Reply-To: <20051222213902.GA32433@elte.hu>
Message-ID: <Pine.LNX.4.62.0512221349290.9324@schroedinger.engr.sgi.com>
References: <20051222153717.GA6090@elte.hu> <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
 <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
 <20051222213902.GA32433@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> > I would like some more flexible way of dealing with locks in general. 
> > The code for the MUTEXes seems to lock us into a specific way of 
> > realizing locks again.
> 
> yeah, but we should be careful where to put it: the perfect place for 
> most of these features and experiments is in the _generic_ code, not in 
> arch-level code! Look at how we are doing it with spinlocks. It used to 
> be a nightmare that every arch had to implement preempt support, or 
> spinlock debugging support, and they ended up not implementing these 
> features at all, or only doing it partially.

I think we need to have the ability to modify things on both levels. There 
needs to be a way to introduce f.e. a general HBO type locking algorithm 
for all architectures. But then also a way for an arch to do special
things that are strongly depending on a particular arch like relocating
the actual storage location of a lock to a specially handled memory area.

> i definitely do not say that _everything_ should be generalized. That 
> would be micromanaging things. But i definitely think there's an 
> unhealthy amount of _under_ generalization in current Linux 
> architectures, and i dont want the mutex subsystem to fall into that 
> trap.

The mutex implementation here is one implementation. There needs to be
a generic way to replace this implementation with another in an arch
independent way as well as the ability for an arch to modify low level
elements necessary to optimize locks on a particular hardware.

Then there is the common ground of low level mutexes with spinlocks. So 
far spinlocks also work for semaphores. Now with the MUTEXes we have two 
different locking mechanism that largely overlap in in functionality. In 
the past one could simply replace the spinlock implementation, now one 
also has to worry about MUTEXes.

I wish we had some strategy to make all of this easier and gather common 
elements together.
