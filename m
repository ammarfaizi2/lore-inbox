Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLYG3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLYG3i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 01:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLYG3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 01:29:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35565 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750797AbVLYG3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 01:29:38 -0500
Date: Sun, 25 Dec 2005 06:29:37 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] nfsd/vfs.c: endianness fixes
Message-ID: <20051225062937.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135476096 -0500

several failure exits return -E<something> instead of nfserr_<something>
and vice versa.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/nfsd/vfs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

38c78c8cfcd1be715fb280f83e2b1ce2f709abc8
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index af7c3c3..f237f98 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1134,7 +1134,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 				"nfsd_create: parent %s/%s not locked!\n",
 				dentry->d_parent->d_name.name,
 				dentry->d_name.name);
-			err = -EIO;
+			err = nfserr_io;
 			goto out;
 		}
 	}
@@ -1592,7 +1592,7 @@ nfsd_rename(struct svc_rqst *rqstp, stru
 	if ((ffhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 		((atomic_read(&odentry->d_count) > 1)
 		 || (atomic_read(&ndentry->d_count) > 1))) {
-			err = nfserr_perm;
+			err = -EPERM;
 	} else
 #endif
 	err = vfs_rename(fdir, odentry, tdir, ndentry);
@@ -1663,7 +1663,7 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 #ifdef MSNFS
 		if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 			(atomic_read(&rdentry->d_count) > 1)) {
-			err = nfserr_perm;
+			err = -EPERM;
 		} else
 #endif
 		err = vfs_unlink(dirp, rdentry);
-- 
0.99.9.GIT

