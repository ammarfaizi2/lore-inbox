Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTHJPTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHJPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 11:19:40 -0400
Received: from [203.145.184.221] ([203.145.184.221]:28946 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S269696AbTHJPTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 11:19:38 -0400
Subject: [PATCH 2.6.0-test3][OSS] nec_vrc5477.c: incorrect use of __devinit
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: trivial@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Aug 2003 21:09:42 +0530
Message-Id: <1060529983.1179.79.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/oss/nec_vrc5477.c: __devinit is incorrectly used on the device
unloading function. This patch replaces it with __devexit.

--- linux-2.6.0-test3/sound/oss/nec_vrc5477.c	2003-08-09 12:11:40.000000000 +0530
+++ linux-2.6.0-test3-nvk/sound/oss/nec_vrc5477.c	2003-08-10 20:24:47.000000000 +0530
@@ -61,6 +61,7 @@
  *    02.08.2001  0.1   Initial release
  */
 
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -1965,7 +1966,7 @@
 	return -1;
 }
 
-static void __devinit vrc5477_ac97_remove(struct pci_dev *dev)
+static void __devexit vrc5477_ac97_remove(struct pci_dev *dev)
 {
 	struct vrc5477_ac97_state *s = pci_get_drvdata(dev);
 
@@ -2001,7 +2002,7 @@
 	.name		= VRC5477_AC97_MODULE_NAME,
 	.id_table	= id_table,
 	.probe		= vrc5477_ac97_probe,
-	.remove		= vrc5477_ac97_remove,
+	.remove		= __devexit_p(vrc5477_ac97_remove)
 };
 
 static int __init init_vrc5477_ac97(void)


