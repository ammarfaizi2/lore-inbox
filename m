Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVBRXrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVBRXrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVBRXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:47:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29458 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261564AbVBRXrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:47:03 -0500
Date: Sat, 19 Feb 2005 00:46:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ne3210.c: cleanups
Message-ID: <20050218234659.GC4337@stusta.de>
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

 drivers/net/ne3210.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/ne3210.c.old	2005-02-16 16:09:39.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ne3210.c	2005-02-17 21:55:37.000000000 +0100
@@ -26,9 +26,6 @@
 	Updated to EISA probing API 5/2003 by Marc Zyngier.
 */
 
-static const char *version =
-	"ne3210.c: Driver revision v0.03, 30/09/98\n";
-
 #include <linux/module.h>
 #include <linux/eisa.h>
 #include <linux/kernel.h>
@@ -196,9 +193,6 @@
 	ei_status.word16 = 1;
 	ei_status.priv = phys_mem;
 
-	if (ei_debug > 0)
-		printk(version);
-
 	ei_status.reset_8390 = &ne3210_reset_8390;
 	ei_status.block_input = &ne3210_block_input;
 	ei_status.block_output = &ne3210_block_output;
@@ -359,12 +353,12 @@
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

