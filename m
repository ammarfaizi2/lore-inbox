Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWJJDMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWJJDMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWJJDM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:12:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14765 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964824AbWJJDML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] nfs: verifier is network-endian
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX82N-0004Cz-2r@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs3proc.c       |    2 +-
 fs/nfs/nfs4proc.c       |    6 +++---
 include/linux/nfs_fs.h  |    2 +-
 include/linux/nfs_xdr.h |    8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 3b234d4..e5f128f 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -668,7 +668,7 @@ nfs3_proc_readdir(struct dentry *dentry,
 {
 	struct inode		*dir = dentry->d_inode;
 	struct nfs_fattr	dir_attr;
-	u32			*verf = NFS_COOKIEVERF(dir);
+	__be32			*verf = NFS_COOKIEVERF(dir);
 	struct nfs3_readdirargs	arg = {
 		.fh		= NFS_FH(dir),
 		.cookie		= cookie,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cbf640e..5ded982 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -138,7 +138,7 @@ const u32 nfs4_fs_locations_bitmap[2] = 
 	| FATTR4_WORD1_MOUNTED_ON_FILEID
 };
 
-static void nfs4_setup_readdir(u64 cookie, u32 *verifier, struct dentry *dentry,
+static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
 		struct nfs4_readdir_arg *readdir)
 {
 	__be32 *start, *p;
@@ -2917,11 +2917,11 @@ int nfs4_proc_setclientid(struct nfs_cli
 		.rpc_resp = clp,
 		.rpc_cred = cred,
 	};
-	u32 *p;
+	__be32 *p;
 	int loop = 0;
 	int status;
 
-	p = (u32*)sc_verifier.data;
+	p = (__be32*)sc_verifier.data;
 	*p++ = htonl((u32)clp->cl_boot_time.tv_sec);
 	*p = htonl((u32)clp->cl_boot_time.tv_nsec);
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 76ff548..379fd96 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -157,7 +157,7 @@ #endif
 	 * This is the cookie verifier used for NFSv3 readdir
 	 * operations
 	 */
-	__u32			cookieverf[2];
+	__be32			cookieverf[2];
 
 	/*
 	 * This is the list of dirty unwritten pages.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ac8058b..768c1ad 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -266,7 +266,7 @@ struct nfs_writeargs {
 
 struct nfs_writeverf {
 	enum nfs3_stable_how	committed;
-	__u32			verifier[2];
+	__be32			verifier[2];
 };
 
 struct nfs_writeres {
@@ -420,7 +420,7 @@ struct nfs3_createargs {
 	unsigned int		len;
 	struct iattr *		sattr;
 	enum nfs3_createmode	createmode;
-	__u32			verifier[2];
+	__be32			verifier[2];
 };
 
 struct nfs3_mkdirargs {
@@ -467,7 +467,7 @@ struct nfs3_linkargs {
 struct nfs3_readdirargs {
 	struct nfs_fh *		fh;
 	__u64			cookie;
-	__u32			verf[2];
+	__be32			verf[2];
 	int			plus;
 	unsigned int            count;
 	struct page **		pages;
@@ -503,7 +503,7 @@ struct nfs3_linkres {
 
 struct nfs3_readdirres {
 	struct nfs_fattr *	dir_attr;
-	__u32 *			verf;
+	__be32 *		verf;
 	int			plus;
 };
 
-- 
1.4.2.GIT


