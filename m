Return-Path: <linux-kernel-owner+w=401wt.eu-S932374AbWLLV14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWLLV14 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWLLV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:27:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:17476 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932374AbWLLV1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:27:55 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,526,1157353200"; 
   d="scan'208"; a="173632171:sNHT46938563"
Message-ID: <457F1EBF.2020901@intel.com>
Date: Tue, 12 Dec 2006 13:27:27 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: gregkh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, jesse.brandeburg@intel.com
Subject: Re: [PATCH 2/2]: Use newly defined PCI channel offline routine
References: <20061212195524.GG4329@austin.ibm.com> <20061212200151.GH4329@austin.ibm.com>
In-Reply-To: <20061212200151.GH4329@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Use newly minted routine to access the PCI channel state.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

ACK, thanks Linas.

If it doesn't get picked up I can stack it on my queue for netdev later.

Auke


> 
> ----
>  drivers/net/e1000/e1000_main.c |    2 +-
>  drivers/net/ixgb/ixgb_main.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.19-git7/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.19-git7.orig/drivers/net/e1000/e1000_main.c	2006-12-05 17:11:01.000000000 -0600
> +++ linux-2.6.19-git7/drivers/net/e1000/e1000_main.c	2006-12-05 17:13:31.000000000 -0600
> @@ -3449,7 +3449,7 @@ e1000_update_stats(struct e1000_adapter 
>  	 */
>  	if (adapter->link_speed == 0)
>  		return;
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev))
>  		return;
>  
>  	spin_lock_irqsave(&adapter->stats_lock, flags);
> Index: linux-2.6.19-git7/drivers/net/ixgb/ixgb_main.c
> ===================================================================
> --- linux-2.6.19-git7.orig/drivers/net/ixgb/ixgb_main.c	2006-12-05 17:11:01.000000000 -0600
> +++ linux-2.6.19-git7/drivers/net/ixgb/ixgb_main.c	2006-12-05 17:13:31.000000000 -0600
> @@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
>  	struct pci_dev *pdev = adapter->pdev;
>  
>  	/* Prevent stats update while adapter is being reset */
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev))
>  		return;
>  
>  	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
