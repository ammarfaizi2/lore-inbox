Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWBTWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWBTWhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWBTWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63500 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030217AbWBTWg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:26 -0500
Date: Mon, 20 Feb 2006 23:36:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Adam Kropelin <akropel1@rochester.rr.com>, Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: don't defer compile error to runtime
Message-ID: <20060220223625.GO4661@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we can detect a problem at compile time, the compilation should fail.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Sep 2005

--- linux-2.6.13-mm1-full/drivers/block/nbd.c.old	2005-09-02 23:48:27.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/block/nbd.c	2005-09-03 01:08:04.000000000 +0200
@@ -643,10 +643,7 @@
 	int err = -ENOMEM;
 	int i;
 
-	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
-		return -EIO;
-	}
+	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
 
 	if (nbds_max > MAX_NBD) {
 		printk(KERN_CRIT "nbd: cannot allocate more than %u nbds; %u requested.\n", MAX_NBD,

