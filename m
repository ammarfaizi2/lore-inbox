Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTIKODs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbTIKODs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:03:48 -0400
Received: from gherkin.frus.com ([192.158.254.49]:20609 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S261344AbTIKODo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:03:44 -0400
Subject: [PATCH] linux/fs/ufs/namei.c
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2003 09:03:43 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM754070711-4970-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20030911140343.28348DBDB@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM754070711-4970-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

The attached patch fixes a compilation problem (syntax) that
arises when using the recommended minimum (according to
linux/Documentation/Changes) gcc-2.95.3 compiler to build
2.6.0-test5.  Would have found this sooner, but my
Slackware 8.0 laptop has been in use at a remote location
for the past several months :-).

<old_fart_mode><gasoline><match>
Don't much care for whatever C language standard revision
that allows this kind of sloppiness.  However, gcc-3.2.2
handles it just fine.
</match></gasoline></old_fart_mode>

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM754070711-4970-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch00t5_ufs

--- linux/fs/ufs/namei.c.orig	Wed Sep 10 10:23:03 2003
+++ linux/fs/ufs/namei.c	Wed Sep 10 21:45:30 2003
@@ -113,10 +113,11 @@
 static int ufs_mknod (struct inode * dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct inode * inode;
+	int err;
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
 	inode = ufs_new_inode(dir, mode);
-	int err = PTR_ERR(inode);
+	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
 		/* NOTE: that'll go when we get wide dev_t */

--ELM754070711-4970-0_--
