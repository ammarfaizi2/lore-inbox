Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbTIWT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbTIWTY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:24:26 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:27084 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S263504AbTIWTXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:23:40 -0400
Message-ID: <3F709B9F.8080607@terra.com.br>
Date: Tue, 23 Sep 2003 16:14:39 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: dwmw2@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] memory leak in mtdblock.c found by checker
Content-Type: multipart/mixed;
 boundary="------------090607070909000400060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607070909000400060405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi David,

	Patch against 2.6-test5, which checks the right variable if kmalloc 
failed.

	Please apply,

Felipe

--------------090607070909000400060405
Content-Type: text/plain;
 name="mtdblock-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mtdblock-leak.patch"

--- linux-2.6.0-test5/drivers/mtd/mtdblock.c.orig	2003-09-23 16:09:37.000000000 -0300
+++ linux-2.6.0-test5/drivers/mtd/mtdblock.c	2003-09-23 16:10:50.000000000 -0300
@@ -275,7 +275,7 @@
 	
 	/* OK, it's not open. Create cache info for it */
 	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
-	if (!mtdblks)
+	if (!mtdblk)
 		return -ENOMEM;
 
 	memset(mtdblk, 0, sizeof(*mtdblk));

--------------090607070909000400060405--

