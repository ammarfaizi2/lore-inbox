Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbUBLJwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 04:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUBLJwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 04:52:24 -0500
Received: from witte.sonytel.be ([80.88.33.193]:15797 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266077AbUBLJwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 04:52:19 -0500
Date: Thu, 12 Feb 2004 10:52:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Greg Kroah-Hartman <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
In-Reply-To: <20040210101437.1507af3b.davem@redhat.com>
Message-ID: <Pine.GSO.4.58.0402121048550.7297@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
 <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be> <20040210145558.A4684@infradead.org>
 <20040210162259.GA26620@kroah.com> <Pine.GSO.4.58.0402101727130.2261@waterleaf.sonytel.be>
 <20040210101437.1507af3b.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, David S. Miller wrote:
> On Tue, 10 Feb 2004 17:29:15 +0100 (MET)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Let's see what the sparc guys have to comment...
>
> I think we'll just add the necessary stubs, it's not unreasonable.

So here's a patch for m68k, based on Greg's stubs. I only added a few
`return 0;' statements to kill compiler warnings. It increased kernel size by a
bit less than 0.5 KiB.

Feel free to move the stubs to asm-generic/no-dma-mapping.h, if there are
enough users to warrant that.

--- linux-2.6.3-rc2/include/asm-m68k/dma-mapping.h	2003-07-29 18:19:20.000000000 +0200
+++ linux-m68k-2.6.3-rc2/include/asm-m68k/dma-mapping.h	2004-02-12 10:21:29.000000000 +0100
@@ -5,6 +5,123 @@

 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#else
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	BUG();
+	return 0;
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	BUG();
+	return 0;
+}
+
+static inline void *
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		   int flag)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	BUG();
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size,
+	     enum dma_data_direction direction)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_single(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_sg(struct device *dev, struct scatterlist *sg, int nelems,
+	    enum dma_data_direction direction)
+{
+	BUG();
+}
+
+#define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
+#define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+#define dma_is_consistent(d)	(1)
+
+static inline int
+dma_get_cache_alignment(void)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_sync_single_range(struct device *dev, dma_addr_t dma_handle,
+		      unsigned long offset, size_t size,
+		      enum dma_data_direction direction)
+{
+	BUG();
+}
+
+static inline void
+dma_cache_sync(void *vaddr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG();
+}
+
 #endif

 #endif  /* _M68K_DMA_MAPPING_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
