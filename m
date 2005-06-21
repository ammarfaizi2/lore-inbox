Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVFUIyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFUIyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFUIPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:15:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3469 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261585AbVFUHSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:18:35 -0400
Date: Tue, 21 Jun 2005 09:19:39 +0200
From: Jens Axboe <axboe@suse.de>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       neilb@cse.unsw.edu.au
Subject: Re: [patch 11/12] drivers/block/umem.c: Use the DMA_{64, 32}BIT_MASK constants
Message-ID: <20050621071938.GC9020@suse.de>
References: <20050620215139.825371000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620215139.825371000@nd47.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20 2005, domen@coderock.org wrote:
> From: Tobias Klauser <tklauser@nuerscht.ch>
> 
> 
> 
> Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
> pci_set_dma_mask() or pci_set_consistent_dma_mask()
> These patches include dma-mapping.h explicitly because it caused errors
> on some architectures otherwise.
> See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details
> 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
>  umem.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Index: quilt/drivers/block/umem.c
> ===================================================================
> --- quilt.orig/drivers/block/umem.c
> +++ quilt/drivers/block/umem.c
> @@ -50,6 +50,7 @@
>  #include <linux/timer.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/dma-mapping.h>
>  
>  #include <linux/fcntl.h>        /* O_ACCMODE */
>  #include <linux/hdreg.h>  /* HDIO_GETGEO */
> @@ -892,8 +893,8 @@ static int __devinit mm_pci_probe(struct
>  	printk(KERN_INFO "Micro Memory(tm) controller #%d found at %02x:%02x (PCI Mem Module (Battery Backup))\n",
>  	       card->card_number, dev->bus->number, dev->devfn);
>  
> -	if (pci_set_dma_mask(dev, 0xffffffffffffffffLL) &&
> -	    !pci_set_dma_mask(dev, 0xffffffffLL)) {
> +	if (pci_set_dma_mask(dev, DMA_64BIT_MASK) &&
> +	    !pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
>  		printk(KERN_WARNING "MM%d: NO suitable DMA found\n",num_cards);
>  		return  -ENOMEM;
>  	}

Not from your patch, but that code looks a little strange. We error if
setting a 64-bit mask fails _but_ the 32-bit one succeeds? That can't be
right.

-- 
Jens Axboe

