Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751215AbWFDJeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFDJeZ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWFDJeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:34:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751215AbWFDJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:34:24 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149374090.14408.4.camel@localhost.localdomain>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <1149345421.13993.81.camel@localhost.localdomain>
	 <20060603215323.GA13077@devserv.devel.redhat.com>
	 <1149374090.14408.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 11:34:09 +0200
Message-Id: <1149413649.3109.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 18:34 -0400, Steven Rostedt wrote:
> On Sat, 2006-06-03 at 17:53 -0400, Alan Cox wrote:
> > On Sat, Jun 03, 2006 at 10:37:01AM -0400, Steven Rostedt wrote:
> > > Couldn't it be possible to have the misrouted irq function mark the
> > > DISABLED_IRQ handlers as IRQ_PENDING?  Then have the enable_irq that
> > > actually enables the irq to call the handlers with interrupts disabled
> > > if the IRQ_PENDING is set?
> > 
> > We still have the ambiguity with disable_irq. Really we need to have
> > disable_irq_handler(irq, handler)
> 
> Yeah, that does make sense, but I think the IRQ_PENDING idea works too.
> This way disable_irq_handler doesn't need to mask the interrupt even
> without the irqpoll and irqfixup.  Let the interrupt happen and just
> skip those handlers that that are disabled.  Then when the handler is
> re-enabled, then we can call the handler. Of course we would need a
> enable_irq_handler too.
> 
> This would make the vortex card's disable_irq not hurt all the other
> devices that share the irq with it.
can't do that; if you get an irq anyway from the hardware you now have a
screamer...... which is why vortex really needs to disable the irq at
the hardware level.

