Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWASTMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWASTMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWASTL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:11:56 -0500
Received: from ns1.coraid.com ([65.14.39.133]:19368 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161337AbWASTLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:11:54 -0500
Message-ID: <e506e5e61e4a3821850c62e32bc95b17@coraid.com>
Date: Thu, 19 Jan 2006 13:46:27 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9] aoe [6/8]: update device information on last close
From: "Ed L. Cashin" <ecashin@coraid.com>
References: <E1EzelK-0006sT-00@kokone>
Gcc: nnfolder:Mail/sent-200601
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

Instead of making the user wait or do it manually, refresh
device information on its last close by issuing a config
query to the device.

diff -upr 2.6.15-git9-orig/drivers/block/aoe/aoeblk.c 2.6.15-git9-aoe/drivers/block/aoe/aoeblk.c
--- 2.6.15-git9-orig/drivers/block/aoe/aoeblk.c	2006-01-19 13:31:22.000000000 -0500
+++ 2.6.15-git9-aoe/drivers/block/aoe/aoeblk.c	2006-01-19 13:31:23.000000000 -0500
@@ -109,7 +109,7 @@ aoeblk_release(struct inode *inode, stru
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	if (--d->nopen == 0 && !(d->flags & DEVFL_UP)) {
+	if (--d->nopen == 0) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		aoecmd_cfg(d->aoemajor, d->aoeminor);
 		return 0;


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
