Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCUP4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCUP4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVCUP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:56:47 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:33169 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261846AbVCUP4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:56:35 -0500
Subject: [PATCH][SELINUX] Allow mounting of filesystems with invalid root
	inode context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Darrel Goeddel <dgoeddel@trustedcs.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 21 Mar 2005 10:48:36 -0500
Message-Id: <1111420116.13101.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch alters the SELinux handling of inodes with invalid security
contexts so that a filesystem with a root inode that has an invalid
security context can still be mounted for administrative recovery
without disabling SELinux altogether.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.157
diff -u -p -r1.157 hooks.c
--- linux-2.6/security/selinux/hooks.c	14 Mar 2005 19:56:52 -0000	1.157
+++ linux-2.6/security/selinux/hooks.c	18 Mar 2005 20:39:03 -0000
@@ -828,7 +828,9 @@ static int inode_doinit_with_dentry(stru
 				       __FUNCTION__, context, -rc,
 				       inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
-				goto out;
+				/* Leave with the unlabeled SID */
+				rc = 0;
+				break;
 			}
 		}
 		kfree(context);

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

