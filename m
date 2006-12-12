Return-Path: <linux-kernel-owner+w=401wt.eu-S932561AbWLLXRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWLLXRl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWLLXRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:17:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932484AbWLLXRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:17:40 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061212225443.GA25902@flint.arm.linux.org.uk> 
References: <20061212225443.GA25902@flint.arm.linux.org.uk>  <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       davem@davemloft.net, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops safe assignment 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Dec 2006 23:17:22 +0000
Message-ID: <3306.1165965442@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> This seems to be a very silly question (and I'm bound to be utterly
> wrong as proven in my last round) but why are we implementing a new
> set of atomic primitives which effectively do the same thing as our
> existing set?
> 
> Why can't we just use atomic_t for this?

atomic_t is the wrong thing as it's basically an int, not an unsigned long.

atomic64_t/atomic_long_t is also probably the wrong thing to use as it's a
signed long (and the long is also volatile on some platforms - x86_64 for
example).  Bitops operate on unsigned long.

But the most important point is that assign_bits() has to take the same pointer
type as test_bit(), set_bit(), test_and_set_bit(), etc., and none of those
operate on an atomic*_t.

We could change that, of course, but I don't fancy tackling the task just at
the moment.  It oughtn't to be a difficult change, but there are a lot of flags
words in the kernel.

David
