Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTGAT5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTGAT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:57:42 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:64007 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263628AbTGAT5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:57:33 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Alex Williamson <alex_williamson@hp.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jens Axboe <axboe@suse.de>,
       ak@suse.de, davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
In-Reply-To: <3F01E81E.813FCDAC@hp.com>
References: <1057077975.2135.54.camel@mulgrave>
	<20030701191941.GF14683@dsl2.external.hp.com>  <3F01E81E.813FCDAC@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2003 15:11:16 -0500
Message-Id: <1057090278.1775.117.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 14:59, Alex Williamson wrote:
>    The thing that's got me concerned about this is that it allows
> for sg lists that contains both entries that the block layer
> expects will be mapped into the iommu and ones that it expects
> to bypass.  I don't like the implications of parsing through
> sg lists looking for bypass-able and non-bypass-able groupings.
> This seems like a lot more overhead than we have now and the
> complexity of merging partially bypass-able scatterlists seems
> time consuming.
> 
>    The current ia64 sba_iommu does a quick and dirty sg bypass
> check.  If the device can dma to any memory address, the entire
> sg list is bypassed.  If not, the entire list is coalesced and
> mapped by the iommu.  The idea being that true performance
> devices will have 64bit dma masks and be able to quickly bypass.
> Everything else will at least get the benefit of coalescing
> entries to make more efficient dma.  The coalescing is a bit
> simpler since it's the entire list as well.  With this proposal,
> we'd have to add a lot of complexity to partially bypass sg
> lists.  I don't necessarily see that as a benefit.  Thanks,

But if that's all you want, you simply set the BIO_VMERGE_BYPASS_MASK to
the full u64 set bitmask.  Then it will only turn off virtual merging
for devices that have a fully set dma_mask, and your simple test will
work.

James


