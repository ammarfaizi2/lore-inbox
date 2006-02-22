Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWBVOvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWBVOvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWBVOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:51:18 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:58794 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751298AbWBVOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:51:18 -0500
Date: Wed, 22 Feb 2006 09:51:15 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] selinuxfs cleanups - fix hard link count
Message-ID: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the hard link count for selinuxfs directories, which are 
currently one short.

Please apply.


Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    4 ++++
 1 file changed, 4 insertions(+)


diff -purN -X dontdiff linux-2.6.16-rc4.o/security/selinux/selinuxfs.c linux-2.6.16-rc4.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4.o/security/selinux/selinuxfs.c	2006-02-17 17:23:45.000000000 -0500
+++ linux-2.6.16-rc4.w/security/selinux/selinuxfs.c	2006-02-19 17:48:41.000000000 -0500
@@ -1198,6 +1198,8 @@ static int sel_make_dir(struct super_blo
 	}
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inode->i_nlink++;
 	d_add(dentry, inode);
 out:
 	return ret;
@@ -1239,6 +1241,8 @@ static int sel_fill_super(struct super_b
 		goto out;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inode->i_nlink++;
 	d_add(dentry, inode);
 	bool_dir = dentry;
 	ret = sel_make_bools();
