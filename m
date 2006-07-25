Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWGYWhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWGYWhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWGYWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:37:25 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:64934 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751602AbWGYWhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:37:24 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sonypi: Don't print driver version until we actually find a device
Date: Tue, 25 Jul 2006 16:37:18 -0600
User-Agent: KMail/1.8.3
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607251637.19017.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't find any devices, we shouldn't print anything.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm2/drivers/char/sonypi.c
===================================================================
--- work-mm2.orig/drivers/char/sonypi.c	2006-07-17 16:50:45.000000000 -0600
+++ work-mm2/drivers/char/sonypi.c	2006-07-19 16:40:34.000000000 -0600
@@ -1528,13 +1528,13 @@
 {
 	int error;
 
+	if (!dmi_check_system(sonypi_dmi_table))
+		return -ENODEV;
+
 	printk(KERN_INFO
 		"sonypi: Sony Programmable I/O Controller Driver v%s.\n",
 		SONYPI_DRIVER_VERSION);
 
-	if (!dmi_check_system(sonypi_dmi_table))
-		return -ENODEV;
-
 	error = platform_driver_register(&sonypi_driver);
 	if (error)
 		return error;
