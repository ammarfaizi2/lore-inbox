Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbTIUNYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTIUNYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:24:11 -0400
Received: from [61.95.227.64] ([61.95.227.64]:60061 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S262402AbTIUNYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:24:08 -0400
Subject: [PATCH 2.6.0-test5][OSS] nec_vr5477.c: add missing __devexit_p
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1064150695.4349.38.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 21 Sep 2003 18:54:55 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


