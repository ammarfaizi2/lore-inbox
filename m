Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUGGUkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUGGUkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGGUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:40:10 -0400
Received: from [212.34.189.10] ([212.34.189.10]:58811 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265431AbUGGUkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:40:00 -0400
Date: Wed, 7 Jul 2004 22:39:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modular swim3
Message-ID: <20040707203934.GA19145@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needs one magic mediabay symbol exported.  I've also moved the Kconfig
entry to where it belongs.


--- 1.24/drivers/block/Kconfig	2004-06-21 20:52:50 +02:00
+++ edited/drivers/block/Kconfig	2004-07-07 23:30:10 +02:00
@@ -33,6 +33,13 @@
 	  Say Y here to support the SWIM (Super Woz Integrated Machine) IOP
 	  floppy controller on the Macintosh IIfx and Quadra 900/950.
 
+config MAC_FLOPPY
+	tristate "Support for PowerMac floppy"
+	depends on PPC_PMAC && !PPC_PMAC64
+	help
+	  If you have a SWIM-3 (Super Woz Integrated Machine 3; from Apple)
+	  floppy controller, say Y here. Most commonly found in PowerMacs.
+
 config BLK_DEV_PS2
 	tristate "PS/2 ESDI hard disk support"
 	depends on MCA && MCA_LEGACY
--- 1.7/drivers/macintosh/Kconfig	2004-05-19 18:02:46 +02:00
+++ edited/drivers/macintosh/Kconfig	2004-07-07 23:49:37 +02:00
@@ -118,13 +118,6 @@
 	  events; also, the PowerBook button device will be enabled so you can
 	  change the screen brightness.
 
-config MAC_FLOPPY
-	bool "Support for PowerMac floppy"
-	depends on PPC_PMAC && !PPC_PMAC64
-	help
-	  If you have a SWIM-3 (Super Woz Integrated Machine 3; from Apple)
-	  floppy controller, say Y here. Most commonly found in PowerMacs.
-
 config MAC_SERIAL
 	tristate "Support for PowerMac serial ports (OBSOLETE DRIVER)"
 	depends on PPC_PMAC && BROKEN
--- 1.12/drivers/macintosh/mediabay.c	2004-03-14 02:57:41 +01:00
+++ edited/drivers/macintosh/mediabay.c	2004-07-08 00:06:35 +02:00
@@ -435,6 +435,7 @@
 #endif /* CONFIG_BLK_DEV_IDE */
 	return -ENODEV;
 }
+EXPORT_SYMBOL(check_media_bay);
 
 int __pmac check_media_bay_by_base(unsigned long base, int what)
 {
