Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVLVVzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVLVVzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVLVVzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:55:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:59085 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030315AbVLVVzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:55:16 -0500
Date: Thu, 22 Dec 2005 22:54:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222215430.GA7506@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain> <20051222164415.GA10628@elte.hu> <20051222165828.GA5268@flint.arm.linux.org.uk> <20051222210446.GA16092@elte.hu> <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain>
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

> I'd like to point out that, while atomic_dec_call_if_* is really nice 
> on i386, it is probably only good for i386 since no other architecture 
> will be able to provide a better implementation than what can be done 
> with atomic_dec_return() anyway.  Yet that IMHO overloaded 
> atomic_dec_call_if_* stuff appears in core code.

i'd have no problem with going to atomic_dec_return() on i386 too.  
atomic_dec_call_if_*() is just working around a gcc limitation: there's 
no way to pass a condition from inline assembly into C code, it has to 
go over a register. But the difference is small, just 1 extra 'sete' 
instruction. So x86 would be just fine with atomic_dec_return() too.

anyway, it seems like everyone would like to hack a few instructions 
from the fastpath, so we might as well go with your approach. As long as 
the state is well-defined (and it has to be well-defined because it all 
hits the common slowpath), and the function names are descriptive of 
what happens, it's fine with me.

	Ingo
