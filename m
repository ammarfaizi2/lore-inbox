Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWFCOh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWFCOh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 10:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWFCOh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 10:37:27 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:4856 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030308AbWFCOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 10:37:27 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149112582.3114.91.camel@laptopd505.fenrus.org>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 10:37:01 -0400
Message-Id: <1149345421.13993.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 23:56 +0200, Arjan van de Ven wrote:
> On Wed, 2006-05-31 at 23:47 +0200, Ingo Molnar wrote:
> > * Arjan van de Ven <arjan@infradead.org> wrote:
> > > yeah since misrouted irqs will cause the kernel do disable irqs 'at 
> > > random' more or less .. for which the handlers now would become 
> > > unreachable which isn't good.
> > 
> > couldnt most of these problems be avoided by tracking whether a handler 
> > _ever_ returned a success status? That means that irqpoll could safely 
> > poll handlers for which we know that they somehow arent yet matched up 
> > to any IRQ line?
> 
> I suspect the real solution is to have a
> 
> disable_irq_handler(irq, handler) 
> 
> function which does 2 things
> 1) disable the irq at the hardware level
> 2) mark the handler as "don't call me"
> 
> it matches the semantics here; what these drivers want is 1) not get an
> irq handler called and 2) not get an irq flood

(Sorry for coming in late, but I'm slowly catching up with LKML)

Couldn't it be possible to have the misrouted irq function mark the
DISABLED_IRQ handlers as IRQ_PENDING?  Then have the enable_irq that
actually enables the irq to call the handlers with interrupts disabled
if the IRQ_PENDING is set?

-- Steve


