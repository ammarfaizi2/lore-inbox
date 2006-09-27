Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031260AbWI0XxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031260AbWI0XxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031261AbWI0XxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:53:09 -0400
Received: from www.osadl.org ([213.239.205.134]:48347 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1031260AbWI0XxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:53:08 -0400
Subject: Re: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip
	descriptors
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <200609271621.11608.david-b@pacbell.net>
References: <200609220641.58938.david-b@pacbell.net>
	 <200609220643.07750.david-b@pacbell.net>
	 <1159393098.9326.546.camel@localhost.localdomain>
	 <200609271621.11608.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 01:54:51 +0200
Message-Id: <1159401291.9326.599.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Wed, 2006-09-27 at 16:21 -0700, David Brownell wrote:
> As you should know, irq_chip_set_defaults() ensures that every
> irqchip has startup() and shutdown() methods.  Their default
> implementations use enable() and disable() ... which in turn
> have default implementations using mask()/unmask(), for use
> with non-EIO handlers. 

True. Still you change the semantics.

	chip->mask();
	chip->ack();

is not equal to :

	if (!(desc->status & IRQ_DELAYED_DISABLE))
		irq_desc[irq].chip->mask(irq);


> So what's the correct fix then ... use enable() and disable()?
> Oopsing isn't OK... 

True, but we can not unconditionally change the semantics. 

Does it break existing or new code ?

> It was certainly _tested_ on a 2.6.18 ARM board, so you're clearly wrong
> about at least that part of your feedback as well as the bits about the
> shartup and shutdown calls being "optional" (in any practical sense, since
> they are in fact _always_ present).

Sorry, I did not think about the defaults in the first place. The
conditionals in manage,c are probably superflous leftovers from one of
the evolvement.

	tglx


