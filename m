Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWEEXc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWEEXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWEEXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 19:32:28 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:22805 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751225AbWEEXc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 19:32:27 -0400
Message-ID: <445BE14D.8000706@sw.ru>
Date: Sat, 06 May 2006 03:35:41 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_mbox: garbage in file
References: <890BF3111FB9484E9526987D912B261901BD42@NAMAIL3.ad.lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD42@NAMAIL3.ad.lsil.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote:
> Can you do one quick change in the driver?
> Search for 'pci_set_dma_mask()' API calls in the driver and mask out one of them with DMA_64BIT_MASK as follow.
> ---
> 	// if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
> 
> 	// 	conlog(CL_ANN, (KERN_WARNING
> 	// 		"megaraid: could not set DMA mask for 64-bit.\n"));
> 
> 	// 	goto out_free_sysfs_res;
> 	// }
> ---
> 
> I found that the driver is NOT checking 64-bit DMA capability of the controllers accordingly and this could be a reason.

This change help me:
megaraid mailbox: status:0x0 cmd:0xa7 id:0x1f sec:0x1a lba:0x33f624ac
addr:0xffffffff ld:128 sg:4
scsi cmnd: 0x28 0x00 0x33 0xf6 0x24 0xac 0x00 0x00 0x1a 0x00
mbox request_buffer ebeb9380 use_sg 4
mbox sg0: page 050c5d88 off 0 addr e90d2000 len 4096 virt eb0d2000
		 first 732e646c page->flags 20000000
mbox sg1: page 050c5710 off 0 addr e90a4000 len 4096 virt eb0a4000
		 first 00000003 page->flags 20000000
mbox sg2: page 050c4438 off 0 addr e901e000 len 4096 virt eb01e000
		 first 00000000 page->flags 20000000
mbox sg3: page 030d64dc off 1024 addr 5f3f400 len 1024 virt 07f3f400
		 first 19398a0e page->flags 20001004

Errors go away, file content is correct.

> I'm waiting for feedback from F/W team for MegaRAID 150-4 controller if it supports 64-bit DMA.
> 
> I'll update here as I get.

How do you this, can it be the cause of
http://bugzilla.kernel.org/show_bug.cgi?id=6052

If so, you have a good chance to resolve this bug too :)

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team
