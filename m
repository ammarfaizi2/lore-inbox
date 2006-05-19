Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWESV2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWESV2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 17:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWESV2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 17:28:49 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:58326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964849AbWESV2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 17:28:48 -0400
Subject: Re: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMA
	capability check
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: Vasily Averin <vvs@sw.ru>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD91@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261901BD91@NAMAIL3.ad.lsil.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 16:28:00 -0500
Message-Id: <1148074080.3410.105.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 09:09 -0600, Ju, Seokmann wrote:

> +		adapter->pdev->device == PCI_DEVICE_ID_LINDSAY)) {
> +		if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) !=
> 0) {
> +			con_log(CL_ANN, (KERN_WARNING
> +				"megaraid: could not set DMA mask for
> 64-bit.\n"));
>  
> -		goto out_free_sysfs_res;

Well, this really isn't quite right.  There are 32 bit platforms which
will refuse a 64 bit DMA mask on principle.  You need to retry with a 32
bit mask before erroring out, exactly like you've done in megaraid_sas.c

Also, it's a bit strange having a 32 bit mask set initially in probe_one
and then being reset in init_mbox.  Why not just consolidate all the PCI
register testing and mask setting in probe_one?

James


