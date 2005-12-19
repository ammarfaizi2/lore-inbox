Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVLSUcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVLSUcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVLSUcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:32:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48651 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964959AbVLSUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:32:19 -0500
Date: Mon, 19 Dec 2005 20:32:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219203206.GC20824@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@ftp.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <20051219201118.GA22198@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219201118.GA22198@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:11:18PM +0100, Ingo Molnar wrote:
> We humans have a given number of neurons, which form a hard limit :)

That's also a very valid argument for keeping the number of different
locking mechanisms down to a small number.

> we saw that with the genirq code, with the spinlock code, with the 
> preempt code. Consolidation did not add anything drastiically new, but 
> code consolidation _did_ make things more hackable, and improved the end 
> result far more than a splintered set of implementations would have 
> looked like.
> 
> Just look at the semaphore implementations of various architectures, 
> it's a quite colorful and inconsistent mix. Can you imagine adding 
> deadlock debugging to each of them?

However, the argument _against_ making things generic is that they
become less optimised for specific architectures.  I'm still not
convinced that the genirq stuff is as optimal for ARM as the existing
code is, so I've little motivation to move to the genirq stuff.
(Though I will try to make things easier for those who would like to.)

The same argument applies to attempts to make atomic ops generic using
cmpxchg as a basis for that (as demonstrated on "that other list"), and
the fast path of semaphores.

On "that other list", we're debating saving between 9 and 13 CPU
cycles as an argument in favour of mutexes.  Such a gain which could
very probably be wiped out by any attempt to make them "generic".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
