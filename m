Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVA2RLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVA2RLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVA2RLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:11:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44808 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261341AbVA2RLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:11:14 -0500
Date: Sat, 29 Jan 2005 18:11:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: H.T.M.v.d.Maarel@marin.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/isp16.c: small cleanups
Message-ID: <20050129171108.GB28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global function isp16_init static.

As a result, it turned out that both this function and some other code 
are only required #ifdef MODULE.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/cdrom/isp16.c |   13 ++++++++-----
 drivers/cdrom/isp16.h |    1 -
 2 files changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.h.old	2005-01-29 16:46:18.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.h	2005-01-29 16:47:11.000000000 +0100
@@ -71,4 +71,3 @@
 #define ISP16_IO_BASE 0xF8D
 #define ISP16_IO_SIZE 5  /* ports used from 0xF8D up to 0xF91 */
 
-int isp16_init(void);
--- linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.c.old	2005-01-29 16:47:19.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.c	2005-01-29 17:46:38.000000000 +0100
@@ -58,6 +58,7 @@
 #include <asm/io.h>
 #include "isp16.h"
 
+#ifdef MODULE
 static short isp16_detect(void);
 static short isp16_c928__detect(void);
 static short isp16_c929__detect(void);
@@ -66,6 +67,7 @@
 static short isp16_type;	/* dependent on type of interface card */
 static u_char isp16_ctrl;
 static u_short isp16_enable_port;
+#endif  /*  MODULE  */
 
 static int isp16_cdrom_base = ISP16_CDROM_IO_BASE;
 static int isp16_cdrom_irq = ISP16_CDROM_IRQ;
@@ -106,13 +108,13 @@
 
 __setup("isp16=", isp16_setup);
 
-#endif				/* MODULE */
+#else				/* MODULE */
 
 /*
  *  ISP16 initialisation.
  *
  */
-int __init isp16_init(void)
+static int __init isp16_init(void)
 {
 	u_char expected_drive;
 
@@ -366,15 +368,16 @@
 	return 0;
 }
 
+module_init(isp16_init);
+
+#endif
+
 void __exit isp16_exit(void)
 {
 	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
 	printk(KERN_INFO "ISP16: module released.\n");
 }
 
-#ifdef MODULE
-module_init(isp16_init);
-#endif
 module_exit(isp16_exit);
 
 MODULE_LICENSE("GPL");

