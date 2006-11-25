Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967147AbWKYTSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967147AbWKYTSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967144AbWKYTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:18:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967142AbWKYTSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:18:17 -0500
Date: Sat, 25 Nov 2006 20:18:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] proper prototype for hugetlb_get_unmapped_area()
Message-ID: <20061125191820.GL3702@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proper prototype for hugetlb_get_unmapped_area() in 
include/linux/hugetlb.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/hugetlbfs/inode.c    |    5 +----
 include/linux/hugetlb.h |    7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)


--- linux-2.6.19-rc6-mm1/include/linux/hugetlb.h.old	2006-11-25 00:37:47.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/hugetlb.h	2006-11-25 00:44:41.000000000 +0100
@@ -183,4 +184,10 @@
 
 #endif /* !CONFIG_HUGETLBFS */
 
+#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+					unsigned long len, unsigned long pgoff,
+					unsigned long flags);
+#endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
+
 #endif /* _LINUX_HUGETLB_H */
--- linux-2.6.19-rc6-mm1/fs/hugetlbfs/inode.c.old	2006-11-25 00:38:14.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/hugetlbfs/inode.c	2006-11-25 00:41:12.000000000 +0100
@@ -98,10 +98,7 @@
  * Called under down_write(mmap_sem).
  */
 
-#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags);
-#else
+#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 static unsigned long
 hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)

