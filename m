Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVLSUW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVLSUW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLSUW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:22:59 -0500
Received: from kanga.kvack.org ([66.96.29.28]:31978 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S964944AbVLSUW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:22:58 -0500
Date: Mon, 19 Dec 2005 15:19:44 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219201944.GA17267@kvack.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org> <20051219201118.GA22198@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219201118.GA22198@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:11:18PM +0100, Ingo Molnar wrote:
> i think we also need to look at the larger picture. If this really is a 
> bug that hid for years, it shows that the semaphore code is too complex 
> to be properly reviewed and improved. Hence even assuming that the mutex 
> code does not bring direct code advantages (which i'm disputing :-), the 
> mutex code is far simpler and thus easier to improve. We humans have a 
> given number of neurons, which form a hard limit :) In fact it's the 
> mutex code that made it apparent that there's something wrong with 
> semaphores.

True, but then the original semaphores weren't designed with fairness in 
mind so much as being able to operate quickly.  The commodity SMP hardware 
that we have today has significantly different characteristics than the 
first dual Pentium I used.  I think there is significant room for improving 
the implementation while still making it as tight and lean as possible.  To 
that end, adding state diagrams that make it easier to visualise what is 
going on would be a big help.  With that in place, it will be easier to 
provide optimized fast paths with understandable logic. 

> Just look at the semaphore implementations of various architectures, 
> it's a quite colorful and inconsistent mix. Can you imagine adding 
> deadlock debugging to each of them?

Agreed.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
