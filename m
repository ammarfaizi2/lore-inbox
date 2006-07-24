Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWGXNB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGXNB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWGXNB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:01:29 -0400
Received: from server6.greatnet.de ([83.133.96.26]:29318 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932137AbWGXNB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:01:28 -0400
Message-ID: <44C4BD93.40804@nachtwindheim.de>
Date: Mon, 24 Jul 2006 14:31:15 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: jgarzik@pobox.com
Cc: kernel-janitors@lists.osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [NET] initialisation cleanup for ULI526x-net-driver
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

[NET] initialisation cleanup for ULI526x-net-driver

removes the unneeded local variable rc
replace pci_module_init() with pci_register_driver()
two coding style issues on switch

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6.18-rc2-git2/drivers/net/tulip/uli526x.c linux/drivers/net/tulip/uli526x.c
--- linux-2.6.18-rc2-git2/drivers/net/tulip/uli526x.c	2006-07-24 13:58:05.000000000 +0200
+++ linux/drivers/net/tulip/uli526x.c	2006-07-24 14:21:43.000000000 +0200
@@ -1702,7 +1702,6 @@
 
 static int __init uli526x_init_module(void)
 {
-	int rc;
 
 	printk(version);
 	printed_version = 1;
@@ -1714,22 +1713,19 @@
 	if (cr6set)
 		uli526x_cr6_user_set = cr6set;
 
- 	switch(mode) {
+ 	switch (mode) {
    	case ULI526X_10MHF:
 	case ULI526X_100MHF:
 	case ULI526X_10MFD:
 	case ULI526X_100MFD:
 		uli526x_media_mode = mode;
 		break;
-	default:uli526x_media_mode = ULI526X_AUTO;
+	default:
+		uli526x_media_mode = ULI526X_AUTO;
 		break;
 	}
 
-	rc = pci_module_init(&uli526x_driver);
-	if (rc < 0)
-		return rc;
-
-	return 0;
+	return pci_register_driver(&uli526x_driver);
 }
 
 
