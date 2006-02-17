Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030657AbWBQQeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbWBQQeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWBQQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:34:10 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:34302 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1030655AbWBQQeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:34:09 -0500
Date: Sat, 18 Feb 2006 01:33:56 +0900 (JST)
Message-Id: <20060218.013356.130240872.anemo@mba.ocn.ne.jp>
To: viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net, ralf@linux-mips.org
Subject: Re: [PATCH] add __force tag to fb_readb, etc.
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060217161247.GN27946@ftp.linux.org.uk>
References: <20060218.000408.07643246.anemo@mba.ocn.ne.jp>
	<20060217161247.GN27946@ftp.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 17 Feb 2006 16:12:47 +0000, Al Viro <viro@ftp.linux.org.uk> said:

viro> With __force you've lost _all_ warnings - anything goes.  NAK.
viro> At the very least, figure out what type should the argument be
viro> and add a (non-force) cast to that before forcing it.

Thanks.  Then how about this?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2cb19e6..d1c81e2 100644
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
+#define fb_readb(addr) (*(volatile u8 __force *)(const volatile u8 __iomem *)(addr))
+#define fb_readw(addr) (*(volatile u16 __force *)(const volatile u16 __iomem *)(addr))
+#define fb_readl(addr) (*(volatile u32 __force *)(const volatile u32 __iomem *)(addr))
+#define fb_readq(addr) (*(volatile u64 __force *)(const volatile u64 __iomem *)(addr))
+#define fb_writeb(b,addr) (*(volatile u8 __force *)(volatile u8 __iomem *)(addr) = (b))
+#define fb_writew(b,addr) (*(volatile u16 __force *)(volatile u16 __iomem *)(addr) = (b))
+#define fb_writel(b,addr) (*(volatile u32 __force *)(volatile u32 __iomem *)(addr) = (b))
+#define fb_writeq(b,addr) (*(volatile u64 __force *)(volatile u64 __iomem *)(addr) = (b))
 #define fb_memset memset
 
 #endif
