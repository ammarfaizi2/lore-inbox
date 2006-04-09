Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWDITRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWDITRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWDITRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:17:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29602 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750908AbWDITRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:17:42 -0400
Message-ID: <44395DD2.8080700@garzik.org>
Date: Sun, 09 Apr 2006 15:17:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/x86-64: Return defined error value for bad PCI config
 space accesses
References: <200604091900.k39J0uVn013016@hera.kernel.org>
In-Reply-To: <200604091900.k39J0uVn013016@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.8 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.8 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> -	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
> +	if (!value || (bus > 255) || (devfn > 255) || (reg > 255)) {
> +		*value = -1;
>  		return -EINVAL;
> +	}
>  
>  	spin_lock_irqsave(&pci_config_lock, flags);
>  
> diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
> index 2002c74..f77d7f8 100644
> --- a/arch/i386/pci/mmconfig.c
> +++ b/arch/i386/pci/mmconfig.c
> @@ -80,8 +80,10 @@ static int pci_mmcfg_read(unsigned int s
>  	unsigned long flags;
>  	u32 base;
>  
> -	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095))
> +	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095)) {
> +		*value = -1;
>  		return -EINVAL;
> +	}
>  
>  	base = get_base_addr(seg, bus, devfn);
>  	if (!base)
> diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
> index d4e25f3..b493ed9 100644
> --- a/arch/x86_64/pci/mmconfig.c
> +++ b/arch/x86_64/pci/mmconfig.c
> @@ -75,8 +75,10 @@ static int pci_mmcfg_read(unsigned int s
>  	char __iomem *addr;
>  
>  	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
> -	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095)))
> +	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095))) {
> +		*value = -1;

As the code check indicates, value might be NULL.

Please fix.

	Jeff


