Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUBXSu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUBXSu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:50:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262390AbUBXStc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:49:32 -0500
Date: Tue, 24 Feb 2004 13:49:48 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [SELINUX] Change ENOTSUPP to EOPNOTSUPP
Message-ID: <Xine.LNX.4.44.0402241348440.25620-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ENOTSUPP is the wrong value, and should not be returned to userspace.


diff -purN -X dontdiff linux-2.6.3-mm3.o/security/selinux/hooks.c linux-2.6.3-mm3.w/security/selinux/hooks.c
--- linux-2.6.3-mm3.o/security/selinux/hooks.c	2004-02-23 10:52:59.000000000 -0500
+++ linux-2.6.3-mm3.w/security/selinux/hooks.c	2004-02-23 11:16:20.848999216 -0500
@@ -2129,7 +2129,7 @@ static int selinux_inode_setxattr(struct
 
 	sbsec = inode->i_sb->s_security;
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
@@ -2187,7 +2187,7 @@ static int selinux_inode_getxattr (struc
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return dentry_has_perm(current, NULL, dentry, FILE__GETATTR);
 }

