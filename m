Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbTFFGmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbTFFGmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:42:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265360AbTFFGmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:42:53 -0400
Date: Thu, 05 Jun 2003 23:52:49 -0700 (PDT)
Message-Id: <20030605.235249.35666087.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16096.14281.621282.67906@napali.hpl.hp.com>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
	<1054797653.18294.1.camel@rth.ninka.net>
	<16096.14281.621282.67906@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, ide-lib.c can call blk_queue_bounce_limit with only
3 different args:

1) BLK_BOUNCE_HIGH (--> blk_max_pfn)
2) BLK_BOUNCE_ANY (--> blk_max_lo_pfn)
3) pci_dev->dma_mask

David, you're not setting PCI_DMA_BUS_IS_PHYS properly.
For IOMMU it should be set to zero.  This tells the block
layer if you're IOMMU or not.

I knew it would be a bug like this.

Anyways, the problem case is #3 above and that will never
happen if you start setting PCI_DMA_BUS_IS_PHYS to zero
as appropriate.
