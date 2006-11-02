Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752611AbWKBAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbWKBAUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbWKBAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:20:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:50450 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1752611AbWKBAUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:20:12 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,379,1157353200"; 
   d="scan'208"; a="10473408:sNHT19440180"
Message-ID: <454939BB.3060607@intel.com>
Date: Wed, 01 Nov 2006 16:20:11 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH 2/2]: Use newly defined PCI channel offline routine
References: <20061101235417.GV6360@austin.ibm.com> <20061102000035.GW6360@austin.ibm.com>
In-Reply-To: <20061102000035.GW6360@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 00:20:12.0067 (UTC) FILETIME=[A959BF30:01C6FE14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Subject: [PATCH 2/2]: Use newly defined PCI channel offline routine
> 
> Use newly minted routine to access the PCI channel state.


why not write this so that it reads:

 > +	if (pci_channel_offline(pdev))

iow are we assuming that there are multiple error_state's per pdev? That seems bogus.

Auke


> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> ----
>  drivers/net/e1000/e1000_main.c |    2 +-
>  drivers/net/ixgb/ixgb_main.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.19-rc4-git3.orig/drivers/net/e1000/e1000_main.c	2006-11-01 16:15:24.000000000 -0600
> +++ linux-2.6.19-rc4-git3/drivers/net/e1000/e1000_main.c	2006-11-01 16:20:55.000000000 -0600
> @@ -3297,7 +3297,7 @@ e1000_update_stats(struct e1000_adapter 
>  	 */
>  	if (adapter->link_speed == 0)
>  		return;
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev->error_state))
>  		return;
>  
>  	spin_lock_irqsave(&adapter->stats_lock, flags);
> Index: linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c
> ===================================================================
> --- linux-2.6.19-rc4-git3.orig/drivers/net/ixgb/ixgb_main.c	2006-11-01 16:15:25.000000000 -0600
> +++ linux-2.6.19-rc4-git3/drivers/net/ixgb/ixgb_main.c	2006-11-01 16:20:55.000000000 -0600
> @@ -1564,7 +1564,7 @@ ixgb_update_stats(struct ixgb_adapter *a
>  	struct pci_dev *pdev = adapter->pdev;
>  
>  	/* Prevent stats update while adapter is being reset */
> -	if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
> +	if (pci_channel_offline(pdev->error_state))
>  		return;
>  
>  	if((netdev->flags & IFF_PROMISC) || (netdev->flags & IFF_ALLMULTI) ||
