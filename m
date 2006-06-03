Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWFCVxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFCVxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWFCVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:53:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45187 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751293AbWFCVxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:53:48 -0400
Date: Sat, 3 Jun 2006 17:53:23 -0400
From: Alan Cox <alan@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060603215323.GA13077@devserv.devel.redhat.com>
References: <20060531200236.GA31619@elte.hu> <1149107500.3114.75.camel@laptopd505.fenrus.org> <20060531214139.GA8196@devserv.devel.redhat.com> <1149111838.3114.87.camel@laptopd505.fenrus.org> <20060531214729.GA4059@elte.hu> <1149112582.3114.91.camel@laptopd505.fenrus.org> <1149345421.13993.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149345421.13993.81.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 10:37:01AM -0400, Steven Rostedt wrote:
> Couldn't it be possible to have the misrouted irq function mark the
> DISABLED_IRQ handlers as IRQ_PENDING?  Then have the enable_irq that
> actually enables the irq to call the handlers with interrupts disabled
> if the IRQ_PENDING is set?

We still have the ambiguity with disable_irq. Really we need to have
disable_irq_handler(irq, handler)
