Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbTIINQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTIINQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:16:00 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:22423 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264079AbTIINP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:15:59 -0400
Message-ID: <20030909131707.11490.qmail@bilbo.math.uni-mannheim.de>
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix build of fs/ufs/namei.c (was: Linux 2.6.0-test5: ufs build fails)
Date: Tue, 9 Sep 2003 15:10:12 +0200
User-Agent: KMail/1.5.3
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von Eyal Lebedinsky:

> allmodconfig on i386:
> 
>   CC [M]  fs/ufs/namei.o
> fs/ufs/namei.c: In function `ufs_mknod':
> fs/ufs/namei.c:119: parse error before `int'
> fs/ufs/namei.c:127: `err' undeclared (first use in this function)
> fs/ufs/namei.c:127: (Each undeclared identifier is reported only once
> fs/ufs/namei.c:127: for each function it appears in.)
> fs/ufs/namei.c:131: warning: control reaches end of non-void function
> make[2]: *** [fs/ufs/namei.o] Error 1
> make[1]: *** [fs/ufs] Error 2
> make: *** [fs] Error 2

Your gcc doesn't like declarations after code I think. Try attached patch.

Eike

--- linux-2.6.0-test5/fs/ufs/namei.c	2003-09-08 21:50:57.000000000 +0200
+++ linux-2.6.0-test5-caliban/fs/ufs/namei.c	2003-09-09 15:06:19.000000000 +0200
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
