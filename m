Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTDGXeP (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDGXbq (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:31:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18305
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263745AbTDGXU7 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:20:59 -0400
Date: Tue, 8 Apr 2003 01:39:55 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080039.h380dtag009306@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: cs4232 should be devexit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/cs4232.c linux-2.5.67-ac1/sound/oss/cs4232.c
--- linux-2.5.67/sound/oss/cs4232.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/cs4232.c	2003-04-03 23:54:38.000000000 +0100
@@ -313,7 +313,7 @@
 	}
 }
 
-static void __exit unload_cs4232(struct address_info *hw_config)
+static void __devexit unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
@@ -428,7 +428,7 @@
 	return 0;
 }
 
-static void cs4232_pnp_remove(struct pnp_dev *dev)
+static void __devexit cs4232_pnp_remove(struct pnp_dev *dev)
 {
 	struct address_info *cfg = pnp_get_drvdata(dev);
 	if (cfg) {
@@ -441,7 +441,7 @@
 	.name		= "cs4232",
 	.id_table	= cs4232_pnp_table,
 	.probe		= cs4232_pnp_probe,
-	.remove		= cs4232_pnp_remove,
+	.remove		= __devexit_p(cs4232_pnp_remove),
 };
 
 static int __init init_cs4232(void)
