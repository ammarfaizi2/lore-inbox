Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVIAVec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVIAVec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVIAVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:34:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19153 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030404AbVIAVeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:34:31 -0400
Subject: Re: [PATCH 1/1] 8250_kgdb driver reworked
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20050901190251.GS3966@smtp.west.cox.net>
References: <20050901190251.GS3966@smtp.west.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 22:57:54 +0100
Message-Id: <1125611874.15768.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static irqreturn_t
> +kgdb8250_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	char iir;
> +
> +	if (irq != KGDB8250_IRQ)
> +		return IRQ_NONE;

How can this occur - you gave the IRQ number in the register_irq. WHy
test for it, and if it occurs why not BUG()

> +	/*
> +	 * If  there is some other CPU in KGDB then this is a
> +	 * spurious interrupt. so return without even checking a byte
> +	 */
> +	if (atomic_read(&debugger_active))
> +		return IRQ_NONE;
> +

Shared IRQ -> hung box. 

Also lose the ugly confusing macros like CURRENTPORT please to follow
kernel style better. In fact why not keep a pointer to the 'current'
uart to get tighter code too ?

