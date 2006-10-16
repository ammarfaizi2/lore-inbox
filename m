Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422857AbWJPTe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbWJPTe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJPTe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:34:56 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53458 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422857AbWJPTey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:34:54 -0400
Subject: Re: [PATCH 2.6.19-rc2] scsi: megaraid_{mm,mbox}: 64-bit DMA
	capability fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Vasily Averin <vvs@sw.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       devel@openvz.org, Andrey Mirkin <amirkin@sw.ru>
In-Reply-To: <45333E0B.7000905@sw.ru>
References: <45333E0B.7000905@sw.ru>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 14:34:44 -0500
Message-Id: <1161027285.3433.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 12:08 +0400, Vasily Averin wrote:
> It is known that 2 LSI Logic MegaRAID SATA RAID Controllers (150-4 and 150-6)
> don't support 64-bit DMA. Unfortunately currently this check is wrong and driver
>  sets 64-bit DMA mode for these devices.
> 
> Signed-off-by:	Andrey Mirkin <amirkin@sw.ru>
> Ack-by:		Vasily Averin <vvs@sw.ru>
> 
> --- linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c.mgst6	2006-10-16
> 10:26:50.000000000 +0400
> +++ linux-2.6.19-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2006-10-16
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

Er ... this patch would apply in reverse, but what's in the tree
currently looks to be correct.

James


