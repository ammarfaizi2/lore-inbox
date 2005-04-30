Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVD3UKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVD3UKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVD3UJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:09:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261400AbVD3UIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:08:12 -0400
Date: Sat, 30 Apr 2005 22:08:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/nvram.c: possible cleanups
Message-ID: <20050430200811.GP3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the needlessly global function __nvram_set_checksum static
- #if 0 the unused global function nvram_set_checksum
- remove the EXPORT_SYMBOL's for both functions

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

 drivers/char/nvram.c  |    6 +++---
 include/linux/nvram.h |    2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc2-mm3-full/include/linux/nvram.h.old	2005-04-17 18:15:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/nvram.h	2005-04-17 18:16:04.000000000 +0200
@@ -20,8 +20,6 @@
 extern void nvram_write_byte(unsigned char c, int i);
 extern int __nvram_check_checksum(void);
 extern int nvram_check_checksum(void);
-extern void __nvram_set_checksum(void);
-extern void nvram_set_checksum(void);
 #endif
 
 #endif  /* _LINUX_NVRAM_H */
--- linux-2.6.12-rc2-mm3-full/drivers/char/nvram.c.old	2005-04-17 18:16:10.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/nvram.c	2005-04-17 18:16:36.000000000 +0200
@@ -211,12 +211,13 @@
 	return rv;
 }
 
-void
+static void
 __nvram_set_checksum(void)
 {
 	mach_set_checksum();
 }
 
+#if 0
 void
 nvram_set_checksum(void)
 {
@@ -226,6 +227,7 @@
 	__nvram_set_checksum();
 	spin_unlock_irqrestore(&rtc_lock, flags);
 }
+#endif  /*  0  */
 
 /*
  * The are the file operation function for user access to /dev/nvram
@@ -921,6 +923,4 @@
 EXPORT_SYMBOL(nvram_write_byte);
 EXPORT_SYMBOL(__nvram_check_checksum);
 EXPORT_SYMBOL(nvram_check_checksum);
-EXPORT_SYMBOL(__nvram_set_checksum);
-EXPORT_SYMBOL(nvram_set_checksum);
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);

