Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKQIxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKQIxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 03:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVKQIxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 03:53:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53288 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750703AbVKQIxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 03:53:21 -0500
Date: Thu, 17 Nov 2005 09:54:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
Message-ID: <20051117085432.GY7787@suse.de>
References: <437C40AE.2020309@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437C40AE.2020309@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Pierre Ossman wrote:
> I'm writing a PCI driver for the first time and I'm trying to wrap my
> head around the DMA mappings in that world. I've done a ISA driver which
> uses DMA, but this is a bit more complex and the documentation doesn't
> explain everything.
> 
> What I'm particularly confused about is how the IOMMU should be handled
> with regard to scatterlist limits. My hardware cannot handle
> scatterlists, only a single DMA address. But from what I understand the

What kind of hardware can't handle scatter gather?

> IOMMU can be very similar to a normal "CPU" MMU. So it should be able to
> aggregate pages that are non-continuous in physical memory into one
> single block in bus memory. Now the question is what do I set
> nr_phys_segments and nr_hw_segments to? Of course the code also needs to
> handle systems without an IOMMU.

nr_hw_segments is how many segments your driver will see once dma
mapping is complete (and the IOMMU has done its tricks), so you want to
set that to 1 if the hardware can't handle an sg list.

That'll work irregardless of whether there's an IOMMU there or not. Note
that the mere existence of an IOMMU will _not_ save your performance on
this hardware, you need one with good virtual merging support to get
larger transfers.

-- 
Jens Axboe

