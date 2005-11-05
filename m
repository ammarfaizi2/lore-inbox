Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVKEQ3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVKEQ3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKEQ3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:29:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40713 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751244AbVKEQ3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:29:14 -0500
Date: Sat, 5 Nov 2005 17:29:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/mtd/: possible cleanups
Message-ID: <20051105162912.GI5368@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- every file should #include the headers containing the prototypes for
  it's global functions
- make needlessly global functions static


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/chips/cfi_probe.c   |    2 +-
 drivers/mtd/devices/block2mtd.c |    2 +-
 drivers/mtd/ftl.c               |    2 +-
 drivers/mtd/maps/physmap.c      |    1 +
 drivers/mtd/nand/nandsim.c      |    2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/mtd/ftl.c.old	2005-11-05 16:40:16.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/mtd/ftl.c	2005-11-05 16:40:26.000000000 +0100
@@ -1084,7 +1084,7 @@
 	.owner		= THIS_MODULE,
 };
 
-int init_ftl(void)
+static int init_ftl(void)
 {
 	DEBUG(0, "$Id: ftl.c,v 1.55 2005/01/17 13:47:21 hvr Exp $\n");
 
--- linux-2.6.14-rc5-mm1-full/drivers/mtd/chips/cfi_probe.c.old	2005-11-05 16:42:08.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/mtd/chips/cfi_probe.c	2005-11-05 16:42:17.000000000 +0100
@@ -426,7 +426,7 @@
 	.module		= THIS_MODULE
 };
 
-int __init cfi_probe_init(void)
+static int __init cfi_probe_init(void)
 {
 	register_mtd_chip_driver(&cfi_chipdrv);
 	return 0;
--- linux-2.6.14-rc5-mm1-full/drivers/mtd/devices/block2mtd.c.old	2005-11-05 16:43:07.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/mtd/devices/block2mtd.c	2005-11-05 16:43:15.000000000 +0100
@@ -40,7 +40,7 @@
 
 
 #define PAGE_READAHEAD 64
-void cache_readahead(struct address_space *mapping, int index)
+static void cache_readahead(struct address_space *mapping, int index)
 {
 	filler_t *filler = (filler_t*)mapping->a_ops->readpage;
 	int i, pagei;
--- linux-2.6.14-rc5-mm1-full/drivers/mtd/maps/physmap.c.old	2005-11-05 16:43:54.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/mtd/maps/physmap.c	2005-11-05 16:44:08.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/mtd/map.h>
 #include <linux/config.h>
 #include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
 
 static struct mtd_info *mymtd;
 
--- linux-2.6.14-rc5-mm1-full/drivers/mtd/nand/nandsim.c.old	2005-11-05 16:44:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/mtd/nand/nandsim.c	2005-11-05 16:44:56.000000000 +0100
@@ -1486,7 +1486,7 @@
 /*
  * Module initialization function
  */
-int __init ns_init_module(void)
+static int __init ns_init_module(void)
 {
 	struct nand_chip *chip;
 	struct nandsim *nand;

