Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWJFQnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWJFQnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJFQnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:43:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422703AbWJFQnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:43:43 -0400
Date: Fri, 6 Oct 2006 09:40:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than
 passing to IRQ handlers
In-Reply-To: <d120d5000610060921q493a3f58n45285e6dcc037156@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610060937120.3952@g5.osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org> 
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> 
 <18975.1160058127@warthog.cambridge.redhat.com>  <4525A8D8.9050504@garzik.org>
  <1160133932.1607.68.camel@localhost.localdomain>  <45263ABC.4050604@garzik.org>
 <20061006111156.GA19678@elte.hu>  <45263D9C.9030200@garzik.org>
 <452673AC.1080602@garzik.org>  <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
 <d120d5000610060921q493a3f58n45285e6dcc037156@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Dmitry Torokhov wrote:
> 
> But drivers rarely care about exact IRQ that caused their interrupt
> routines to be called.

Sure. But it's not a _cleanup_ as far as I can tell.

> Drivers that truly need to know IRQ can have it added to dev_id cookie
> and use separate dev_ids.

I'm not saying that what you describe is impossible. I'm just saying that 
it's pointless. 

What's wrong with passing in "irq"? It makes sense from a logical angle, 
and it's something you kind of expect if you think of irq's as "signals 
for the kernel" (which they almost literally used to be, why do you think 
it was called "SA_SHIRQ" etc?).

So there is absolutely nothing wrong with passing in irq from a conceptual 
or a practical angle, and some routines _do_ use it.

		Linus
