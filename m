Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVDSAgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDSAgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDSAgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:36:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25356 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261210AbVDSAgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:36:37 -0400
Date: Tue, 19 Apr 2005 02:36:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/ne3210.c: cleanups
Message-ID: <20050419003635.GF5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make two needlessly global functions static
- kill an ancient version variable

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ne3210.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/ne3210.c.old	2005-02-16 16:09:39.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ne3210.c	2005-02-21 15:10:02.000000000 +0100
@@ -26,9 +26,6 @@
 	Updated to EISA probing API 5/2003 by Marc Zyngier.
 */
 
-static const char *version =
-	"ne3210.c: Driver revision v0.03, 30/09/98\n";
-
 #include <linux/module.h>
 #include <linux/eisa.h>
 #include <linux/kernel.h>
@@ -197,7 +194,7 @@
 	ei_status.priv = phys_mem;
 
 	if (ei_debug > 0)
-		printk(version);
+		printk("ne3210 loaded.\n");
 
 	ei_status.reset_8390 = &ne3210_reset_8390;
 	ei_status.block_input = &ne3210_block_input;
@@ -359,12 +356,12 @@
 MODULE_DESCRIPTION("NE3210 EISA Ethernet driver");
 MODULE_LICENSE("GPL");
 
-int ne3210_init(void)
+static int ne3210_init(void)
 {
 	return eisa_driver_register (&ne3210_eisa_driver);
 }
 
-void ne3210_cleanup(void)
+static void ne3210_cleanup(void)
 {
 	eisa_driver_unregister (&ne3210_eisa_driver);
 }

