Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVBUOtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVBUOtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVBUOtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:49:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40972 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261993AbVBUOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:48:13 -0500
Date: Mon, 21 Feb 2005 15:48:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ne3210.c: cleanups
Message-ID: <20050221144809.GC3187@stusta.de>
References: <20050218234659.GC4337@stusta.de> <42193BFD.9070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42193BFD.9070900@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 08:40:13PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >-	if (ei_debug > 0)
> >-		printk(version);
> 
> 
> I agree the version variable is outdated, but I disagree that the driver 
> intro banner should be removed completely.

A few lines above, the driver already prints "ne3210.c: remapped...". 
So what exactly should be printed at this place?
The patch below only removes the version information, but the printk 
looks a bit silly.


<--  snip  -->


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
+		printk("ne3210 driver");
 
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

