Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTHURjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTHURb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:15302 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262849AbTHURbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870701587@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870694188@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:10 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1285.1.3, 2003/08/20 16:48:01-07:00, greg@kroah.com

[PATCH] PCI: add PCI_NAME_SIZE instead of using DEVICE_NAME_SIZE

based on a patch from OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


 drivers/pci/names.c |    6 +++---
 include/linux/pci.h |    4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c	Thu Aug 21 10:21:23 2003
+++ b/drivers/pci/names.c	Thu Aug 21 10:21:23 2003
@@ -80,14 +80,14 @@
 		}
 
 		/* Ok, found the vendor, but unknown device */
-		sprintf(name, "PCI device %04x:%04x (%." DEVICE_NAME_HALF "s)",
+		sprintf(name, "PCI device %04x:%04x (%." PCI_NAME_HALF "s)",
 				dev->vendor, dev->device, vendor_p->name);
 		return;
 
 		/* Full match */
 		match_device: {
-			char *n = name + sprintf(name, "%." DEVICE_NAME_HALF
-					"s %." DEVICE_NAME_HALF "s",
+			char *n = name + sprintf(name, "%." PCI_NAME_HALF
+					"s %." PCI_NAME_HALF "s",
 					vendor_p->name, device_p->name);
 			int nr = device_p->seen + 1;
 			device_p->seen = nr;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Aug 21 10:21:23 2003
+++ b/include/linux/pci.h	Thu Aug 21 10:21:23 2003
@@ -420,7 +420,9 @@
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
 #ifdef CONFIG_PCI_NAMES
-	char		pretty_name[DEVICE_NAME_SIZE];	/* pretty name for users to see */
+#define PCI_NAME_SIZE	50
+#define PCI_NAME_HALF	__stringify(20)	/* less than half to handle slop */
+	char		pretty_name[PCI_NAME_SIZE];	/* pretty name for users to see */
 #endif
 };
 

