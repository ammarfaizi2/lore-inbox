Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVJ1HAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVJ1HAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVJ1HAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:00:24 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:23980 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S965127AbVJ1HAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:00:22 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/io.h: eliminate warning for pointer passed to integral function argument
Date: Thu, 27 Oct 2005 23:19:14 -0700
Message-ID: <001001c5db87$85a55500$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for a compiler warning, this wasn't apparent in 2.6.12, I
believe the compiler options have been changed (somewhere) so
that passing a (void*) to a (u32) argument is now warned.

This accounts for the majority of the warnings in my builds of
the 2.6.14 kernel for NSLU2.

This is the trivial fix, but may be controversial in that it
simply casts away the warning - the alternative is to change
all the static inlines and potentially some of the callers
thereof.

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.14-rc5/include/asm-arm/arch-ixp4xx/io.h	2005-10-26 08:37:22.844417060 -0700
+++ patched/include/asm-arm/arch-ixp4xx/io.h	2005-10-26 12:14:20.771583571 -0700
@@ -80,21 +80,21 @@ __ixp4xx_iounmap(void __iomem *addr)
 #define __arch_ioremap(a, s, f, x)	__ixp4xx_ioremap(a, s, f, x)
 #define	__arch_iounmap(a)		__ixp4xx_iounmap(a)
 
-#define	writeb(p, v)			__ixp4xx_writeb(p, v)
-#define	writew(p, v)			__ixp4xx_writew(p, v)
-#define	writel(p, v)			__ixp4xx_writel(p, v)
-
-#define	writesb(p, v, l)		__ixp4xx_writesb(p, v, l)
-#define	writesw(p, v, l)		__ixp4xx_writesw(p, v, l)
-#define	writesl(p, v, l)		__ixp4xx_writesl(p, v, l)
+#define	writeb(v, p)			__ixp4xx_writeb(v, (u32)p)
+#define	writew(v, p)			__ixp4xx_writew(v, (u32)p)
+#define	writel(v, p)			__ixp4xx_writel(v, (u32)p)
+
+#define	writesb(p, v, l)		__ixp4xx_writesb((u32)p, v, l)
+#define	writesw(p, v, l)		__ixp4xx_writesw((u32)p, v, l)
+#define	writesl(p, v, l)		__ixp4xx_writesl((u32)p, v, l)
 	
-#define	readb(p)			__ixp4xx_readb(p)
-#define	readw(p)			__ixp4xx_readw(p)
-#define	readl(p)			__ixp4xx_readl(p)
+#define	readb(p)			__ixp4xx_readb((u32)p)
+#define	readw(p)			__ixp4xx_readw((u32)p)
+#define	readl(p)			__ixp4xx_readl((u32)p)
 	
-#define	readsb(p, v, l)			__ixp4xx_readsb(p, v, l)
-#define	readsw(p, v, l)			__ixp4xx_readsw(p, v, l)
-#define	readsl(p, v, l)			__ixp4xx_readsl(p, v, l)
+#define	readsb(p, v, l)			__ixp4xx_readsb((u32)p, v, l)
+#define	readsw(p, v, l)			__ixp4xx_readsw((u32)p, v, l)
+#define	readsl(p, v, l)			__ixp4xx_readsl((u32)p, v, l)
 
 static inline void 
 __ixp4xx_writeb(u8 value, u32 addr)

