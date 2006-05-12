Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWELEPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWELEPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 00:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWELEPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 00:15:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:16772 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750904AbWELEPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 00:15:35 -0400
Message-ID: <44640C98.3070006@sw.ru>
Date: Fri, 12 May 2006 08:18:32 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Vasily Averin <vvs@sw.ru>
CC: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_mbox: garbage in file
References: <890BF3111FB9484E9526987D912B261901BD42@NAMAIL3.ad.lsil.com> <445BE14D.8000706@sw.ru>
In-Reply-To: <445BE14D.8000706@sw.ru>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> Ju, Seokmann wrote:
>>I'm waiting for feedback from F/W team for MegaRAID 150-4 controller if it supports 64-bit DMA.
>>
>>I'll update here as I get.

Could you please tell me any updates? Could you confirm that this issue was
reproduced on your nodes?

>>Can you do one quick change in the driver?
>>Search for 'pci_set_dma_mask()' API calls in the driver and mask out one of them with DMA_64BIT_MASK as follow.
>>---
>>	// if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
>>
>>	// 	conlog(CL_ANN, (KERN_WARNING
>>	// 		"megaraid: could not set DMA mask for 64-bit.\n"));
>>
>>	// 	goto out_free_sysfs_res;
>>	// }
>>---
>>
>>I found that the driver is NOT checking 64-bit DMA capability of the controllers accordingly and this could be a reason.
> 
> This change help me:
> Errors go away, file content is correct.

I'm going to use this change in production, at least as temporal workaround.
Could you please confirm that it is safe for all controllers supported by this
driver?

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team
