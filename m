Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWDEIrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDEIrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDEIrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 04:47:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbWDEIrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 04:47:14 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4432515F.4030108@yahoo.com.au> 
References: <4432515F.4030108@yahoo.com.au>  <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Keys: Improve usage of memory barriers and remove IRQ disablement 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 05 Apr 2006 09:46:10 +0100
Message-ID: <29064.1144226770@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Shouldn't be needed: Documentation/atomic_ops.txt specifies that any atomic_
> which both modifies its atomic operand and returns something is to be a full
> barrier before and after the operation.

Hmmm... It's possible that I've misunderstood what atomic_ops.txt actually
says.  For instance:

| 	int atomic_inc_and_test(atomic_t *v);
| 	int atomic_dec_and_test(atomic_t *v);
| 
| These two routines increment and decrement by 1, respectively, the
| given atomic counter.  They return a boolean indicating whether the
| resulting counter value was zero or not.
| 
| It requires explicit memory barrier semantics around the operation as
| above.

Note the last paragraph.  "It requires" should be "They require", but the
sense would seem to be obvious.  However, it's not clear on a second reading
as to whether this is an instruction to the _caller_ or an instruction to the
arch _implementer_.

I suppose from reading the abstract at the top:

| This document is intended to serve as a guide to Linux port maintainers on
| how to implement atomic counter, bitops, and spinlock interfaces properly.

that it is meant to be read by the implementor and not the user/caller, in which
case, Nick is correct.

It seems I need to adjust my memory barrier doc, and perhaps I should adjust
atomic_ops.txt too to make it clearer.

David
