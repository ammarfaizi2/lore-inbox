Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVLVQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVLVQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLVQo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:44:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52664 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965168AbVLVQo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:44:58 -0500
Date: Thu, 22 Dec 2005 17:44:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222164415.GA10628@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
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


* Nicolas Pitre <nico@cam.org> wrote:

> > i'm curious, how would this ARMv6 solution look like, and what would be 
> > the advantages over the atomic swap based variant?
> 
> On ARMv6 (which can be SMP) the atomic swap instruction is much more 
> costly than on former ARM versions.  It however has ll/sc instructions 
> which allows it to implement a true atomic decrement, and the lock 
> fast path would look like: [...]

but couldnt you implement atomic_dec_return() with the ll/sc 
instructions? Something like:

repeat:
       ldrex   r1, [r0]
       sub     r1, r1, #1
       strex   r2, r1, [r0]
       orrs    r0, r2, r1
       jneq    repeat

(shot-in-the-dark guess at ARMv6 assembly)

hm?

	Ingo
