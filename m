Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVLMLXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVLMLXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 06:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVLMLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 06:23:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750836AbVLMLXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 06:23:19 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439E1381.2060201@yahoo.com.au> 
References: <439E1381.2060201@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 11:23:01 +0000
Message-ID: <974.1134472981@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Any reason why you're setting up your own style of waitqueue in
> mutex-simple.c instead of just using the kernel's style of waitqueue?

Because I can steal the code from FRV's semaphores or rw-semaphores, and this
way I can be sure of what I'm doing.

Note that the sleeping processes are generally dequeued and dispatched by the
up() function, which means they don't have to take the spinlock themselves.
This may be possible to do magically with the waitqueue stuff, but I'm not sure
how to do it; it's horribly complicated to read through the sources and there
isn't much documentation.

> > +	mb();
> 
> This should be smp_mb(), I think.

Yes.

David
