Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSKSRm0>; Tue, 19 Nov 2002 12:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSKSRm0>; Tue, 19 Nov 2002 12:42:26 -0500
Received: from x101-201-249-dhcp.reshalls.umn.edu ([128.101.201.249]:6272 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S267023AbSKSRmZ>;
	Tue, 19 Nov 2002 12:42:25 -0500
Date: Tue, 19 Nov 2002 11:50:41 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] mii module broken under new scheme
Message-Id: <20021119115041.11ece7dc.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/mii.c doesn't export module init/cleanup functions. That means it
can't be loaded under the new module scheme. This patch adds do-nothing
functions for it, which allows it to load. (8139too depends on mii, so
without this I don't have network.)

Matt

--- drivers/net/mii.c~no	2002-11-19 11:41:20.000000000 -0600
+++ drivers/net/mii.c	2002-11-19 11:39:06.000000000 -0600
@@ -348,3 +348,19 @@
 EXPORT_SYMBOL(mii_check_media);
 EXPORT_SYMBOL(generic_mii_ioctl);
 
+static void __init mii_init_module (void)
+{
+#ifdef MODULE
+	printk (KERN_INFO "mii" "\n");
+#endif
+
+	return 0;
+}
+
+
+static void __exit mii_cleanup_module (void)
+{
+}
+
+module_init(mii_init_module);
+module_exit(mii_cleanup_module);
