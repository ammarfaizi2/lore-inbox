Return-Path: <linux-kernel-owner+w=401wt.eu-S1762396AbWLKT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762396AbWLKT73 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762463AbWLKT73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:59:29 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:52822 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762396AbWLKT72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:59:28 -0500
Subject: Re: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
From: Daniel Walker <dwalker@mvista.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061211195401.GA12440@flint.arm.linux.org.uk>
References: <20061210163545.488430000@mvista.com>
	 <20061211190554.GA26392@elte.hu> <1165865908.8103.30.camel@imap.mvista.com>
	 <20061211195401.GA12440@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 11:59:20 -0800
Message-Id: <1165867160.8103.36.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 19:54 +0000, Russell King wrote:

> > > what if the irq got disabled meanwhile? Also, chip->enable is a 
> > > compatibility method, not something we should use in a flow handler.
> > 
> > I don't know how other arches deal with IRQ_PENDING, but ARM (OMAP at
> > least) disables the IRQ on IRQ_PENDING.
> 
> Please point out where it's doing that, and I'll take a look to see
> if it's doing something it shouldn't.

It's in arch/arm/plat-omap/gpio.c . It uses the lowlevel function to
disable the interrupt, not chip->disable() . In gpio_irq_handler() .

Daniel

