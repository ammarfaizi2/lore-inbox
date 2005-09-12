Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVILRlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVILRlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVILRlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:41:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbVILRll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:41:41 -0400
Date: Mon, 12 Sep 2005 10:41:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [3/3] Use the DMA32 zone for  dma_alloc_coherent()/pci_alloc_consistent
 on x86-64
In-Reply-To: <43246267.mailL4Y1GM1RI@suse.de>
Message-ID: <Pine.LNX.4.58.0509121040100.3242@g5.osdl.org>
References: <43246267.mailL4Y1GM1RI@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Andi Kleen wrote:
>
> Use the DMA32 zone for dma_alloc_coherent()/pci_alloc_consistent on x86-64
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/x86_64/kernel/pci-gart.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/pci-gart.c
> +++ linux/arch/x86_64/kernel/pci-gart.c
> @@ -219,6 +219,8 @@ dma_alloc_coherent(struct device *dev, s
>  	/* Kludge to make it bug-to-bug compatible with i386. i386
>  	   uses the normal dma_mask for alloc_coherent. */
>  	dma_mask &= *dev->dma_mask;
> +	if (dma_mask <= 0xffffffff)
> +		gfp |= GFP_DMA32;

How can this be right?

Let's say that dma_mask is 0xfffff (ie 20-bit legacy DMA). It will trigger 
the test, and set the GFP_DMA32 bit. Which can't be right.

I'm going to drop the DMA32 parts of the patches, they seem to be pretty 
raw.

		Linus
