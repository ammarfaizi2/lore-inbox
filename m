Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWHWKwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWHWKwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWHWKwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:52:38 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1133 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S964848AbWHWKwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:52:33 -0400
Subject: [PATCH] nfsd: lockdep annotation
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Neil Brown <neilb@suse.de>, arjan <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 12:48:32 +0200
Message-Id: <1156330112.3382.34.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while doing a kernel make modules_install install over an NFS mount.
(

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
nfsd/9550 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c034c845>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c034c845>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
2 locks held by nfsd/9550:
 #0:  (hash_sem){..--}, at: [<cc895223>] exp_readlock+0xd/0xf [nfsd]
 #1:  (&inode->i_mutex){--..}, at: [<c034c845>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0103508>] show_trace_log_lvl+0x58/0x152
 [<c0103b8b>] show_trace+0xd/0x10
 [<c0103c2f>] dump_stack+0x19/0x1b
 [<c012aa57>] __lock_acquire+0x77a/0x9a3
 [<c012af4a>] lock_acquire+0x60/0x80
 [<c034c6c2>] __mutex_lock_slowpath+0xa7/0x20e
 [<c034c845>] mutex_lock+0x1c/0x1f
 [<c0162edc>] vfs_unlink+0x34/0x8a
 [<cc891d98>] nfsd_unlink+0x18f/0x1e2 [nfsd]
 [<cc89884f>] nfsd3_proc_remove+0x95/0xa2 [nfsd]
 [<cc88f0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<c033e84d>] svc_process+0x3a5/0x5ed
 [<cc88f5ba>] nfsd+0x1a7/0x305 [nfsd]
 [<c0101005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c0103b8b>] show_trace+0xd/0x10
 [<c0103c2f>] dump_stack+0x19/0x1b
 [<c012aa57>] __lock_acquire+0x77a/0x9a3
 [<c012af4a>] lock_acquire+0x60/0x80
 [<c034c6c2>] __mutex_lock_slowpath+0xa7/0x20e
 [<c034c845>] mutex_lock+0x1c/0x1f
 [<c0162edc>] vfs_unlink+0x34/0x8a
 [<cc891d98>] nfsd_unlink+0x18f/0x1e2 [nfsd]
 [<cc89884f>] nfsd3_proc_remove+0x95/0xa2 [nfsd]
 [<cc88f0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<c033e84d>] svc_process+0x3a5/0x5ed
 [<cc88f5ba>] nfsd+0x1a7/0x305 [nfsd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
nfsd/9580 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c034cc1d>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c034cc1d>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
2 locks held by nfsd/9580:
 #0:  (hash_sem){..--}, at: [<cc89522b>] exp_readlock+0xd/0xf [nfsd]
 #1:  (&inode->i_mutex){--..}, at: [<c034cc1d>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0103508>] show_trace_log_lvl+0x58/0x152
 [<c0103b8b>] show_trace+0xd/0x10
 [<c0103c2f>] dump_stack+0x19/0x1b
 [<c012aa63>] __lock_acquire+0x77a/0x9a3
 [<c012af56>] lock_acquire+0x60/0x80
 [<c034ca9a>] __mutex_lock_slowpath+0xa7/0x20e
 [<c034cc1d>] mutex_lock+0x1c/0x1f
 [<cc892ad1>] nfsd_setattr+0x2c8/0x499 [nfsd]
 [<cc893ede>] nfsd_create_v3+0x31b/0x4ac [nfsd]
 [<cc8984a1>] nfsd3_proc_create+0x128/0x138 [nfsd]
 [<cc88f0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<c033ec1d>] svc_process+0x3a5/0x5ed
 [<cc88f5ba>] nfsd+0x1a7/0x305 [nfsd]
 [<c0101005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c0103b8b>] show_trace+0xd/0x10
 [<c0103c2f>] dump_stack+0x19/0x1b
 [<c012aa63>] __lock_acquire+0x77a/0x9a3
 [<c012af56>] lock_acquire+0x60/0x80
 [<c034ca9a>] __mutex_lock_slowpath+0xa7/0x20e
 [<c034cc1d>] mutex_lock+0x1c/0x1f
 [<cc892ad1>] nfsd_setattr+0x2c8/0x499 [nfsd]
 [<cc893ede>] nfsd_create_v3+0x31b/0x4ac [nfsd]
 [<cc8984a1>] nfsd3_proc_create+0x128/0x138 [nfsd]
 [<cc88f0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<c033ec1d>] svc_process+0x3a5/0x5ed
 [<cc88f5ba>] nfsd+0x1a7/0x305 [nfsd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfsd/vfs.c              |    8 ++++----
 include/linux/nfsd/nfsfh.h |   11 +++++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.orig/fs/nfsd/vfs.c
+++ linux-2.6/fs/nfsd/vfs.c
@@ -1114,7 +1114,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	 */
 	if (!resfhp->fh_dentry) {
 		/* called from nfsd_proc_mkdir, or possibly nfsd3_proc_create */
-		fh_lock(fhp);
+		fh_lock_nested(fhp, I_MUTEX_PARENT);
 		dchild = lookup_one_len(fname, dentry, flen);
 		err = PTR_ERR(dchild);
 		if (IS_ERR(dchild))
@@ -1240,7 +1240,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	err = nfserr_notdir;
 	if(!dirp->i_op || !dirp->i_op->lookup)
 		goto out;
-	fh_lock(fhp);
+	fh_lock_nested(fhp, I_MUTEX_PARENT);
 
 	/*
 	 * Compose the response file handle.
@@ -1494,7 +1494,7 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	if (isdotent(name, len))
 		goto out;
 
-	fh_lock(ffhp);
+	fh_lock_nested(ffhp, I_MUTEX_PARENT);
 	ddir = ffhp->fh_dentry;
 	dirp = ddir->d_inode;
 
@@ -1644,7 +1644,7 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 	if (err)
 		goto out;
 
-	fh_lock(fhp);
+	fh_lock_nested(fhp, I_MUTEX_PARENT);
 	dentry = fhp->fh_dentry;
 	dirp = dentry->d_inode;
 
Index: linux-2.6/include/linux/nfsd/nfsfh.h
===================================================================
--- linux-2.6.orig/include/linux/nfsd/nfsfh.h
+++ linux-2.6/include/linux/nfsd/nfsfh.h
@@ -296,8 +296,9 @@ fill_post_wcc(struct svc_fh *fhp)
  * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
  * so, any changes here should be reflected there.
  */
+
 static inline void
-fh_lock(struct svc_fh *fhp)
+fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
 {
 	struct dentry	*dentry = fhp->fh_dentry;
 	struct inode	*inode;
@@ -316,11 +317,17 @@ fh_lock(struct svc_fh *fhp)
 	}
 
 	inode = dentry->d_inode;
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, subclass);
 	fill_pre_wcc(fhp);
 	fhp->fh_locked = 1;
 }
 
+static inline void
+fh_lock(struct svc_fh *fhp)
+{
+	fh_lock_nested(fhp, I_MUTEX_NORMAL);
+}
+
 /*
  * Unlock a file handle/inode
  */



