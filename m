Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTL2T63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265143AbTL2T62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:58:28 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:62882
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265136AbTL2T55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:57:57 -0500
Date: Mon, 29 Dec 2003 14:57:57 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/cdrom/sjcd.c check_region() fix
Message-ID: <20031229195757.GA26168@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Mon, 29 Dec 2003 14:57:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another check_region fix, this time for sjcd.c

--- /usr/src/linux-2.6.0/drivers/cdrom/sjcd.c	2003-12-17 21:59:05.000000000 -0500
+++ drivers/cdrom/sjcd.c	2003-12-29 14:52:05.000000000 -0500
@@ -1700,12 +1700,13 @@
 	sprintf(sjcd_disk->disk_name, "sjcd");
 	sprintf(sjcd_disk->devfs_name, "sjcd");
 
-	if (check_region(sjcd_base, 4)) {
+	if (!request_region(sjcd_base, 4,"sjcd")) {
 		printk
 		    ("SJCD: Init failed, I/O port (%X) is already in use\n",
 		     sjcd_base);
 		goto out2;
 	}
+	release_region(sjcd_base,4);
 
 	/*
 	 * Check for card. Since we are booting now, we can't use standard


