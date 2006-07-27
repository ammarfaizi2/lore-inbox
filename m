Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWG0VEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWG0VEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWG0VEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:04:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751240AbWG0VC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:29 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/30] NFS: Add extra const qualifiers [try #11]
Date: Thu, 27 Jul 2006 21:52:52 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205252.8443.7412.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some extra const qualifiers into NFS.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/namespace.c        |    3 ++-
 fs/nfs/nfs3proc.c         |    2 +-
 fs/nfs/nfs4namespace.c    |    8 ++++----
 fs/nfs/nfs4proc.c         |    2 +-
 fs/nfs/proc.c             |    2 +-
 fs/nfs/super.c            |   10 +++++-----
 include/linux/nfs_fs_sb.h |    2 +-
 include/linux/nfs_xdr.h   |    6 +++---
 8 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 19b98ca..460a978 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -170,7 +170,8 @@ void nfs_release_automount_timer(void)
 /*
  * Clone a mountpoint of the appropriate type
  */
-static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server, char *devname,
+static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
+					   const char *devname,
 					   struct nfs_clone_mount *mountdata)
 {
 #ifdef CONFIG_NFS_V4
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 7143b1f..3e53712 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -886,7 +886,7 @@ nfs3_proc_lock(struct file *filp, int cm
 	return nlmclnt_proc(filp->f_dentry->d_inode, cmd, fl);
 }
 
-struct nfs_rpc_ops	nfs_v3_clientops = {
+const struct nfs_rpc_ops nfs_v3_clientops = {
 	.version	= 3,			/* protocol version */
 	.dentry_ops	= &nfs_dentry_operations,
 	.dir_inode_ops	= &nfs3_dir_inode_operations,
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index ea38d27..faed9bc 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -23,7 +23,7 @@ #define NFSDBG_FACILITY		NFSDBG_VFS
 /*
  * Check if fs_root is valid
  */
-static inline char *nfs4_pathname_string(struct nfs4_pathname *pathname,
+static inline char *nfs4_pathname_string(const struct nfs4_pathname *pathname,
 					 char *buffer, ssize_t buflen)
 {
 	char *end = buffer + buflen;
@@ -34,7 +34,7 @@ static inline char *nfs4_pathname_string
 
 	n = pathname->ncomponents;
 	while (--n >= 0) {
-		struct nfs4_string *component = &pathname->components[n];
+		const struct nfs4_string *component = &pathname->components[n];
 		buflen -= component->len + 1;
 		if (buflen < 0)
 			goto Elong;
@@ -60,7 +60,7 @@ Elong:
  */
 static struct vfsmount *nfs_follow_referral(const struct vfsmount *mnt_parent,
 					    const struct dentry *dentry,
-					    struct nfs4_fs_locations *locations)
+					    const struct nfs4_fs_locations *locations)
 {
 	struct vfsmount *mnt = ERR_PTR(-ENOENT);
 	struct nfs_clone_mount mountdata = {
@@ -108,7 +108,7 @@ static struct vfsmount *nfs_follow_refer
 
 	loc = 0;
 	while (loc < locations->nlocations && IS_ERR(mnt)) {
-		struct nfs4_fs_location *location = &locations->locations[loc];
+		const struct nfs4_fs_location *location = &locations->locations[loc];
 		char *mnt_path;
 
 		if (location == NULL || location->nservers <= 0 ||
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2925d37..a3adfb1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3736,7 +3736,7 @@ static struct inode_operations nfs4_file
 	.listxattr	= nfs4_listxattr,
 };
 
-struct nfs_rpc_ops	nfs_v4_clientops = {
+const struct nfs_rpc_ops nfs_v4_clientops = {
 	.version	= 4,			/* protocol version */
 	.dentry_ops	= &nfs4_dentry_operations,
 	.dir_inode_ops	= &nfs4_dir_inode_operations,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index b3899ea..7767690 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -671,7 +671,7 @@ nfs_proc_lock(struct file *filp, int cmd
 }
 
 
-struct nfs_rpc_ops	nfs_v2_clientops = {
+const struct nfs_rpc_ops nfs_v2_clientops = {
 	.version	= 2,		       /* protocol version */
 	.dentry_ops	= &nfs_dentry_operations,
 	.dir_inode_ops	= &nfs_dir_inode_operations,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4e128fe..65e1bec 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -324,10 +324,10 @@ static const char *nfs_pseudoflavour_to_
  */
 static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss, int showdefaults)
 {
-	static struct proc_nfs_info {
+	static const struct proc_nfs_info {
 		int flag;
-		char *str;
-		char *nostr;
+		const char *str;
+		const char *nostr;
 	} nfs_info[] = {
 		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
 		{ NFS_MOUNT_INTR, ",intr", "" },
@@ -337,9 +337,9 @@ static void nfs_show_mount_options(struc
 		{ NFS_MOUNT_NOACL, ",noacl", "" },
 		{ 0, NULL, NULL }
 	};
-	struct proc_nfs_info *nfs_infop;
+	const struct proc_nfs_info *nfs_infop;
 	char buf[12];
-	char *proto;
+	const char *proto;
 
 	seq_printf(m, ",vers=%d", nfss->rpc_ops->version);
 	seq_printf(m, ",rsize=%d", nfss->rsize);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a727657..95f32d5 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -73,7 +73,7 @@ struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct rpc_clnt *	client_sys;	/* 2nd handle for FSINFO */
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
-	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
+	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
 	struct nfs_iostats *	io_stats;	/* I/O statistics */
 	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 24ceac1..7f5b96e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -833,9 +833,9 @@ #define NFS_CALL(op, inode, args)	NFS_PR
 /*
  * Function vectors etc. for the NFS client
  */
-extern struct nfs_rpc_ops	nfs_v2_clientops;
-extern struct nfs_rpc_ops	nfs_v3_clientops;
-extern struct nfs_rpc_ops	nfs_v4_clientops;
+extern const struct nfs_rpc_ops	nfs_v2_clientops;
+extern const struct nfs_rpc_ops	nfs_v3_clientops;
+extern const struct nfs_rpc_ops	nfs_v4_clientops;
 extern struct rpc_version	nfs_version2;
 extern struct rpc_version	nfs_version3;
 extern struct rpc_version	nfs_version4;
