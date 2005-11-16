Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbVKPWMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbVKPWMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVKPWMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:12:23 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:27971 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030527AbVKPWMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:12:22 -0500
Subject: [PATCH] update ide.c to use pci_get_drvdata()
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/mixed; boundary="=-gmd8vgxPf3qZv9dGyRsD"
Date: Wed, 16 Nov 2005 23:12:11 +0100
Message-Id: <1132179131.24326.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gmd8vgxPf3qZv9dGyRsD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This updates drivers/ide/ide.c to use pci_get_drvdata() instead of
accessing driver_data directly.

Signed-off-by: Kasper Sandberg <lkml@metanurb.dk>

--=-gmd8vgxPf3qZv9dGyRsD
Content-Disposition: attachment; filename=ide-use-pci_get_drvdata.patch
Content-Type: text/x-patch; name=ide-use-pci_get_drvdata.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.15-rc1-git4-a/drivers/ide/ide.c linux-2.6.15-rc1-git4-b/drivers/ide/ide.c
--- linux-2.6.15-rc1-git4-a/drivers/ide/ide.c	2005-11-16 22:50:43.700117269 +0100
+++ linux-2.6.15-rc1-git4-b/drivers/ide/ide.c	2005-11-16 23:00:43.891060658 +0100
@@ -1216,7 +1216,7 @@
 
 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = pci_get_drvdata(dev);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
@@ -1235,7 +1235,7 @@
 
 static int generic_ide_resume(struct device *dev)
 {
-	ide_drive_t *drive = dev->driver_data;
+	ide_drive_t *drive = pci_get_drvdata(dev);
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;

--=-gmd8vgxPf3qZv9dGyRsD--

