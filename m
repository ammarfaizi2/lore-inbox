Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTGAROl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTGAROl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:14:41 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:17926 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263084AbTGAROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:14:40 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andi Kleen <ak@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
In-Reply-To: <20030701190938.2332f0a8.ak@suse.de>
References: <1057077975.2135.54.camel@mulgrave> 
	<20030701190938.2332f0a8.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2003 12:28:47 -0500
Message-Id: <1057080529.2003.62.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 12:09, Andi Kleen wrote:
> I assume on 2.5 has this problem, not 2.4, right?

Yes, sorry, I'm so focussed on 2.5 I keep forgetting 2.4.

> But a mask is not good for AMD64 because there is no guarantee 
> that the bypass/iommu address is checkable using a mask
> (K8 uses an memory hole for IOMMU purposes and for various
> reasons the hole can be anywhere in the address space)
> 
> This means x86_64 needs an function. Also the name is quite weird and 
> the issue is not really BIO  specific. How about just calling it
> iommu_address() ?

The name was simply to be consistent with BIO_VMERGE_BOUNDARY which is
another asm/io.h setting for this.

Could you elaborate more on the amd64 IOMMU window.  Is this a window
where IOMMU mapping always takes place?

I'm a bit reluctant to put a function like this in because the block
layer does a very good job of being separate from the dma layer. 
Maintaining this separation is one of the reasons I added a dma_mask to
the request_queue, not a generic device pointer.

James


