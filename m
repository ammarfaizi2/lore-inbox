Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFNXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFNXOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFNXOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:14:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:26591 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261410AbVFNXMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:12:34 -0400
Subject: Re: [PATCH 2.6][PPC32] RESEND: don't recursively crash in die() on
	CHRP/PReP machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20050614193826.GE13702@fngna.oyu>
References: <20050614193826.GE13702@fngna.oyu>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 09:11:29 +1000
Message-Id: <1118790689.5986.183.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 21:38 +0200, Jakub Bogusz wrote:
> This patch avoids recursive crash (leading to kernel stack overflow) in
> die() on CHRP/PReP machines when CONFIG_PMAC_BACKLIGHT=y.
> set_backlight_* functions are placed in pmac section, which is discarded
> when _machine != _MACH_Pmac.
> 
> I already posted this patch to LKML few months ago:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0300.html
> and it has been applied to linux-2.4 tree, but still not 2.6.
> (patch was made against 2.4.27, but still applies cleanly against
> kernels up to 2.6.11.12)
> 
> Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- linux-2.4.27/arch/ppc/kernel/traps.c.orig	Wed Apr 14 15:05:27 2004
> +++ linux-2.4.27/arch/ppc/kernel/traps.c	Mon Nov 29 19:05:28 2004
> @@ -88,8 +88,10 @@
>  	console_verbose();
>  	spin_lock_irq(&die_lock);
>  #ifdef CONFIG_PMAC_BACKLIGHT
> -	set_backlight_enable(1);
> -	set_backlight_level(BACKLIGHT_MAX);
> +	if (_machine == _MACH_Pmac) {
> +		set_backlight_enable(1);
> +		set_backlight_level(BACKLIGHT_MAX);
> +	}
>  #endif
>  	printk("Oops: %s, sig: %ld\n", str, err);
>  	show_regs(fp);
> 
> 

