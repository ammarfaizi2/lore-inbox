Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUJMBJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUJMBJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268153AbUJMBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:09:47 -0400
Received: from mail.renesas.com ([202.234.163.13]:51079 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268146AbUJMBJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:09:44 -0400
Date: Wed, 13 Oct 2004 10:09:29 +0900 (JST)
Message-Id: <20041013.100929.982911309.takata.hirokazu@renesas.com>
To: paul.mundt@nokia.com
Cc: akpm@osdl.org, nico@cam.org, takata@linux-m32r.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fix smc91x build for sh/ppc
From: Hirokazu Takata <takata.hirokazu@renesas.com>
In-Reply-To: <20041012161631.GA8766@hed040-158.research.nokia.com>
References: <20041012161631.GA8766@hed040-158.research.nokia.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul,

OK. I agree with you.

From: Paul Mundt <paul.mundt@nokia.com>
Subject: [PATCH] net: fix smc91x build for sh/ppc
Date: Tue, 12 Oct 2004 19:16:32 +0300
> The current smc91x code uses set_irq_type(). It looks like the m32r guys
> worked around this by adding a !defined(__m32r__) check, but this is equally
> bogus as set_irq_type() is an arm/arm26-specific function.
> 
> Trying to get this to build on sh died in the same spot, so we just back out
> the m32r change and make it depend on CONFIG_ARM instead. Notably, the ppc
> build would have been broken by this as well, but it doesn't seem like anyone
> noticed this there yet.
> 
> Signed-off-by: Paul Mundt <paul.mundt@nokia.com>
> 
>  drivers/net/smc91x.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> ===== drivers/net/smc91x.c 1.7 vs edited =====
> --- 1.7/drivers/net/smc91x.c	2004-09-17 03:07:00 +03:00
> +++ edited/drivers/net/smc91x.c	2004-10-12 19:05:25 +03:00
> @@ -1885,7 +1885,7 @@
>        	if (retval)
>        		goto err_out;
>  
> -#if !defined(__m32r__)
> +#ifdef CONFIG_ARM
>  	set_irq_type(dev->irq, IRQT_RISING);
>  #endif
>  #ifdef SMC_USE_PXA_DMA

-- Takata
