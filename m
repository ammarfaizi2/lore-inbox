Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWELMUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWELMUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWELMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:20:36 -0400
Received: from mail0.lsil.com ([147.145.40.20]:12517 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751180AbWELMUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:20:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: megaraid_mbox: garbage in file
Date: Fri, 12 May 2006 06:19:48 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD6E@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: megaraid_mbox: garbage in file
Thread-Index: AcZ1euT/4ggdUCFiQ/OnMNDjh3k18wAQyi3A
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Vasily Averin" <vvs@sw.ru>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       <linux-scsi@vger.kernel.org>, "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       <devel@openvz.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2006 12:19:49.0337 (UTC) FILETIME=[5D21CC90:01C675BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Friday, May 12, 2006 12:19 AM, Vasily Averin wrote:
> Could you please tell me any updates? Could you confirm that 
> this issue was
> reproduced on your nodes?
Yes, it has confirmed by F/W team that the controller doesn't support 64-bit DMA.
A patch addresses the issue will followed by soon.

Thank you,

> -----Original Message-----
> From: Vasily Averin [mailto:vvs@sw.ru] 
> Sent: Friday, May 12, 2006 12:19 AM
> To: Vasily Averin
> Cc: Ju, Seokmann; James Bottomley; 
> linux-scsi@vger.kernel.org; Kolli, Neela; Mukker, Atul; 
> Bagalkote, Sreenivas; devel@openvz.org; Linux Kernel Mailing List
> Subject: Re: megaraid_mbox: garbage in file
> 
> Vasily Averin wrote:
> > Ju, Seokmann wrote:
> >>I'm waiting for feedback from F/W team for MegaRAID 150-4 
> controller if it supports 64-bit DMA.
> >>
> >>I'll update here as I get.
> 
> Could you please tell me any updates? Could you confirm that 
> this issue was
> reproduced on your nodes?
> 
> >>Can you do one quick change in the driver?
> >>Search for 'pci_set_dma_mask()' API calls in the driver and 
> mask out one of them with DMA_64BIT_MASK as follow.
> >>---
> >>	// if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
> >>
> >>	// 	conlog(CL_ANN, (KERN_WARNING
> >>	// 		"megaraid: could not set DMA mask for 
> 64-bit.\n"));
> >>
> >>	// 	goto out_free_sysfs_res;
> >>	// }
> >>---
> >>
> >>I found that the driver is NOT checking 64-bit DMA 
> capability of the controllers accordingly and this could be a reason.
> > 
> > This change help me:
> > Errors go away, file content is correct.
> 
> I'm going to use this change in production, at least as 
> temporal workaround.
> Could you please confirm that it is safe for all controllers 
> supported by this
> driver?
> 
> Thank you,
> 	Vasily Averin
> 
> SWsoft Virtuozzo/OpenVZ Linux kernel team
> 
