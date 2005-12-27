Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVL0Tkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVL0Tkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 14:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVL0Tkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 14:40:37 -0500
Received: from mailspool.ops.uunet.co.za ([196.7.0.140]:1042 "EHLO
	mailspool.ops.uunet.co.za") by vger.kernel.org with ESMTP
	id S1751135AbVL0Tkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 14:40:36 -0500
Date: Tue, 27 Dec 2005 21:39:17 +0200
To: davej@codemonkey.org.uk
Cc: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>
Subject: [PATCH] ati-agp suspend/resume support
From: Jaco Kroon <jaco@kroon.co.za>
Message-Id: <20051227193157.20CC586F7A@belrog.fns.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for the ati-agp module

Signed-off-by: Jaco Kroon <jaco@kroon.co.za>
ACKed-by: Pavel Machek <pavel@suse.cz>

--- linux-2.6.15-rc6/drivers/char/agp/ati-agp.c.orig	2005-12-27 21:14:10.000000000 +0200
+++ linux-2.6.15-rc6/drivers/char/agp/ati-agp.c	2005-12-27 21:14:58.000000000 +0200
@@ -244,6 +244,22 @@
 }
 
 
+#ifdef CONFIG_PM
+static int agp_ati_resume(struct pci_dev *dev)
+{
+	pci_restore_state(dev);
+			
+	return ati_configure();
+}
+
+static int agp_ati_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	pci_save_state(dev);
+
+	return 0;
+}
+#endif
+
 /*
  *Since we don't need contigious memory we just try
  * to get the gatt table once
@@ -525,6 +541,10 @@
 	.id_table	= agp_ati_pci_table,
 	.probe		= agp_ati_probe,
 	.remove		= agp_ati_remove,
+#ifdef CONFIG_PM
+	.resume		= agp_ati_resume,
+	.suspend	= agp_ati_suspend,
+#endif
 };
 
 static int __init agp_ati_init(void)
