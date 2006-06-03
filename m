Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWFCWfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWFCWfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWFCWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 18:35:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:6313 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751413AbWFCWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 18:35:16 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060603215323.GA13077@devserv.devel.redhat.com>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 18:34:50 -0400
Message-Id: <1149374090.14408.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 17:53 -0400, Alan Cox wrote:
> On Sat, Jun 03, 2006 at 10:37:01AM -0400, Steven Rostedt wrote:
> > Couldn't it be possible to have the misrouted irq function mark the
> > DISABLED_IRQ handlers as IRQ_PENDING?  Then have the enable_irq that
> > actually enables the irq to call the handlers with interrupts disabled
> > if the IRQ_PENDING is set?
> 
> We still have the ambiguity with disable_irq. Really we need to have
> disable_irq_handler(irq, handler)

Yeah, that does make sense, but I think the IRQ_PENDING idea works too.
This way disable_irq_handler doesn't need to mask the interrupt even
without the irqpoll and irqfixup.  Let the interrupt happen and just
skip those handlers that that are disabled.  Then when the handler is
re-enabled, then we can call the handler. Of course we would need a
enable_irq_handler too.

This would make the vortex card's disable_irq not hurt all the other
devices that share the irq with it.

-- Steve


