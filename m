Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVLVRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVLVRdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVLVRdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:33:12 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:40346 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030230AbVLVRdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:33:11 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Andi Kleen <ak@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
References: <20051222114147.GA18878@elte.hu>
	 <20051222115329.GA30964@infradead.org>
	 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 12:33:00 -0500
Message-Id: <1135272780.12761.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 10:34 -0500, Nicolas Pitre wrote:

> > Actually just havign asm/mutex.h implement the faspath per-arch and get
> > rid of all the oddball atomic.h additions would be even better.  While
> > this means we need per-arch code it also means the code is a lot easier
> > understandable, and we don't add odd public APIs.
> 
> I'm with Christoph here.  Please preserve my 
> arch_mutex_fast_lock/arch_mutex_fast_unlock helpers.  I did it that way 
> because the most important thing they bring is flexibility where it is 
> needed i.e. in architecture specific implementations.  And done that way 
> the architecture specific part is well abstracted with the minimum 
> semantics allowing flexibility in the implementation.
> 
> I insist on that because, even if ARM currently relies on the atomic 
> swap behavior, on ARMv6 at least this can be improved even further, but 
> a special implementation which is neither a fully qualified atomic 
> decrement nor an atomic swap is needed.  That's why I insist that you 
> should keep my arch_mutex_fast_lock and friends (rename them if you 
> wish) and remove __ARCH_WANT_XCHG_BASED_ATOMICS entirely.
> 

Not sure how well this is accepted, but would it be acceptable to have
the mutex_lock and friends covered with the (weak) attribute?

ie.

void fastcall __sched __attribute__((weak)) mutex_lock(struct mutex *lock)

Then let the archs override them if they wish?

You would just need to make an extra slow path mutex visible to the archs.

-- Steve


