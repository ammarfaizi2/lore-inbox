Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUBJQXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUBJQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:23:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:54735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265948AbUBJQXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:23:06 -0500
Date: Tue, 10 Feb 2004 08:23:00 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Message-ID: <20040210162259.GA26620@kroah.com>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be> <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be> <20040210145558.A4684@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210145558.A4684@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:55:58PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 10, 2004 at 03:32:47PM +0100, Geert Uytterhoeven wrote:
> > This patch seems to fix the problem (all offending platforms include
> > <asm/generic.h> if CONFIG_PCI only):
> 
> Umm, no the whole point of the dmapool is that it's not pci-dependent.
> Just fix your arch to have proper stub dma_ routines.  There were at
> least two headsups during 2.5 and 2.6-test that this will be required.

Exactly.  Why is your arch including a header file that you can't build?

How about dropping this into your arch if you can't use the
include/asm-generic/dma-mapping.h file.  Or I can add it as
include/asm-generic/dma-mapping-broken.h and you can repoint your arch
to use it.  Which would be easier for you?

thanks,

greg k-h


-----


/* This is used for archs that do not support dma */

#ifndef _ASM_DMA_MAPPING_H
#define _ASM_DMA_MAPPING_H

static inline int
dma_supported(struct device *dev, u64 mask)
{
	BUG();
}

static inline int
dma_set_mask(struct device *dev, u64 dma_mask)
{
	BUG();
}

static inline void *
dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
		   int flag)
{
	BUG();
}

static inline void
dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
		    dma_addr_t dma_handle)
{
	BUG();
}

static inline dma_addr_t
dma_map_single(struct device *dev, void *cpu_addr, size_t size,
	       enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
		 enum dma_data_direction direction)
{
	BUG();
}

static inline dma_addr_t
dma_map_page(struct device *dev, struct page *page,
	     unsigned long offset, size_t size,
	     enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
	       enum dma_data_direction direction)
{
	BUG();
}

static inline int
dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
	   enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
	     enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
		enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
	    enum dma_data_direction direction)
{
	BUG();
}

#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
#define dma_is_consistent(d)	(1)

static inline int
dma_get_cache_alignment(void)
{
	BUG();
}

static inline void
dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
		      unsigned long offset, size_t size,
		      enum dma_data_direction direction)
{
	BUG();
}

static inline void
dma_cache_sync(void *vaddr, size_t size,
	       enum dma_data_direction direction)
{
	BUG();
}

#endif

