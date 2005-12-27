Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVL0PmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVL0PmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVL0PmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 10:42:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19923 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751112AbVL0PmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 10:42:04 -0500
Date: Tue, 27 Dec 2005 16:41:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 04/11] mutex subsystem, add include/asm-x86_64/mutex.h
Message-ID: <20051227154128.GA15961@elte.hu>
References: <20051227141548.GE6660@elte.hu> <43B158A6.7080508@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B158A6.7080508@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> >+		:"=D" (dummy)						\
> >+		: "D" (v)						\
> >+		: "rax", "rsi", "rdx", "rcx",				\
> >+		  "r8", "r9", "r10", "r11", "memory");			\
> >+} while (0)
> 
> Hi Ingo
> 
> I do think this assembly is not very fair. It has an *insane* register 
> pressure for the compiler : The fast path is thus not so fast.

if you look at the compiler output you'll notice that it's not a problem 
actually: this fastpath is only inlined into the generic code, where it 
has no clobbering side-effects.

you are right in that if this were to be inlined left and right, this 
would be quite bad.

	Ingo
