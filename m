Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbUKRWpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUKRWpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbUKRWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:43:50 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:47640 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S262948AbUKRUtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:49:40 -0500
Date: Thu, 18 Nov 2004 21:49:36 +0100
Message-Id: <200411182049.iAIKnaNJ007083@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 527] M68k I/O: Move HP300 I/O macros close to other I/O macros again
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k I/O: Move HP300 I/O macros close to other I/O macros again (after merge
error in 2.6.10-rc2)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/include/asm-m68k/io.h	2004-11-15 10:56:16.000000000 +0100
+++ linux-m68k-2.6.10-rc2/include/asm-m68k/io.h	2004-11-15 12:26:10.000000000 +0100
@@ -306,6 +306,24 @@ static inline void isa_delay(void)
 #endif
 #endif /* CONFIG_PCI */
 
+#if !defined(CONFIG_ISA) && !defined(CONFIG_PCI) && defined(CONFIG_HP300)
+/*
+ * We need to define dummy functions otherwise drivers/serial/8250.c doesn't link
+ */
+#define inb(port)        0xff
+#define inb_p(port)      0xff
+#define outb(val,port)   do { } while (0)
+#define outb_p(val,port) do { } while (0)
+
+/*
+ * These should be valid on any ioremap()ed region
+ */
+#define readb(addr)      in_8(addr)
+#define writeb(val,addr) out_8((addr),(val))
+#define readl(addr)      in_le32(addr)
+#define writel(val,addr) out_le32((addr),(val))
+#endif
+
 #define mmiowb()
 
 static inline void *ioremap(unsigned long physaddr, unsigned long size)
@@ -327,23 +345,6 @@ static inline void *ioremap_fullcache(un
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
 
-#if !defined(CONFIG_ISA) && !defined(CONFIG_PCI) && defined(CONFIG_HP300)
-/*
- * We need to define dummy functions otherwise drivers/serial/8250.c doesn't link
- */
-#define inb(port)        0xff
-#define inb_p(port)      0xff
-#define outb(val,port)   do { } while (0)
-#define outb_p(val,port) do { } while (0)
-
-/*
- * These should be valid on any ioremap()ed region
- */
-#define readb(addr)      in_8(addr)
-#define writeb(val,addr) out_8((addr),(val))
-#define readl(addr)      in_le32(addr)
-#define writel(val,addr) out_le32((addr),(val))
-#endif
 
 /* m68k caches aren't DMA coherent */
 extern void dma_cache_wback_inv(unsigned long start, unsigned long size);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
