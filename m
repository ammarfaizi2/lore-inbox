Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVLVV1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVLVV1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVLVV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:27:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45792 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030278AbVLVV1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:27:47 -0500
Date: Thu, 22 Dec 2005 16:27:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222210446.GA16092@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Message-id: <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
 <20051222154012.GA6284@elte.hu>
 <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
 <20051222164415.GA10628@elte.hu>
 <20051222165828.GA5268@flint.arm.linux.org.uk> <20051222210446.GA16092@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> The discussion was not about ARMv5 at all. The discussion was about the 
> claim that 'ARMv6 is somehow magical that it needs its own stuff'. No it 
> isnt magical, it's a sane CPU that can implement a sane 
> atomic_dec_return(), or even better, a sane atomic_*_call_if_*() 
> primitive. Or whatever primitive we end up having - i dont mind if it's 
> called __mutex_whatever, as long as it has a _well defined_ meaning.

I'd like to point out that, while atomic_dec_call_if_* is really nice on 
i386, it is probably only good for i386 since no other architecture 
will be able to provide a better implementation than what can be done 
with atomic_dec_return() anyway.  Yet that IMHO overloaded 
atomic_dec_call_if_* stuff appears in core code.

But like for i386, those other architectures might be able to do some 
other tricks to achieve the same needed semantics.  My ARMv6 is one of 
them (and no it doesn't strictly follows the semantics of 
atomic_dec_call_if_*).  Are you willing to add more #if 
defined(CONFIG_MUTEX_FOO_ALGO) in the core code as time goes by?  I hope 
not.

> what i _DONT_ want is some over-opaque per-arch thing that will again 
> escallate into the same situation as semaphores: 23 different 
> implementations nobody is able to change at once, nobody is able to add 
> features or debugging to, and by today there's probably is no single 
> person on this planet who knows all 23 of them to begin with.

I agree completely with you.  But what I don't want is core code 
needlessly restricting architecture specific implementation for short 
and well defined fast paths.  Maybe that's where we must agree upon: a 
well defined fast path helper for mutexes?


Nicolas
