Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVGNV3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVGNV3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVGNV3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:29:16 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:2012 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263056AbVGNV3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:29:14 -0400
Message-Id: <200507142128.j6ELSvRh029126@ms-smtp-05-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 11:51:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2] v9fs: fix problems spotted in previous patchset (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formating errors and a memory leak that crept in the
previous round of revisions to v9fs.  These will be reincorperated 
into the patchset and resent to akpm.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 22d785a22895513c6ab67dfa53c25b8b833fe235
tree 88822e96e339bf071d63576c87a15ddc7f4419b6
parent fe7cd649688d12dfaeeef2c594d131584c488dcd
author Eric Van Hensbergen <ericvh@gmail.com> Thu, 14 Jul 2005 16:22:29 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Thu, 14 Jul 2005 16:22:29 -0500

 fs/9p/fid.c       |    2 +-
 fs/9p/mux.c       |    6 +++---
 fs/9p/vfs_file.c  |    5 +++--
 fs/9p/vfs_inode.c |    6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -206,7 +206,7 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 			/* TODO: take advantage of multiwalk */
 
 			fidnum = v9fs_get_idpool(&v9ses->fidpool);
-			if(fidnum < 0) {
+			if (fidnum < 0) {
 				dprintk(DEBUG_ERROR,
 					"could not get a new fid num\n");
 				return return_fid;
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -262,7 +262,7 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	ret = v9fs_send(v9ses, &req);
 
 	if (ret < 0) {
-		if(tcall->id != TVERSION)
+		if (tcall->id != TVERSION)
 			v9fs_put_idpool(tid, &v9ses->tidpool);
 		dprintk(DEBUG_MUX, "error %d\n", ret);
 		return ret;
@@ -313,7 +313,7 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 	}
 
       release_req:
-	if(tcall->id != TVERSION)
+	if (tcall->id != TVERSION)
 		v9fs_put_idpool(tid, &v9ses->tidpool);
 	if (rcall)
 		*rcall = fcall;
@@ -345,7 +345,7 @@ static int v9fs_recvproc(void *data)
 		req = rptr = rreq = NULL;
 
 		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
-		if(!rcall) {
+		if (!rcall) {
 			eprintk(KERN_ERR, "no memory for buffers\n");
 			break;
 		}
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -381,9 +381,10 @@ v9fs_file_write(struct file *filp, const
 	ret = copy_from_user(buffer, data, count);
 	if (ret) {
 		dprintk(DEBUG_ERROR, "Problem copying from user\n");
-		return -EFAULT;
-	} else
+		ret = -EFAULT;
+	} else {
 		ret = v9fs_write(filp, buffer, count, offset);
+	}
 
 	kfree(buffer);
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -666,7 +666,7 @@ v9fs_vfs_rename(struct inode *old_dir, s
 
 	dprintk(DEBUG_VFS, "\n");
 
-	if(!mistat)
+	if (!mistat)
 		return -ENOMEM;
 
 	if ((!oldfid) || (!olddirfid) || (!newdirfid)) {
@@ -934,7 +934,7 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		symname);
 
-	if(!mistat)
+	if (!mistat)
 		return -ENOMEM;
 
 	if (!v9ses->extended) {
@@ -1217,7 +1217,7 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	dprintk(DEBUG_VFS, " %lu,%s mode: %x MAJOR: %u MINOR: %u\n", dir->i_ino,
 		dentry->d_name.name, mode, MAJOR(rdev), MINOR(rdev));
 
-	if(!mistat)
+	if (!mistat)
 		return -ENOMEM;
 
 	if (!new_valid_dev(rdev)) {
