Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbTEMSow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTEMSow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:44:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29445 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262638AbTEMSos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:44:48 -0400
Date: Tue, 13 May 2003 19:55:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminates irqN: nobody cared! and backtrace on inserting 16bit PCMCIA card.
Message-ID: <20030513195513.E15172@flint.arm.linux.org.uk>
Mail-Followup-To: Simon Kelley <simon@thekelleys.org.uk>,
	linux-kernel@vger.kernel.org
References: <3EC12A98.9040003@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC12A98.9040003@thekelleys.org.uk>; from simon@thekelleys.org.uk on Tue, May 13, 2003 at 06:25:44PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 06:25:44PM +0100, Simon Kelley wrote:
> diff -urN linux-2.5.69.orig/drivers/pcmcia/rsrc_mgr.c  linux-2.5.69/drivers/pcmcia/rsrc_mgr.c
> --- linux-2.5.69.orig/drivers/pcmcia/rsrc_mgr.c Mon May  5 00:53:32 2003
> +++ linux-2.5.69/drivers/pcmcia/rsrc_mgr.c      Tue May 13 18:18:35 2003
> @@ -601,7 +601,7 @@
> 
>   #ifdef CONFIG_PCMCIA_PROBE
> 
> -static irqreturn_t fake_irq(int i, void *d, struct pt_regs *r) { return IRQ_NONE; }
> +static irqreturn_t fake_irq(int i, void *d, struct pt_regs *r) { return IRQ_HANDLED; }
>   static inline int check_irq(int irq)
>   {
>       if (request_irq(irq, fake_irq, 0, "bogus", NULL) != 0)
> 

Oh damn, and I was hoping to kill fake_irq and make it use no_action()
instead!

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

