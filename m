Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVADA3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVADA3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVADA0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:26:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14344 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261885AbVADAZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:25:03 -0500
Date: Tue, 4 Jan 2005 01:24:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: urban@teststation.com
Cc: samba@samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] smbfs: make some functions static
Message-ID: <20050104002456.GV2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global functions static.


diffstat output:
 fs/smbfs/inode.c   |    2 +-
 fs/smbfs/proc.c    |    6 +++---
 fs/smbfs/proto.h   |    5 -----
 fs/smbfs/request.c |    6 ++++--
 4 files changed, 8 insertions(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm1-full/fs/smbfs/proto.h.old	2005-01-04 00:57:42.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/smbfs/proto.h	2005-01-04 01:00:11.000000000 +0100
@@ -25,7 +25,6 @@
 extern int smb_proc_flush(struct smb_sb_info *server, __u16 fileid);
 extern void smb_init_root_dirent(struct smb_sb_info *server, struct smb_fattr *fattr,
 				 struct super_block *sb);
-extern void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p);
 extern int smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr(struct dentry *dir, struct smb_fattr *fattr);
 extern int smb_proc_setattr_unix(struct dentry *d, struct iattr *attr, unsigned int major, unsigned int minor);
@@ -34,7 +33,6 @@
 extern int smb_proc_read_link(struct smb_sb_info *server, struct dentry *d, char *buffer, int len);
 extern int smb_proc_symlink(struct smb_sb_info *server, struct dentry *d, const char *oldpath);
 extern int smb_proc_link(struct smb_sb_info *server, struct dentry *dentry, struct dentry *new_dentry);
-extern int smb_proc_query_cifsunix(struct smb_sb_info *server);
 extern void smb_install_null_ops(struct smb_ops *ops);
 /* dir.c */
 extern struct file_operations smb_dir_operations;
@@ -62,7 +60,6 @@
 extern void smb_set_inode_attr(struct inode *inode, struct smb_fattr *fattr);
 extern void smb_invalidate_inodes(struct smb_sb_info *server);
 extern int smb_revalidate_inode(struct dentry *dentry);
-extern int smb_fill_super(struct super_block *sb, void *raw_data, int silent);
 extern int smb_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat);
 extern int smb_notify_change(struct dentry *dentry, struct iattr *attr);
 /* file.c */
@@ -81,10 +78,8 @@
 extern int smb_init_request_cache(void);
 extern void smb_destroy_request_cache(void);
 extern struct smb_request *smb_alloc_request(struct smb_sb_info *server, int bufsize);
-extern void smb_rget(struct smb_request *req);
 extern void smb_rput(struct smb_request *req);
 extern int smb_add_request(struct smb_request *req);
-extern int smb_request_send_req(struct smb_request *req);
 extern int smb_request_send_server(struct smb_sb_info *server);
 extern int smb_request_recv(struct smb_sb_info *server);
 /* symlink.c */
--- linux-2.6.10-mm1-full/fs/smbfs/inode.c.old	2005-01-04 00:57:57.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/smbfs/inode.c	2005-01-04 00:58:02.000000000 +0100
@@ -493,7 +493,7 @@
 	smb_kfree(server);
 }
 
-int smb_fill_super(struct super_block *sb, void *raw_data, int silent)
+static int smb_fill_super(struct super_block *sb, void *raw_data, int silent)
 {
 	struct smb_sb_info *server;
 	struct smb_mount_data_kernel *mnt;
--- linux-2.6.10-mm1-full/fs/smbfs/proc.c.old	2005-01-04 00:58:37.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/smbfs/proc.c	2005-01-04 00:59:12.000000000 +0100
@@ -74,7 +74,7 @@
 static int
 smb_proc_setattr_ext(struct smb_sb_info *server,
 		     struct inode *inode, struct smb_fattr *fattr);
-int
+static int
 smb_proc_query_cifsunix(struct smb_sb_info *server);
 static void
 install_ops(struct smb_ops *dst, struct smb_ops *src);
@@ -2075,7 +2075,7 @@
 	return result;
 }
 
-void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p)
+static void smb_decode_unix_basic(struct smb_fattr *fattr, struct smb_sb_info *server, char *p)
 {
 	u64 size, disk_bytes;
 
@@ -3392,7 +3392,7 @@
 	return result;
 }
 
-int
+static int
 smb_proc_query_cifsunix(struct smb_sb_info *server)
 {
 	int result;
--- linux-2.6.10-mm1-full/fs/smbfs/request.c.old	2005-01-04 00:59:31.000000000 +0100
+++ linux-2.6.10-mm1-full/fs/smbfs/request.c	2005-01-04 01:00:18.000000000 +0100
@@ -27,6 +27,8 @@
 /* cache for request structures */
 static kmem_cache_t *req_cachep;
 
+static int smb_request_send_req(struct smb_request *req);
+
 /*
   /proc/slabinfo:
   name, active, num, objsize, active_slabs, num_slaps, #pages
@@ -132,7 +134,7 @@
  * What prevents a rget to race with a rput? The count must never drop to zero
  * while it is in use. Only rput if it is ok that it is free'd.
  */
-void smb_rget(struct smb_request *req)
+static void smb_rget(struct smb_request *req)
 {
 	atomic_inc(&req->rq_count);
 }
@@ -379,7 +381,7 @@
  * Send a request and place it on the recvq if successfully sent.
  * Must be called with the server lock held.
  */
-int smb_request_send_req(struct smb_request *req)
+static int smb_request_send_req(struct smb_request *req)
 {
 	struct smb_sb_info *server = req->rq_server;
 	int result;

