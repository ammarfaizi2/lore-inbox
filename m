Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWGMFrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWGMFrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWGMFrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:47:04 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:18953 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751432AbWGMFrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:47:02 -0400
Date: Thu, 13 Jul 2006 08:46:58 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Suggestions for how to remove bus_to_virt()
Message-ID: <20060713054658.GC5096@rhun.ibm.com>
References: <1152746967.4572.263.camel@brick.pathscale.com> <adar70quzwx.fsf@cisco.com> <20060712.174013.95062313.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712.174013.95062313.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 05:40:13PM -0700, David Miller wrote:
> From: Roland Dreier <rdreier@cisco.com>
> Date: Wed, 12 Jul 2006 17:11:26 -0700
> 
> > A cleaner solution would be to make the dma_ API really use the device
> > it's passed anyway, and allow drivers to override the standard PCI
> > stuff nicely.  But that would be major surgery, I guess.
> 
> Clean but expensive, you should not force the rest of the kernel
> to eat the cost of something you want to do when it's totally
> unnecessary for most other users.
> 
> For example, x86 never needs to do anything other than a direct
> virt_to_phys translation to produce a DMA address, no matter what
> bus the device is on.  It's a single simple integer adjustment
> that can be done inline in about 2 or 3 instructions at most.

It's possible that even x86 will support multiple IOMMUs in the future
- for example, the Calgary IOMMU support we recently added to x86-64
could be modified to work on plain x86 as well.

I like the idea of a per-device DMA-API implementation, but only if it
can be done in a way that is zero cost to the majority of the users of
the API. We already have dynamic dma_ops on x86-64 to support nommu,
swiotlb, gart and Calgary cleanly, extending it to use a per-device
dma-ops isn't too difficult.

Cheers,
Muli
