Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVLTWGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVLTWGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLTWGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:06:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932177AbVLTWGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:06:00 -0500
Date: Tue, 20 Dec 2005 14:04:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512201354210.4827@g5.osdl.org>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au>
 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512201026230.4827@g5.osdl.org> <20051220193423.GC24199@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0512201202200.4827@g5.osdl.org>
 <Pine.LNX.4.64.0512201533120.26663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Nicolas Pitre wrote:
> 
> I mean...... what is it with mutexes that you dislike to the point of 
> bending backward that far, and even after seeing the numbers, with such 
> a semaphore implementation that _I_ even wouldn't trust people to use 
> correctly?

Quite frankly, what has disgusted me about this mutex discussion is the 
totally specious arguments for the new mutexes that just rubs me entirely 
the wrong way.

If it had _started_ with a mutex implementation that was faster, simpler, 
and didn't rename the old and working semaphores, I'd have been perfectly 
fine with it.

As it is, the discussion has been pretty much everything but that. 

And then people who argue about single cycles, end up dismissing the 
single cycles when I argue that "ld+st" is faster - like you just did.

Be consistent, dammit. If single cycles matter, they matter. If they 
don't, then the existing code is better, since it's existing and works. 
You can't have it both ways.

In other words: if people didn't mix up issues that had nothing to do with 
this into it, I'd be happier. I've already said that a mutex that does 
_not_ replace semaphore (and doesn't mess with naming) is acceptable. 

We've done that before. But do it RIGHT, dammit. And don't mix existing 
semaphores into it (for example, completions didn't change any old users).

			Linus	
