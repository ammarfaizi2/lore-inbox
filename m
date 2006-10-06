Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWJFPss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWJFPss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWJFPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:48:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751503AbWJFPsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:48:46 -0400
Date: Fri, 6 Oct 2006 08:47:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than
 passing to IRQ handlers
In-Reply-To: <452673AC.1080602@garzik.org>
Message-ID: <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org>
 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
 <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org>
 <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org>
 <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org>
 <452673AC.1080602@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Jeff Garzik wrote:
>
> Here is the raw, un-split-up first pass of the irq argument removal patch
> (500K):	http://gtf.org/garzik/misc/patch.irq-remove

So I'm not at all as sure about this as about the "regs" stuff.

The "regs" value has always been controversial. It's pretty much always 
existed (due to the keyboard hander and the magic debugging keysequences), 
and anybody who looks at 0.01 will quickly realize that the keyboard 
driver was one of the very first drivers (I think it's even written in 
assembly at that point: originally _all_ of what was to become Linux was 
pure asm, the whole "oh, cool, I could write this part in C" came later). 
But it's been pretty much a special case since day #1, purely for that 
"press a key to see where the h*ck we hung" case.

In contrast, the irq argument itself is really no different from the 
cookie we pass in on registration - it's just passing it back to the 
driver that requested the thing. So unlike "regs", there's not really 
anything strange about it, and there's nothing really "wrong" with having 
it there.

So I'm not at all as convinced about this one.
