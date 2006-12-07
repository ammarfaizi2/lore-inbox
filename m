Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164017AbWLGX6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164017AbWLGX6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164021AbWLGX6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:58:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164017AbWLGX6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:58:46 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061207234250.GH1255@flint.arm.linux.org.uk> 
References: <20061207234250.GH1255@flint.arm.linux.org.uk>  <20061207085409.228016a2.akpm@osdl.org> <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> <639.1165521999@redhat.com> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 23:58:23 +0000
Message-ID: <26012.1165535903@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Incorrect.  pre-v6 ARM bitops for test_and_xxx_bit() all do:
> 
> 	save and disable irqs
> 	load value
> 	test bit
> 	if not in desired state, alter bit and write it back
> 	restore irqs

Hmmm...  ARM has two implementations.  One in the header files which is what I
consulted when writing that email:

static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *p)
{
	unsigned long flags;
	unsigned long mask = 1UL << (bit & 31);

	p += bit >> 5;

	raw_local_irq_save(flags);
	*p |= mask;
	raw_local_irq_restore(flags);
}

And the other in the libs which does as you say.  Why the one in the header
file at all?

David
