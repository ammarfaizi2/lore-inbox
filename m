Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVCSOQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVCSOQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 09:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVCSOQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 09:16:41 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:40255 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262477AbVCSOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 09:16:35 -0500
X-IronPort-AV: i="3.91,103,1110175200"; 
   d="scan'208"; a="237717555:sNHT23205932"
Date: Sat, 19 Mar 2005 08:16:34 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.4.30-pre3] x86_64: pci_alloc_consistent() match 2.6 implementation
Message-ID: <20050319141634.GA17045@lists.us.dell.com>
References: <20050318212344.GC26112@lists.us.dell.com> <1111212585.6291.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111212585.6291.41.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 07:09:45AM +0100, Arjan van de Ven wrote:
> On Fri, 2005-03-18 at 15:23 -0600, Matt Domsch wrote:
> > For review and comment.
> > 
> > On x86_64 systems with no IOMMU and with >4GB RAM (in fact, whenever
> > there are any pages mapped above 4GB), pci_alloc_consistent() falls
> > back to using ZONE_DMA for all allocations, even if the device's
> > dma_mask could have supported using memory from other zones.  Problems
> > can be seen when other ZONE_DMA users (SWIOTLB, scsi_malloc()) consume
> > all of ZONE_DMA, leaving none left for pci_alloc_consistent() use.
> 
> scsi_malloc no longer uses ZONE_DMA nowadays....

In 2.4.x it does.  scsi_resize_dma_pool() has:
      __get_free_pages(GFP_ATOMIC | GFP_DMA, 0);
scsi_init_minimal_dma_pool() has similar.


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
