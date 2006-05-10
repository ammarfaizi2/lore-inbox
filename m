Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWEJR4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWEJR4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWEJR4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:56:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:45267 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932073AbWEJR4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:56:19 -0400
Date: Wed, 10 May 2006 12:54:56 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH -mm] dl2k gcc 4.1 warning fix
Message-ID: <20060510175456.GA26617@us.ibm.com>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>, akpm@osdl.org,
	edward_peng@dlink.com.tw, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <200605100255.k4A2tvqm031661@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100255.k4A2tvqm031661@dwalker1.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:55:57PM -0700, Daniel Walker wrote:
> Fixes the following warning,

Please CC netdev on networking patches.

All the changed lines are over 80 chars.  Please fix.

Thanks,
Jon

> drivers/net/dl2k.c: In function 'rio_free_tx':
> drivers/net/dl2k.c:768: warning: integer constant is too large for 'long' type
> drivers/net/dl2k.c: In function 'receive_packet':
> drivers/net/dl2k.c:896: warning: integer constant is too large for 'long' type
> drivers/net/dl2k.c:904: warning: integer constant is too large for 'long' type
> drivers/net/dl2k.c:916: warning: integer constant is too large for 'long' type
> drivers/net/dl2k.c: In function 'rio_close':
> drivers/net/dl2k.c:1803: warning: integer constant is too large for 'long' type
> drivers/net/dl2k.c:1813: warning: integer constant is too large for 'long' type
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/net/dl2k.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/net/dl2k.c
> +++ linux-2.6.16/drivers/net/dl2k.c
> @@ -765,7 +765,7 @@ rio_free_tx (struct net_device *dev, int
>  			break;
>  		skb = np->tx_skbuff[entry];
>  		pci_unmap_single (np->pdev,
> -				  np->tx_ring[entry].fraginfo & 0xffffffffffff,
> +				  np->tx_ring[entry].fraginfo & 0xffffffffffffULL,
>  				  skb->len, PCI_DMA_TODEVICE);
>  		if (irq)
>  			dev_kfree_skb_irq (skb);
> @@ -893,7 +893,7 @@ receive_packet (struct net_device *dev)
>  			/* Small skbuffs for short packets */
>  			if (pkt_len > copy_thresh) {
>  				pci_unmap_single (np->pdev,
> -						  desc->fraginfo & 0xffffffffffff,
> +						  desc->fraginfo & 0xffffffffffffULL,
>  						  np->rx_buf_sz,
>  						  PCI_DMA_FROMDEVICE);
>  				skb_put (skb = np->rx_skbuff[entry], pkt_len);
> @@ -901,7 +901,7 @@ receive_packet (struct net_device *dev)
>  			} else if ((skb = dev_alloc_skb (pkt_len + 2)) != NULL) {
>  				pci_dma_sync_single_for_cpu(np->pdev,
>  				  			    desc->fraginfo & 
> -							    	0xffffffffffff,
> +							    	0xffffffffffffULL,
>  							    np->rx_buf_sz,
>  							    PCI_DMA_FROMDEVICE);
>  				skb->dev = dev;
> @@ -913,7 +913,7 @@ receive_packet (struct net_device *dev)
>  				skb_put (skb, pkt_len);
>  				pci_dma_sync_single_for_device(np->pdev,
>  				  			       desc->fraginfo &
> -							       	 0xffffffffffff,
> +							       	 0xffffffffffffULL,
>  							       np->rx_buf_sz,
>  							       PCI_DMA_FROMDEVICE);
>  			}
> @@ -1800,7 +1800,7 @@ rio_close (struct net_device *dev)
>  		skb = np->rx_skbuff[i];
>  		if (skb) {
>  			pci_unmap_single(np->pdev, 
> -					 np->rx_ring[i].fraginfo & 0xffffffffffff,
> +					 np->rx_ring[i].fraginfo & 0xffffffffffffULL,
>  					 skb->len, PCI_DMA_FROMDEVICE);
>  			dev_kfree_skb (skb);
>  			np->rx_skbuff[i] = NULL;
> @@ -1810,7 +1810,7 @@ rio_close (struct net_device *dev)
>  		skb = np->tx_skbuff[i];
>  		if (skb) {
>  			pci_unmap_single(np->pdev, 
> -					 np->tx_ring[i].fraginfo & 0xffffffffffff,
> +					 np->tx_ring[i].fraginfo & 0xffffffffffffULL,
>  					 skb->len, PCI_DMA_TODEVICE);
>  			dev_kfree_skb (skb);
>  			np->tx_skbuff[i] = NULL;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
