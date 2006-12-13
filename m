Return-Path: <linux-kernel-owner+w=401wt.eu-S1750732AbWLMUbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWLMUbJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLMUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:31:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38705 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbWLMUbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:31:08 -0500
Date: Wed, 13 Dec 2006 12:30:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ralph Campbell <ralph.campbell@qlogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: IB: Add DMA mapping functions to allow device drivers to
 interpose
Message-Id: <20061213123043.9de95cc4.akpm@osdl.org>
In-Reply-To: <1166040687.14800.384.camel@brick.pathscale.com>
References: <200612130359.kBD3xjWp028210@hera.kernel.org>
	<20061212234720.700f3cea.akpm@osdl.org>
	<1166040687.14800.384.camel@brick.pathscale.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 12:11:27 -0800
Ralph Campbell <ralph.campbell@qlogic.com> wrote:

> > I'd have picked this up if it had been in git-infiniband for even a couple
> > of days.  I'm assuming this all got slammed into mainline because of the
> > merge window thing.
> > 
> > I cannot find these patches on the kernel mailing list.  I cannot find the
> > pull request anywhere.
> > 
> > > +static inline u64 ib_dma_map_single(struct ib_device *dev,
> > > +				    void *cpu_addr, size_t size,
> > > +				    enum dma_data_direction direction)
> > 
> > no, dma_map_single() returns a dma_addr_t.
> 
> ib_dma_map_single() allows the ib_ipath device driver to interpose
> on IOMMU allocations and not do them by returning the kernel
> virtual address as the "DMA address".  I started with dma_addr_t
> but it was pointed out to me that sparc64 defines dma_addr_t
> as u32. This would cause addresses to be truncated.
> Also, I chose u64 because the return value from ib_dma_*() is
> stored in the ib_sge.addr field which is u64.
> 
> My preference would be to change the offending uses of dma_addr_t
> to u64.  Do you have a better solution?

We should be able to use dma_addr_t for this?  Is it not the case that the
values we're dealing with here _are_ DMA addresses?  I think a more complete
description of the problem we're trying to solve here would help.

I'm not sure what the problem is with sparc64 - perhaps its dma_addr_t
really is a "cookie" and isn't a physical bus address?  But you want a value
which is really a physical bus address?  Dunno.

Perhaps dma64_addr_t can be used here.
