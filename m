Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWJPMca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWJPMca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWJPMca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:32:30 -0400
Received: from mail0.lsil.com ([147.145.40.20]:7635 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1422675AbWJPMc3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:32:29 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMA capability fix
Date: Mon, 16 Oct 2006 06:32:14 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E3E4@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMA capability fix
Thread-Index: Acbw+lh/J3WJ4k6ySNOGFcX5GQBhZwAIteog
From: "Ju, Seokmann" <Seokmann.Ju@lsi.com>
To: "Vasily Averin" <vvs@sw.ru>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <devel@openvz.org>
Cc: "Andrey Mirkin" <amirkin@sw.ru>
X-OriginalArrivalTime: 16 Oct 2006 12:32:15.0697 (UTC) FILETIME=[1CDA0C10:01C6F11F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Monday, October 16, 2006 4:09 AM, Vasily Averin wrote:
> It is known that 2 LSI Logic MegaRAID SATA RAID Controllers 
> (150-4 and 150-6)
> don't support 64-bit DMA. Unfortunately currently this check 
> is wrong and driver
>  sets 64-bit DMA mode for these devices.
ACK - this patch will fix the problem.
Thank you for the finding, Vasily.

Seokmann

> -----Original Message-----
> From: Vasily Averin [mailto:vvs@sw.ru] 
> Sent: Monday, October 16, 2006 4:09 AM
> To: Linux Kernel Mailing List; linux-scsi@vger.kernel.org; 
> Ju, Seokmann; James Bottomley; Andrew Morton; Linus Torvalds; 
> devel@openvz.org
> Cc: Andrey Mirkin
> Subject: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit 
> DMA capability fix
> 
> From: Andrey Mirkin (amirkin@sw.ru)
> 
> It is known that 2 LSI Logic MegaRAID SATA RAID Controllers 
> (150-4 and 150-6)
> don't support 64-bit DMA. Unfortunately currently this check 
> is wrong and driver
>  sets 64-bit DMA mode for these devices.
> 
> Signed-off-by:	Andrey Mirkin <amirkin@sw.ru>
> Ack-by:		Vasily Averin <vvs@sw.ru>
> 
> --- 
> linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c.mgst6	
> 2006-10-16
> 10:26:50.000000000 +0400
> +++ linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c	
> 2006-10-16
> 11:30:55.000000000 +0400
> @@ -884,7 +884,7 @@ megaraid_init_mbox(adapter_t *adapter)
> 
>  	if (((magic64 == HBA_SIGNATURE_64_BIT) &&
>  		((adapter->pdev->subsystem_device !=
> -		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) ||
> +		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) &&
>  		(adapter->pdev->subsystem_device !=
>  		PCI_SUBSYS_ID_MEGARAID_SATA_150_4))) ||
>  		(adapter->pdev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
> 
> 
