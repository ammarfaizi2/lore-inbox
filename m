Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTIIUpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTIIUpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:45:34 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:51842 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S264388AbTIIUpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:45:25 -0400
Message-ID: <3F5E2691.2070600@terra.com.br>
Date: Tue, 09 Sep 2003 16:14:25 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] UFS build fix
Content-Type: multipart/mixed;
 boundary="------------010408010109050503050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408010109050503050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Linus,

	Trivial patch (against 2.6-test5) to fix the build for the UFS file 
system.

	Please apply.

	Cheers,

Felipe

--------------010408010109050503050101
Content-Type: text/plain;
 name="ufs-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ufs-build.patch"

--- linux-2.6.0-test5/fs/ufs/namei.c	Mon Sep  8 16:50:57 2003
+++ linux-2.6.0-test5-fwd/fs/ufs/namei.c	Tue Sep  9 16:11:06 2003
@@ -113,10 +113,12 @@
 static int ufs_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct inode * inode;
+	int err;
+
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
 	inode = ufs_new_inode(dir, mode);
-	int err = PTR_ERR(inode);
+	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
 		/* NOTE: that'll go when we get wide dev_t */

--------------010408010109050503050101--

