Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWBQPEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWBQPEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWBQPEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:04:22 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:24574 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750784AbWBQPEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:04:21 -0500
Date: Sat, 18 Feb 2006 00:04:08 +0900 (JST)
Message-Id: <20060218.000408.07643246.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, ralf@linux-mips.org
Subject: [PATCH] add __force tag to fb_readb, etc.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes many sparse warnings on MIPS (and some other) platform.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2cb19e6..61562d7 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -823,14 +823,14 @@ struct fb_info {
 
 #else
 
-#define fb_readb(addr) (*(volatile u8 *) (addr))
-#define fb_readw(addr) (*(volatile u16 *) (addr))
-#define fb_readl(addr) (*(volatile u32 *) (addr))
-#define fb_readq(addr) (*(volatile u64 *) (addr))
-#define fb_writeb(b,addr) (*(volatile u8 *) (addr) = (b))
-#define fb_writew(b,addr) (*(volatile u16 *) (addr) = (b))
-#define fb_writel(b,addr) (*(volatile u32 *) (addr) = (b))
-#define fb_writeq(b,addr) (*(volatile u64 *) (addr) = (b))
+#define fb_readb(addr) (*(volatile u8 __force *) (addr))
+#define fb_readw(addr) (*(volatile u16 __force *) (addr))
+#define fb_readl(addr) (*(volatile u32 __force *) (addr))
+#define fb_readq(addr) (*(volatile u64 __force *) (addr))
+#define fb_writeb(b,addr) (*(volatile u8 __force *) (addr) = (b))
+#define fb_writew(b,addr) (*(volatile u16 __force *) (addr) = (b))
+#define fb_writel(b,addr) (*(volatile u32 __force *) (addr) = (b))
+#define fb_writeq(b,addr) (*(volatile u64 __force *) (addr) = (b))
 #define fb_memset memset
 
 #endif
