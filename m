Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWJQU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWJQU6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWJQU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:58:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:60693 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750824AbWJQU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:58:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,321,1157353200"; 
   d="scan'208"; a="146518166:sNHT165103204"
Message-ID: <45354398.1000100@intel.com>
Date: Tue, 17 Oct 2006 13:56:56 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>, linuxppc-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000: Reset all functions after a PCI error
References: <20061017204206.GG6537@austin.ibm.com>
In-Reply-To: <20061017204206.GG6537@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2006 20:58:49.0230 (UTC) FILETIME=[0B38E2E0:01C6F22F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Please apply and forward upstream.

ACK

Jeff, please apply on top of today's fixes.

Auke


> --linas
> 
> During the handling of the PCI error recovery sequence,
> the current e1000 driver erroneously blocks a device reset
> for any but the first PCI function. It shouldn't -- this 
> is a cut-n-paste error from a different driver (which
> tolerated only one hardware reset per hardware card). 
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Auke Kok <auke-jan.h.kok@intel.com>
> 
> ----
>  drivers/net/e1000/e1000_main.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/drivers/net/e1000/e1000_main.c	2006-10-17 15:02:25.000000000 -0500
> +++ linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c	2006-10-17 15:03:35.000000000 -0500
> @@ -4914,10 +4914,6 @@ static pci_ers_result_t e1000_io_slot_re
>  	pci_enable_wake(pdev, PCI_D3hot, 0);
>  	pci_enable_wake(pdev, PCI_D3cold, 0);
>  
> -	/* Perform card reset only on one instance of the card */
> -	if (PCI_FUNC (pdev->devfn) != 0)
> -		return PCI_ERS_RESULT_RECOVERED;
> -
>  	e1000_reset(adapter);
>  	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
>  
