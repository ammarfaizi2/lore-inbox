Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317048AbSEWXZp>; Thu, 23 May 2002 19:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317049AbSEWXZn>; Thu, 23 May 2002 19:25:43 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:19336 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S317048AbSEWXZm>;
	Thu, 23 May 2002 19:25:42 -0400
Date: Thu, 23 May 2002 16:24:25 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?
Message-ID: <20020523162425.G7205@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the explanation of streaming DMA mappings and holding onto a mapping
for multiple DMA operations, the file Documentation/DMA-mapping.txt
(line 507) says the following:

	If you need to use the same streaming DMA region multiple times
	and touch the data in between the DMA transfers, just map it
	with pci_map_{single,sg}, and after each DMA transfer call
	either:

		pci_dma_sync_single(dev, dma_handle, size, direction);

	or:

		pci_dma_sync_sg(dev, sglist, nents, direction);

	as appropriate.

However, shouldn't pci_dma_sync_*() be called *before* each
PCI_DMA_TODEVICE DMA transfer (after the CPU write, of course) and
*after* each PCI_DMA_FROMDEVICE DMA transfer (before CPU access)? And,
of course, before and after a "bidirectional" DMA, if appropriate.

Thanks,
William
