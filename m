Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVKGQYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVKGQYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVKGQYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:24:38 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:32947 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S964778AbVKGQYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:24:38 -0500
Subject: [patch 1/1] selinux:  Disable setxattr on mountpoint labeled
	filesystems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 07 Nov 2005 11:20:37 -0500
Message-Id: <1131380437.20591.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables the setting of SELinux xattrs on files created in
filesystems labeled via mountpoint labeling (mounted with the context=
option).  selinux_inode_setxattr already prevents explicit setxattr from
userspace on such filesystems, so this provides consistent behavior for
file creation.  Please apply, for 2.6.15 if possible.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.173
diff -u -p -r1.173 hooks.c
--- linux-2.6/security/selinux/hooks.c	31 Oct 2005 15:36:30 -0000	1.173
+++ linux-2.6/security/selinux/hooks.c	4 Nov 2005 20:55:20 -0000
@@ -1986,6 +1986,9 @@ static int selinux_inode_init_security(s
 
 	inode_security_set_sid(inode, newsid);
 
+	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+		return -EOPNOTSUPP;
+
 	if (name) {
 		namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_KERNEL);
 		if (!namep)

-- 
Stephen Smalley
National Security Agency

