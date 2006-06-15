Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWFOOhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWFOOhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWFOOhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:37:33 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:38844 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030444AbWFOOhc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:37:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/7] CCISS: announce cciss%d devices with PCI address/IRQ/DAC info
Date: Thu, 15 Jun 2006 09:37:30 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10C5249D2@cceexc23.americas.cpqcorp.net>
In-Reply-To: <200606141710.12182.bjorn.helgaas@hp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/7] CCISS: announce cciss%d devices with PCI address/IRQ/DAC info
Thread-Index: AcaQB7sCe75Sw4B5SEK/YOGSkwJseQAgW8pg
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 15 Jun 2006 14:37:31.0750 (UTC) FILETIME=[3BF57860:01C69089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Helgaas, Bjorn 
> Sent: Wednesday, June 14, 2006 6:10 PM
> To: Miller, Mike (OS Dev)
> Cc: ISS StorageDev; linux-kernel@vger.kernel.org; Andrew Morton
> Subject: [PATCH 3/7] CCISS: announce cciss%d devices with PCI 
> address/IRQ/DAC info
> 
> We already print "cciss: using DAC cycles" or similar for 
> every adapter found: why not just identify the device we're 
> talking about and include other useful information?
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> Index: rc6-mm2/drivers/block/cciss.c
> ===================================================================
> --- rc6-mm2.orig/drivers/block/cciss.c	2006-06-14 
> 16:18:20.000000000 -0600
> +++ rc6-mm2/drivers/block/cciss.c	2006-06-14 
> 16:18:29.000000000 -0600
> @@ -3086,11 +3086,8 @@
>  	int i;
>  	int j;
>  	int rc;
> +	int dac;
>  
> -	printk(KERN_DEBUG "cciss: Device 0x%x has been found at"
> -			" bus %d dev %d func %d\n",
> -		pdev->device, pdev->bus->number, PCI_SLOT(pdev->devfn),
> -			PCI_FUNC(pdev->devfn));
>  	i = alloc_cciss_hba();
>  	if(i < 0)
>  		return (-1);
> @@ -3106,11 +3103,11 @@
>  
>  	/* configure PCI DMA stuff */
>  	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK))
> -		printk("cciss: using DAC cycles\n");
> +		dac = 1;
>  	else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK))
> -		printk("cciss: not using DAC cycles\n");
> +		dac = 0;
>  	else {
> -		printk("cciss: no suitable DMA available\n");
> +		printk(KERN_ERR "cciss: no suitable DMA available\n");
>  		goto clean1;
>  	}
>  
> @@ -3141,6 +3138,11 @@
>  			hba[i]->intr[SIMPLE_MODE_INT], hba[i]->devname);
>  		goto clean2;
>  	}
> +
> +	printk(KERN_INFO "%s: <0x%x> at PCI %s IRQ %d%s using DAC\n",
> +		hba[i]->devname, pdev->device, pci_name(pdev),
> +		hba[i]->intr[SIMPLE_MODE_INT], dac ? "" : " not");
> +
>  	hba[i]->cmd_pool_bits = 
> kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsig
> ned long), GFP_KERNEL);
>  	hba[i]->cmd_pool = (CommandList_struct *)pci_alloc_consistent(
>  		hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct), 
> 
