Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVLVMpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVLVMpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVLVMpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:45:50 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42884 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932429AbVLVMpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:45:50 -0500
Date: Thu, 22 Dec 2005 13:45:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222124506.GB21239@elte.hu>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222115329.GA30964@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > Changes since -V3:
> > 
> > - imlemented an atomic_xchg() based mutex implementation. It integrated
> >   pretty nicely into the generic code, and most of the code is still
> >   shared.
> > 
> > - added __ARCH_WANT_XCHG_BASED_ATOMICS: if an architecture defines 
> >   this then the generic mutex code will switch to the atomic_xchg() 
> >   implementation.
> > 
> >   This should be conceptually equivalent to the variant Nicolas Pitre 
> >   posted - Nicolas, could you check out this one? It's much easier to 
> >   provide this in the generic implementation, and the code ends up 
> >   looking cleaner.
> > 
> > - eliminated ARCH_IMPLEMENTS_MUTEX_FASTPATH: there's no need for 
> >   architectures to override the generic code anymore, with the 
> >   introduction of __ARCH_WANT_XCHG_BASED_ATOMICS.
> > 
> > - ARM: enable __ARCH_WANT_XCHG_BASED_ATOMICS.
> 
> I must admit I really really hat __ARCH_ stuff if we can avoid it. An 
> <asm/mutex.h> that usually includes two asm-generic variants is 
> probably a much better choice.

agreed. In my tree i've changed it to CONFIG_MUTEX_XCHG_ALGORITHM, which 
is selected by ARM in its Kconfig.

	Ingo
