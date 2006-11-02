Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752542AbWKBFOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbWKBFOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbWKBFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:14:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:5729 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1752542AbWKBFOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:14:04 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,379,1157353200"; 
   d="scan'208"; a="154680986:sNHT20900712"
Message-ID: <45497E90.5030005@intel.com>
Date: Wed, 01 Nov 2006 21:13:52 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>, gregkh@suse.de
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH 2/2 v2]: Use newly defined PCI channel offline routine
References: <20061101235417.GV6360@austin.ibm.com> <20061102000035.GW6360@austin.ibm.com> <20061102011044.GB3623@austin.ibm.com>
In-Reply-To: <20061102011044.GB3623@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Wed, Nov 01, 2006 at 06:00:35PM -0600, Linas Vepstas wrote:
> [...]
> Resubmit, per Auke ...

This I'll ACK :)

Cheers,

Auke


> 
> --linas
> 
> Use newly minted routine to access the PCI channel state.
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>

Acked-by: Auke Kok <auke-jan.h.kok@intel.com>

> ----
>  drivers/net/e1000/e1000_main.c |    2 +-
>  drivers/net/ixgb/ixgb_main.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.19-rc4-git3.orig/drivers/net/e1000/e1000_main.c	2006-11-01 18:40:48.000000000 -0600
> +++ linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c	2006-11-01 18:44:11.000000000 -0600
> @@ -3297,7 +3297,7 @@ e1000_update_stats(struct e1000_adapter 
>  	 */
>  	if (adapter->link_speed == 0)
>  		return;
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev))
>  		return;
>  
>  	spin_lock_irqsave(&adapter->stats_lock, flags);
> Index: linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c
> ===================================================================
> --- linux-2.6.19-rc4-git3.orig/drivers/net/ixgb/ixgb_main.c	2006-11-01 18:40:48.000000000 -0600
> +++ linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c	2006-11-01 18:44:39.000000000 -0600
> @@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
>  	struct pci_dev *pdev = adapter->pdev;
>  
>  	/* Prevent stats update while adapter is being reset */
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev))
>  		return;
>  
>  	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
