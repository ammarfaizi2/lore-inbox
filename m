Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUGGUmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUGGUmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGGUmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:42:04 -0400
Received: from [212.34.189.10] ([212.34.189.10]:59835 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265433AbUGGUk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:40:26 -0400
Date: Wed, 7 Jul 2004 22:40:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modular anslcd
Message-ID: <20040707204003.GB19145@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.7/drivers/macintosh/Kconfig	2004-05-19 18:02:46 +02:00
+++ edited/drivers/macintosh/Kconfig	2004-07-07 23:49:37 +02:00
@@ -191,7 +184,7 @@
 	  G5 machines. 
 
 config ANSLCD
-	bool "Support for ANS LCD display"
+	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
 
 endmenu
--- 1.3/drivers/macintosh/ans-lcd.c	2003-01-06 04:08:28 +01:00
+++ edited/drivers/macintosh/ans-lcd.c	2004-07-08 00:05:05 +02:00
@@ -136,7 +136,7 @@
 				"*    Welcome to    *"  /* Line #2 */
 				"********************"; /* Line #4 */
 
-int __init
+static int __init
 anslcd_init(void)
 {
 	int a;
@@ -173,5 +173,12 @@
 	return 0;
 }
 
-__initcall(anslcd_init);
+static void __exit
+anslcd_exit(void)
+{
+	misc_deregister(&anslcd_dev);
+	iounmap(anslcd_ptr);
+}
 
+module_init(anslcd_init);
+module_exit(anslcd_exit);
