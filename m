Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbVIBWLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVIBWLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbVIBWLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:11:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60683 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161083AbVIBWLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:11:10 -0400
Date: Sat, 3 Sep 2005 00:10:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul.Clements@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/nbd.c: don't defer compile error to runtime
Message-ID: <20050902221059.GY3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we can detect a problem at compile time, the compilation should fail.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/drivers/block/nbd.c.old	2005-09-02 23:48:27.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/block/nbd.c	2005-09-02 23:53:47.000000000 +0200
@@ -644,8 +644,8 @@
 	int i;
 
 	if (sizeof(struct nbd_request) != 28) {
-		printk(KERN_CRIT "nbd: sizeof nbd_request needs to be 28 in order to work!\n" );
-		return -EIO;
+		extern void nbd_request_wrong_size(void);
+		nbd_request_wrong_size();
 	}
 
 	if (nbds_max > MAX_NBD) {

