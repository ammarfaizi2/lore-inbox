Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbULKEWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbULKEWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 23:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbULKEWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 23:22:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:35214 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbULKEWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 23:22:07 -0500
Date: Fri, 10 Dec 2004 20:21:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
 series
In-Reply-To: <1102726628.4948.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0412102020190.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz> 
 <1102712732.3264.73.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org> 
 <1102723114.4774.9.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
 <1102726628.4948.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Dec 2004, Alan Cox wrote:
>
> On Sad, 2004-12-11 at 01:23, Linus Torvalds wrote:
> > > Until the 10,000th event it actually seems to work rather happily
> > > without that change.
> > 
> > I suspect you never tried the level-triggered case.
> 
> Level triggered has never been supported.

So? You want it to lock up the machine?

Alan, what _are_ you arguing about? That "disable_irq()" is absolutely 
rquired, because:
 - not having it locks up the machine if the irq happens to be level.
 - not having it means that the "enable_irq()" that happens when the irq 
   is reported to user space is unbalanced.

> Putting a single disable_irq in doesn't change the fact it doesn't work
> because the IRQ is never re-enabled.

Did you actually test the code? Did you ever _look_ at it?

		Linus
