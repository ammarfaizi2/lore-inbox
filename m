Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUJaKPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUJaKPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbUJaKOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:14:40 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1829 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261528AbUJaKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:39 -0500
Date: Sun, 31 Oct 2004 11:03:35 +0100
Message-Id: <200410311003.i9VA3Zas009573@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 477] M68k I/O for generic 8250 on HP300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k I/O updates from Kars de Jong and Jochen Friedrich:
  - To be able to use the generic 8250 driver on the HP300, added dummy
    implementations of inb(), inb_p(), outb() and outb_p()
  - Added implementations of readb(), writeb(), readl(), and writel() for the
    8250 driver

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-Off-By: Jochen Friedrich <jochen@scram.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/asm-m68k/io.h	2004-06-20 13:13:50.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/io.h	2004-07-14 13:19:47.000000000 +0200
@@ -306,6 +306,23 @@
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
 
 static inline void *ioremap(unsigned long physaddr, unsigned long size)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
