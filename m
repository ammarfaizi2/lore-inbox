Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWBVTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWBVTbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWBVTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:31:11 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:60830 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751418AbWBVTbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:31:09 -0500
Subject: [patch 1/1] selinux: Disable automatic labeling of new inodes when
	no policy is loaded
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 22 Feb 2006 14:36:26 -0500
Message-Id: <1140636986.31467.276.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables the automatic labeling of new inodes on disk
when no policy is loaded.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm1/security/selinux/hooks.c	2006-02-21 14:39:53.000000000 -0500
+++ linux-2.6.16-rc4-mm1-x/security/selinux/hooks.c	2006-02-21 14:43:32.000000000 -0500
@@ -1983,7 +1983,7 @@ static int selinux_inode_init_security(s
 
 	inode_security_set_sid(inode, newsid);
 
-	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
+	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
 	if (name) {

-- 
Stephen Smalley
National Security Agency

