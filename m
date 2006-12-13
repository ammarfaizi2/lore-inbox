Return-Path: <linux-kernel-owner+w=401wt.eu-S964909AbWLMCaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWLMCaj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWLMCaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:30:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42125 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964908AbWLMCai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:30:38 -0500
Date: Tue, 12 Dec 2006 18:30:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops
 safe assignment
In-Reply-To: <457F606B.70805@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612121828060.3535@woody.osdl.org>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
 <20061212225443.GA25902@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org>
 <457F606B.70805@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Nick Piggin wrote:
> 
> parisc seems to, but sparc uses its own open coded spinlock for bitops, and
> the array of regular spinlocks for atomic ops. OTOH, consolidating them
> might give more scalable code *and* a smaller cacheline footprint?

Yeah, I think you'd actually end up with better behaviour by just sharing 
the lock logic, so I don't think there are any downsides there.

> > Should we also just make the rule be that the architecture _must_ allow the
> > silly
> > 
> > 	(atomic_long_t *) -> (unsigned long *)
> > 
> > casting (so that we can make _one_ generic inline function that takes an
> > atomic_long_t and returns the same pointer as an "unsigned long *" to make
> > bitop functions happy), or would this have to be another arch-specific
> > function?
> > 
> > Comments? 
> 
> AFAIK no architecture does anything special, so maybe a generic converter
> would be best, until one comes along that does. (the only thing of note
> really is that half of the atomics use volatile types and half don't, is
> that a problem?).

No, the cast would cast away any such differences, and since anybody would 
have to use asm for the actual implementation, the code can't care about 
the absense or presense of "volatile" anyway.

		Linus
