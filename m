Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWJKQ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWJKQ2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWJKQ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49828 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161108AbWJKQ2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] sun3 __iomem annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1GXgwL-0005gL-Aa@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:28:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/mm/sun3kmap.c  |    8 ++++----
 drivers/net/sun3_82586.c |    2 +-
 drivers/net/sun3lance.c  |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/mm/sun3kmap.c b/arch/m68k/mm/sun3kmap.c
index 7f0d86f..8caa459 100644
--- a/arch/m68k/mm/sun3kmap.c
+++ b/arch/m68k/mm/sun3kmap.c
@@ -59,7 +59,7 @@ static inline void do_pmeg_mapin(unsigne
 	}
 }
 
-void *sun3_ioremap(unsigned long phys, unsigned long size,
+void __iomem *sun3_ioremap(unsigned long phys, unsigned long size,
 		   unsigned long type)
 {
 	struct vm_struct *area;
@@ -101,19 +101,19 @@ #endif
 		virt += seg_pages * PAGE_SIZE;
 	}
 
-	return (void *)ret;
+	return (void __iomem *)ret;
 
 }
 
 
-void *__ioremap(unsigned long phys, unsigned long size, int cache)
+void __iomem *__ioremap(unsigned long phys, unsigned long size, int cache)
 {
 
 	return sun3_ioremap(phys, size, SUN3_PAGE_TYPE_IO);
 
 }
 
-void iounmap(void *addr)
+void iounmap(void __iomem *addr)
 {
 	vfree((void *)(PAGE_MASK & (unsigned long)addr));
 }
diff --git a/drivers/net/sun3_82586.c b/drivers/net/sun3_82586.c
index d1d1885..a3220a9 100644
--- a/drivers/net/sun3_82586.c
+++ b/drivers/net/sun3_82586.c
@@ -330,7 +330,7 @@ out2:
 out1:
 	free_netdev(dev);
 out:
-	iounmap((void *)ioaddr);
+	iounmap((void __iomem *)ioaddr);
 	return ERR_PTR(err);
 }
 
diff --git a/drivers/net/sun3lance.c b/drivers/net/sun3lance.c
index 91c7654..b865db3 100644
--- a/drivers/net/sun3lance.c
+++ b/drivers/net/sun3lance.c
@@ -286,7 +286,7 @@ struct net_device * __init sun3lance_pro
 
 out1:
 #ifdef CONFIG_SUN3
-	iounmap((void *)dev->base_addr);
+	iounmap((void __iomem *)dev->base_addr);
 #endif
 out:
 	free_netdev(dev);
@@ -326,7 +326,7 @@ #endif
 		ioaddr_probe[1] = tmp2;
 
 #ifdef CONFIG_SUN3
-		iounmap((void *)ioaddr);
+		iounmap((void __iomem *)ioaddr);
 #endif
 		return 0;
 	}
@@ -956,7 +956,7 @@ void cleanup_module(void)
 {
 	unregister_netdev(sun3lance_dev);
 #ifdef CONFIG_SUN3
-	iounmap((void *)sun3lance_dev->base_addr);
+	iounmap((void __iomem *)sun3lance_dev->base_addr);
 #endif
 	free_netdev(sun3lance_dev);
 }
-- 
1.4.2.GIT


