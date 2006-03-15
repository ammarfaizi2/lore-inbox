Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWCONo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCONo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCONo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:44:26 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:30092 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750926AbWCONo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:44:26 -0500
Date: Wed, 15 Mar 2006 08:44:22 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] SELinux - cleanup stray variable in selinux_inode_init_security()
Message-ID: <Pine.LNX.4.64.0603150843070.15361@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unneded pointer variable in
selinux_inode_init_security().

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    2 --
 1 files changed, 2 deletions(-)
  
diff -purN -X dontdiff linux-2.6.16-rc6.p/security/selinux/hooks.c linux-2.6.16-rc6.w/security/selinux/hooks.c
--- linux-2.6.16-rc6.p/security/selinux/hooks.c	2006-03-13 20:02:35.000000000 -0500
+++ linux-2.6.16-rc6.w/security/selinux/hooks.c	2006-03-13 22:10:33.000000000 -0500
@@ -1929,7 +1929,6 @@ static int selinux_inode_init_security(s
 	struct task_security_struct *tsec;
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
-	struct inode_security_struct *isec;
 	u32 newsid, clen;
 	int rc;
 	char *namep = NULL, *context;
@@ -1937,7 +1936,6 @@ static int selinux_inode_init_security(s
 	tsec = current->security;
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
-	isec = inode->i_security;
 
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
