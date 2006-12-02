Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422874AbWLBL3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422874AbWLBL3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423146AbWLBL3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:29:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:51276 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422874AbWLBL3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:29:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CQen+hH2aPsTGvibm9C9DScmC4iy7ULNmL4N3mybmj+b/dRuk4XwYazKSHLxlGBnDGffpQicrcbxP9zPOJIs7lcX4qrXlxSO9Q2sF2ctD2Q1leAwz80PXfsi+T/NlUMGwOdx0Cp++ZLYPqDi6cHmUopIuKyUbaS+khJs8VuyBoY=
Subject: [PATCH 2.6.19] jffs: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, jffs-dev@axis.com
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:31:23 +0200
Message-Id: <1165059084.4523.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/fs/jffs/intrep.c linux-2.6.19-rc5_kzalloc/fs/jffs/intrep.c
--- linux-2.6.19-rc5_orig/fs/jffs/intrep.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/jffs/intrep.c	2006-11-11 22:44:18.000000000 +0200
@@ -591,7 +591,7 @@ jffs_add_virtual_root(struct jffs_contro
 	D2(printk("jffs_add_virtual_root(): "
 		  "Creating a virtual root directory.\n"));
 
-	if (!(root = kmalloc(sizeof(struct jffs_file), GFP_KERNEL))) {
+	if (!(root = kzalloc(sizeof(struct jffs_file), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
 	no_jffs_file++;
@@ -603,7 +603,6 @@ jffs_add_virtual_root(struct jffs_contro
 	DJM(no_jffs_node++);
 	memset(node, 0, sizeof(struct jffs_node));
 	node->ino = JFFS_MIN_INO;
-	memset(root, 0, sizeof(struct jffs_file));
 	root->ino = JFFS_MIN_INO;
 	root->mode = S_IFDIR | S_IRWXU | S_IRGRP
 		     | S_IXGRP | S_IROTH | S_IXOTH;



