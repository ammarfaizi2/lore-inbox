Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUBTMxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUBTMxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:53:02 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22877 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261200AbUBTMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:39 -0500
Date: Fri, 20 Feb 2004 13:48:24 +0100
Message-Id: <200402201248.i1KCmO2r004323@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 414] Dummy dma mapping
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy <asm-generic/dma-mapping-broken.h> for systems that don't support
the new DMA API, and make m68k use it if !CONFIG_PCI

--- /dev/null	2004-02-08 10:50:36.000000000 +0100
+++ linux-m68k-2.6.3/include/asm-generic/dma-mapping-broken.h	2004-02-19 21:15:19.000000000 +0100
@@ -0,0 +1,22 @@
+#ifndef _ASM_GENERIC_DMA_MAPPING_H
+#define _ASM_GENERIC_DMA_MAPPING_H
+
+/* This is used for archs that do not support DMA */
+
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
+#endif /* _ASM_GENERIC_DMA_MAPPING_H */
--- linux-2.6.3/include/asm-m68k/dma-mapping.h	2003-07-29 18:19:20.000000000 +0200
+++ linux-m68k-2.6.3/include/asm-m68k/dma-mapping.h	2004-02-13 16:14:30.000000000 +0100
@@ -5,6 +5,8 @@
 
 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#else
+#include <asm-generic/dma-mapping-broken.h>
 #endif
 
 #endif  /* _M68K_DMA_MAPPING_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
