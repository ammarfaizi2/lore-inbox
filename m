Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTFXRqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFXRqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:46:19 -0400
Received: from [205.245.181.57] ([205.245.181.57]:37124 "EHLO
	aimail.aiinet.priv") by vger.kernel.org with ESMTP id S262403AbTFXRqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:46:15 -0400
Message-ID: <AD59566A9D83864F871AE2E52503064005068C@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [2.5 patch] ULL postfixes for tg3.c
Date: Tue, 24 Jun 2003 14:00:07 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q: Why not to use something even easier to read (and write), like "~0ULL" or
better yet "UINT64_MAX" (stdint.h)?

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@fs.tum.de] 
> Sent: Tuesday, June 24, 2003 1:48 PM
> To: David S. Miller; Jeff Garzik
> Cc: linux-net@vger.kernel.org; linux-kernel@vger.kernel.org; 
> trivial@rustcorp.com.au
> Subject: [2.5 patch] ULL postfixes for tg3.c
> 
> 
> The patch below adds ULL postfixes to three constants in tg3.c .
> 
> There's no need to create an int constant and later cast it to u64.
> 
> The second case was also incorrect since the constant was too 
> big for an 
> int.
> 
> Please apply
> Adrian
> 
> --- linux-2.5.73-not-full/drivers/net/tg3.c.old	
> 2003-06-24 19:42:20.000000000 +0200
> +++ linux-2.5.73-not-full/drivers/net/tg3.c	2003-06-24 
> 19:43:47.000000000 +0200
> @@ -6679,16 +6679,16 @@
>  	}
>  
>  	/* Configure DMA attributes. */
> -	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
> +	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
>  		pci_using_dac = 1;
>  		if (pci_set_consistent_dma_mask(pdev,
> -						(u64) 
> 0xffffffffffffffff)) {
> +						
> 0xffffffffffffffffULL)) {
>  			printk(KERN_ERR PFX "Unable to obtain 
> 64 bit DMA "
>  			       "for consistent allocations\n");
>  			goto err_out_free_res;
>  		}
>  	} else {
> -		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
> +		err = pci_set_dma_mask(pdev, 0xffffffffULL);
>  		if (err) {
>  			printk(KERN_ERR PFX "No usable DMA 
> configuration, "
>  			       "aborting.\n");
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
