Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWCJPUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWCJPUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWCJPTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:19:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25241 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750792AbWCJPT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:19:27 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17424.48029.481013.502855@cargo.ozlabs.ibm.com> 
References: <17424.48029.481013.502855@cargo.ozlabs.ibm.com>  <16835.1141936162@warthog.cambridge.redhat.com> 
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 10 Mar 2006 15:19:10 +0000
Message-ID: <26486.1142003950@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:

> > +On some systems, I/O writes are not strongly ordered across all CPUs, and
> > so +locking should be used, and mmiowb() should be issued prior to
> > unlocking the +critical section.
> 
> I think we should say more strongly that mmiowb() is required where
> MMIO accesses are done under a spinlock, and that if your driver is
> missing them then that is a bug.  I don't think it makes sense to say
> that mmiowb is required "on some systems".

The point I was trying to make was that on some systems writes are not
strongly ordered, so we need mmiowb() on _all_ systems. I'll fix the text to
make that point.

> There shouldn't be any problem here, because readw/writew _must_
> ensure that the device accesses are serialized.

No. That depends on the properties of the memory window readw/writew write
through, the properties of the CPU wrt memory accesses, and what explicit
barriers at interpolated inside readw/writew themselves.

If we're accessing a frame buffer, for instance, we might want it to be able
to reorder and combine reads and writes.

> Of course, on an SMP system it would be quite possible for the
> interrupt to be taken on another CPU, and in that case disabling
> interrupts (I assume that by "DISABLE IRQ" you mean
> local_irq_disable() or some such)

Yes. There are quite a few different ways to disable interrupts.

> gets you absolutely nothing; you need to use a spinlock, and then the mmiowb
> is required.

I believe I've said that, though perhaps not sufficiently clearly.

> You may like to include these words describing some of the rules:

Thanks, I probably will.

David
