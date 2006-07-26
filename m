Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWGZOWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWGZOWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWGZOWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:22:52 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:6025 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750737AbWGZOWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:22:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] CCISS: Don't print driver version until we actually find a device
Date: Wed, 26 Jul 2006 09:22:14 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE553882D2@cceexc23.americas.cpqcorp.net>
In-Reply-To: <200607251636.42765.bjorn.helgaas@hp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] CCISS: Don't print driver version until we actually find a device
Thread-Index: AcawOtC0bFBGX4zLRluvtRN3Yw8cHwAg/FDQ
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "ISS StorageDev" <iss_storagedev@hp.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2006 14:22:15.0930 (UTC) FILETIME=[E5062DA0:01C6B0BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Helgaas, Bjorn 
> Sent: Tuesday, July 25, 2006 5:37 PM
> To: Andrew Morton
> Cc: Miller, Mike (OS Dev); ISS StorageDev; 
> linux-kernel@vger.kernel.org
> Subject: [PATCH] CCISS: Don't print driver version until we 
> actually find a device
> 
> If we don't find any devices, we shouldn't print anything.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> Index: work-mm2/drivers/block/cciss.c
> ===================================================================
> --- work-mm2.orig/drivers/block/cciss.c	2006-07-20 
> 16:27:34.000000000 -0600
> +++ work-mm2/drivers/block/cciss.c	2006-07-25 
> 16:16:27.000000000 -0600
> @@ -3109,12 +3109,16 @@
>  static int __devinit cciss_init_one(struct pci_dev *pdev,
>  				    const struct pci_device_id *ent)  {
> +	static int cciss_version_printed = 0;
>  	request_queue_t *q;
>  	int i;
>  	int j;
>  	int rc;
>  	int dac;
>  
> +	if (cciss_version_printed++ == 0)
> +		printk(KERN_INFO DRIVER_NAME "\n");
> +
>  	i = alloc_cciss_hba();
>  	if (i < 0)
>  		return -1;
> @@ -3370,9 +3374,6 @@
>   */
>  static int __init cciss_init(void)
>  {
> -	printk(KERN_INFO DRIVER_NAME "\n");
> -
> -	/* Register for our PCI devices */
>  	return pci_register_driver(&cciss_pci_driver);
>  }
>  
> 
