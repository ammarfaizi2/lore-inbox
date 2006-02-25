Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWBYQBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWBYQBz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWBYQBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:01:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58630 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161020AbWBYQBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:01:54 -0500
Date: Sat, 25 Feb 2006 17:01:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, Paul.Clements@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: don't defer compile error to runtime (fwd)
Message-ID: <20060225160153.GY3674@stusta.de>
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
- 20 Feb 2006
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

