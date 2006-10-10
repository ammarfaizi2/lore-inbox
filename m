Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932812AbWJJDKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbWJJDKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbWJJDKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:10:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45472 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932812AbWJJDKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:10:51 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/25] fix svc_procfunc declaration
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX814-00049z-UE@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:10:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


svc_procfunc instances return __be32, not int

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/lockd/svc4proc.c        |   40 ++++++++++++++++++++--------------------
 fs/lockd/svcproc.c         |   40 ++++++++++++++++++++--------------------
 fs/nfs/callback_xdr.c      |    4 ++--
 fs/nfsd/nfs2acl.c          |   10 +++++-----
 fs/nfsd/nfs3acl.c          |    6 +++---
 fs/nfsd/nfs3proc.c         |   44 ++++++++++++++++++++++----------------------
 fs/nfsd/nfs4proc.c         |    4 ++--
 fs/nfsd/nfsproc.c          |   32 ++++++++++++++++----------------
 include/linux/sunrpc/svc.h |    2 +-
 9 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fa370f6..6ec7dbe 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -68,7 +68,7 @@ no_locks:
 /*
  * NULL: Test for presence of service
  */
-static int
+static __be32
 nlm4svc_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	dprintk("lockd: NULL          called\n");
@@ -78,7 +78,7 @@ nlm4svc_proc_null(struct svc_rqst *rqstp
 /*
  * TEST: Check for conflicting lock
  */
-static int
+static __be32
 nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -107,7 +107,7 @@ nlm4svc_proc_test(struct svc_rqst *rqstp
 	return rpc_success;
 }
 
-static int
+static __be32
 nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -150,7 +150,7 @@ #endif
 	return rpc_success;
 }
 
-static int
+static __be32
 nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -183,7 +183,7 @@ nlm4svc_proc_cancel(struct svc_rqst *rqs
 /*
  * UNLOCK: release a lock
  */
-static int
+static __be32
 nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -217,7 +217,7 @@ nlm4svc_proc_unlock(struct svc_rqst *rqs
  * GRANTED: A server calls us to tell that a process' lock request
  * was granted
  */
-static int
+static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -253,12 +253,12 @@ static const struct rpc_call_ops nlm4svc
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
  */
-static int nlm4svc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_args *argp,
-		int (*func)(struct svc_rqst *, struct nlm_args *, struct nlm_res  *))
+static __be32 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_args *argp,
+		__be32 (*func)(struct svc_rqst *, struct nlm_args *, struct nlm_res  *))
 {
 	struct nlm_host	*host;
 	struct nlm_rqst	*call;
-	int stat;
+	__be32 stat;
 
 	host = nlmsvc_lookup_host(rqstp,
 				  argp->lock.caller,
@@ -282,35 +282,35 @@ static int nlm4svc_callback(struct svc_r
 	return rpc_success;
 }
 
-static int nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	dprintk("lockd: TEST_MSG      called\n");
 	return nlm4svc_callback(rqstp, NLMPROC_TEST_RES, argp, nlm4svc_proc_test);
 }
 
-static int nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	dprintk("lockd: LOCK_MSG      called\n");
 	return nlm4svc_callback(rqstp, NLMPROC_LOCK_RES, argp, nlm4svc_proc_lock);
 }
 
-static int nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					       void	       *resp)
 {
 	dprintk("lockd: CANCEL_MSG    called\n");
 	return nlm4svc_callback(rqstp, NLMPROC_CANCEL_RES, argp, nlm4svc_proc_cancel);
 }
 
-static int nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                void            *resp)
 {
 	dprintk("lockd: UNLOCK_MSG    called\n");
 	return nlm4svc_callback(rqstp, NLMPROC_UNLOCK_RES, argp, nlm4svc_proc_unlock);
 }
 
-static int nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                 void            *resp)
 {
 	dprintk("lockd: GRANTED_MSG   called\n");
@@ -320,7 +320,7 @@ static int nlm4svc_proc_granted_msg(stru
 /*
  * SHARE: create a DOS share or alter existing share.
  */
-static int
+static __be32
 nlm4svc_proc_share(struct svc_rqst *rqstp, struct nlm_args *argp,
 				          struct nlm_res  *resp)
 {
@@ -353,7 +353,7 @@ nlm4svc_proc_share(struct svc_rqst *rqst
 /*
  * UNSHARE: Release a DOS share.
  */
-static int
+static __be32
 nlm4svc_proc_unshare(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -386,7 +386,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rq
 /*
  * NM_LOCK: Create an unmonitored lock
  */
-static int
+static __be32
 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -399,7 +399,7 @@ nlm4svc_proc_nm_lock(struct svc_rqst *rq
 /*
  * FREE_ALL: Release all locks and shares held by client
  */
-static int
+static __be32
 nlm4svc_proc_free_all(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void            *resp)
 {
@@ -417,7 +417,7 @@ nlm4svc_proc_free_all(struct svc_rqst *r
 /*
  * SM_NOTIFY: private callback from statd (not part of official NLM proto)
  */
-static int
+static __be32
 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
@@ -446,7 +446,7 @@ nlm4svc_proc_sm_notify(struct svc_rqst *
 /*
  * client sent a GRANTED_RES, let's remove the associated block
  */
-static int
+static __be32
 nlm4svc_proc_granted_res(struct svc_rqst *rqstp, struct nlm_res  *argp,
                                                 void            *resp)
 {
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 75b2c81..98f1818 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -94,7 +94,7 @@ no_locks:
 /*
  * NULL: Test for presence of service
  */
-static int
+static __be32
 nlmsvc_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	dprintk("lockd: NULL          called\n");
@@ -104,7 +104,7 @@ nlmsvc_proc_null(struct svc_rqst *rqstp,
 /*
  * TEST: Check for conflicting lock
  */
-static int
+static __be32
 nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -134,7 +134,7 @@ nlmsvc_proc_test(struct svc_rqst *rqstp,
 	return rpc_success;
 }
 
-static int
+static __be32
 nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -177,7 +177,7 @@ #endif
 	return rpc_success;
 }
 
-static int
+static __be32
 nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -210,7 +210,7 @@ nlmsvc_proc_cancel(struct svc_rqst *rqst
 /*
  * UNLOCK: release a lock
  */
-static int
+static __be32
 nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -244,7 +244,7 @@ nlmsvc_proc_unlock(struct svc_rqst *rqst
  * GRANTED: A server calls us to tell that a process' lock request
  * was granted
  */
-static int
+static __be32
 nlmsvc_proc_granted(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -280,12 +280,12 @@ static const struct rpc_call_ops nlmsvc_
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
  */
-static int nlmsvc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_args *argp,
-		int (*func)(struct svc_rqst *, struct nlm_args *, struct nlm_res  *))
+static __be32 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_args *argp,
+		__be32 (*func)(struct svc_rqst *, struct nlm_args *, struct nlm_res  *))
 {
 	struct nlm_host	*host;
 	struct nlm_rqst	*call;
-	int stat;
+	__be32 stat;
 
 	host = nlmsvc_lookup_host(rqstp,
 				  argp->lock.caller,
@@ -309,28 +309,28 @@ static int nlmsvc_callback(struct svc_rq
 	return rpc_success;
 }
 
-static int nlmsvc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlmsvc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	dprintk("lockd: TEST_MSG      called\n");
 	return nlmsvc_callback(rqstp, NLMPROC_TEST_RES, argp, nlmsvc_proc_test);
 }
 
-static int nlmsvc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	dprintk("lockd: LOCK_MSG      called\n");
 	return nlmsvc_callback(rqstp, NLMPROC_LOCK_RES, argp, nlmsvc_proc_lock);
 }
 
-static int nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
+static __be32 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					       void	       *resp)
 {
 	dprintk("lockd: CANCEL_MSG    called\n");
 	return nlmsvc_callback(rqstp, NLMPROC_CANCEL_RES, argp, nlmsvc_proc_cancel);
 }
 
-static int
+static __be32
 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                void            *resp)
 {
@@ -338,7 +338,7 @@ nlmsvc_proc_unlock_msg(struct svc_rqst *
 	return nlmsvc_callback(rqstp, NLMPROC_UNLOCK_RES, argp, nlmsvc_proc_unlock);
 }
 
-static int
+static __be32
 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                 void            *resp)
 {
@@ -349,7 +349,7 @@ nlmsvc_proc_granted_msg(struct svc_rqst 
 /*
  * SHARE: create a DOS share or alter existing share.
  */
-static int
+static __be32
 nlmsvc_proc_share(struct svc_rqst *rqstp, struct nlm_args *argp,
 				          struct nlm_res  *resp)
 {
@@ -382,7 +382,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp
 /*
  * UNSHARE: Release a DOS share.
  */
-static int
+static __be32
 nlmsvc_proc_unshare(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -415,7 +415,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqs
 /*
  * NM_LOCK: Create an unmonitored lock
  */
-static int
+static __be32
 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -428,7 +428,7 @@ nlmsvc_proc_nm_lock(struct svc_rqst *rqs
 /*
  * FREE_ALL: Release all locks and shares held by client
  */
-static int
+static __be32
 nlmsvc_proc_free_all(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void            *resp)
 {
@@ -446,7 +446,7 @@ nlmsvc_proc_free_all(struct svc_rqst *rq
 /*
  * SM_NOTIFY: private callback from statd (not part of official NLM proto)
  */
-static int
+static __be32
 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
@@ -475,7 +475,7 @@ nlmsvc_proc_sm_notify(struct svc_rqst *r
 /*
  * client sent a GRANTED_RES, let's remove the associated block
  */
-static int
+static __be32
 nlmsvc_proc_granted_res(struct svc_rqst *rqstp, struct nlm_res  *argp,
                                                 void            *resp)
 {
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 29f9321..5998d0c 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -36,7 +36,7 @@ struct callback_op {
 
 static struct callback_op callback_ops[];
 
-static int nfs4_callback_null(struct svc_rqst *rqstp, void *argp, void *resp)
+static __be32 nfs4_callback_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return htonl(NFS4_OK);
 }
@@ -399,7 +399,7 @@ static unsigned process_op(struct svc_rq
 /*
  * Decode, process and encode a COMPOUND
  */
-static int nfs4_callback_compound(struct svc_rqst *rqstp, void *argp, void *resp)
+static __be32 nfs4_callback_compound(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	struct cb_compound_hdr_arg hdr_arg;
 	struct cb_compound_hdr_res hdr_res;
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 9187755..8d48616 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -21,7 +21,7 @@ #define RETURN_STATUS(st)	{ resp->status
 /*
  * NULL call.
  */
-static int
+static __be32
 nfsacld_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return nfs_ok;
@@ -30,7 +30,7 @@ nfsacld_proc_null(struct svc_rqst *rqstp
 /*
  * Get the Access and/or Default ACL of a file.
  */
-static int nfsacld_proc_getacl(struct svc_rqst * rqstp,
+static __be32 nfsacld_proc_getacl(struct svc_rqst * rqstp,
 		struct nfsd3_getaclargs *argp, struct nfsd3_getaclres *resp)
 {
 	svc_fh *fh;
@@ -97,7 +97,7 @@ fail:
 /*
  * Set the Access and/or Default ACL of a file.
  */
-static int nfsacld_proc_setacl(struct svc_rqst * rqstp,
+static __be32 nfsacld_proc_setacl(struct svc_rqst * rqstp,
 		struct nfsd3_setaclargs *argp,
 		struct nfsd_attrstat *resp)
 {
@@ -128,7 +128,7 @@ static int nfsacld_proc_setacl(struct sv
 /*
  * Check file attributes
  */
-static int nfsacld_proc_getattr(struct svc_rqst * rqstp,
+static __be32 nfsacld_proc_getattr(struct svc_rqst * rqstp,
 		struct nfsd_fhandle *argp, struct nfsd_attrstat *resp)
 {
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
@@ -140,7 +140,7 @@ static int nfsacld_proc_getattr(struct s
 /*
  * Check file access
  */
-static int nfsacld_proc_access(struct svc_rqst *rqstp, struct nfsd3_accessargs *argp,
+static __be32 nfsacld_proc_access(struct svc_rqst *rqstp, struct nfsd3_accessargs *argp,
 		struct nfsd3_accessres *resp)
 {
 	int nfserr;
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index d4bdc00..ed6e2c2 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -19,7 +19,7 @@ #define RETURN_STATUS(st)	{ resp->status
 /*
  * NULL call.
  */
-static int
+static __be32
 nfsd3_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return nfs_ok;
@@ -28,7 +28,7 @@ nfsd3_proc_null(struct svc_rqst *rqstp, 
 /*
  * Get the Access and/or Default ACL of a file.
  */
-static int nfsd3_proc_getacl(struct svc_rqst * rqstp,
+static __be32 nfsd3_proc_getacl(struct svc_rqst * rqstp,
 		struct nfsd3_getaclargs *argp, struct nfsd3_getaclres *resp)
 {
 	svc_fh *fh;
@@ -93,7 +93,7 @@ fail:
 /*
  * Set the Access and/or Default ACL of a file.
  */
-static int nfsd3_proc_setacl(struct svc_rqst * rqstp,
+static __be32 nfsd3_proc_setacl(struct svc_rqst * rqstp,
 		struct nfsd3_setaclargs *argp,
 		struct nfsd3_attrstat *resp)
 {
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a5ebc7d..a12663f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -43,7 +43,7 @@ static int	nfs3_ftypes[] = {
 /*
  * NULL call.
  */
-static int
+static __be32
 nfsd3_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return nfs_ok;
@@ -52,7 +52,7 @@ nfsd3_proc_null(struct svc_rqst *rqstp, 
 /*
  * Get a file's attributes
  */
-static int
+static __be32
 nfsd3_proc_getattr(struct svc_rqst *rqstp, struct nfsd_fhandle  *argp,
 					   struct nfsd3_attrstat *resp)
 {
@@ -76,7 +76,7 @@ nfsd3_proc_getattr(struct svc_rqst *rqst
 /*
  * Set a file's attributes
  */
-static int
+static __be32
 nfsd3_proc_setattr(struct svc_rqst *rqstp, struct nfsd3_sattrargs *argp,
 					   struct nfsd3_attrstat  *resp)
 {
@@ -94,7 +94,7 @@ nfsd3_proc_setattr(struct svc_rqst *rqst
 /*
  * Look up a path name component
  */
-static int
+static __be32
 nfsd3_proc_lookup(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					  struct nfsd3_diropres  *resp)
 {
@@ -118,7 +118,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp
 /*
  * Check file access
  */
-static int
+static __be32
 nfsd3_proc_access(struct svc_rqst *rqstp, struct nfsd3_accessargs *argp,
 					  struct nfsd3_accessres *resp)
 {
@@ -137,7 +137,7 @@ nfsd3_proc_access(struct svc_rqst *rqstp
 /*
  * Read a symlink.
  */
-static int
+static __be32
 nfsd3_proc_readlink(struct svc_rqst *rqstp, struct nfsd3_readlinkargs *argp,
 					   struct nfsd3_readlinkres *resp)
 {
@@ -155,7 +155,7 @@ nfsd3_proc_readlink(struct svc_rqst *rqs
 /*
  * Read a portion of a file.
  */
-static int
+static __be32
 nfsd3_proc_read(struct svc_rqst *rqstp, struct nfsd3_readargs *argp,
 				        struct nfsd3_readres  *resp)
 {
@@ -195,7 +195,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp, 
 /*
  * Write data to a file
  */
-static int
+static __be32
 nfsd3_proc_write(struct svc_rqst *rqstp, struct nfsd3_writeargs *argp,
 					 struct nfsd3_writeres  *resp)
 {
@@ -223,7 +223,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp,
  * At least in theory; we'll see how it fares in practice when the
  * first reports about SunOS compatibility problems start to pour in...
  */
-static int
+static __be32
 nfsd3_proc_create(struct svc_rqst *rqstp, struct nfsd3_createargs *argp,
 					  struct nfsd3_diropres   *resp)
 {
@@ -265,7 +265,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp
 /*
  * Make directory. This operation is not idempotent.
  */
-static int
+static __be32
 nfsd3_proc_mkdir(struct svc_rqst *rqstp, struct nfsd3_createargs *argp,
 					 struct nfsd3_diropres   *resp)
 {
@@ -285,7 +285,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp,
 	RETURN_STATUS(nfserr);
 }
 
-static int
+static __be32
 nfsd3_proc_symlink(struct svc_rqst *rqstp, struct nfsd3_symlinkargs *argp,
 					   struct nfsd3_diropres    *resp)
 {
@@ -307,7 +307,7 @@ nfsd3_proc_symlink(struct svc_rqst *rqst
 /*
  * Make socket/fifo/device.
  */
-static int
+static __be32
 nfsd3_proc_mknod(struct svc_rqst *rqstp, struct nfsd3_mknodargs *argp,
 					 struct nfsd3_diropres  *resp)
 {
@@ -343,7 +343,7 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp,
 /*
  * Remove file/fifo/socket etc.
  */
-static int
+static __be32
 nfsd3_proc_remove(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					  struct nfsd3_attrstat  *resp)
 {
@@ -363,7 +363,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp
 /*
  * Remove a directory
  */
-static int
+static __be32
 nfsd3_proc_rmdir(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					 struct nfsd3_attrstat  *resp)
 {
@@ -379,7 +379,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp,
 	RETURN_STATUS(nfserr);
 }
 
-static int
+static __be32
 nfsd3_proc_rename(struct svc_rqst *rqstp, struct nfsd3_renameargs *argp,
 					  struct nfsd3_renameres  *resp)
 {
@@ -401,7 +401,7 @@ nfsd3_proc_rename(struct svc_rqst *rqstp
 	RETURN_STATUS(nfserr);
 }
 
-static int
+static __be32
 nfsd3_proc_link(struct svc_rqst *rqstp, struct nfsd3_linkargs *argp,
 					struct nfsd3_linkres  *resp)
 {
@@ -424,7 +424,7 @@ nfsd3_proc_link(struct svc_rqst *rqstp, 
 /*
  * Read a portion of a directory.
  */
-static int
+static __be32
 nfsd3_proc_readdir(struct svc_rqst *rqstp, struct nfsd3_readdirargs *argp,
 					   struct nfsd3_readdirres  *resp)
 {
@@ -459,7 +459,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqst
  * Read a portion of a directory, including file handles and attrs.
  * For now, we choose to ignore the dircount parameter.
  */
-static int
+static __be32
 nfsd3_proc_readdirplus(struct svc_rqst *rqstp, struct nfsd3_readdirargs *argp,
 					       struct nfsd3_readdirres  *resp)
 {
@@ -517,7 +517,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *
 /*
  * Get file system stats
  */
-static int
+static __be32
 nfsd3_proc_fsstat(struct svc_rqst * rqstp, struct nfsd_fhandle    *argp,
 					   struct nfsd3_fsstatres *resp)
 {
@@ -534,7 +534,7 @@ nfsd3_proc_fsstat(struct svc_rqst * rqst
 /*
  * Get file system info
  */
-static int
+static __be32
 nfsd3_proc_fsinfo(struct svc_rqst * rqstp, struct nfsd_fhandle    *argp,
 					   struct nfsd3_fsinfores *resp)
 {
@@ -576,7 +576,7 @@ nfsd3_proc_fsinfo(struct svc_rqst * rqst
 /*
  * Get pathconf info for the specified file
  */
-static int
+static __be32
 nfsd3_proc_pathconf(struct svc_rqst * rqstp, struct nfsd_fhandle      *argp,
 					     struct nfsd3_pathconfres *resp)
 {
@@ -619,7 +619,7 @@ nfsd3_proc_pathconf(struct svc_rqst * rq
 /*
  * Commit a file (range) to stable storage.
  */
-static int
+static __be32
 nfsd3_proc_commit(struct svc_rqst * rqstp, struct nfsd3_commitargs *argp,
 					   struct nfsd3_commitres  *resp)
 {
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8333db1..0b3000c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -715,7 +715,7 @@ out_kfree:
 /*
  * NULL call.
  */
-static int
+static __be32
 nfsd4_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return nfs_ok;
@@ -731,7 +731,7 @@ static inline void nfsd4_increment_op_st
 /*
  * COMPOUND call.
  */
-static int
+static __be32
 nfsd4_proc_compound(struct svc_rqst *rqstp,
 		    struct nfsd4_compoundargs *args,
 		    struct nfsd4_compoundres *resp)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9ee1dab..09030af 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -30,7 +30,7 @@ typedef struct svc_buf	svc_buf;
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
 
-static int
+static __be32
 nfsd_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	return nfs_ok;
@@ -56,7 +56,7 @@ nfsd_return_dirop(int err, struct nfsd_d
  * Get a file's attributes
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_getattr(struct svc_rqst *rqstp, struct nfsd_fhandle  *argp,
 					  struct nfsd_attrstat *resp)
 {
@@ -72,7 +72,7 @@ nfsd_proc_getattr(struct svc_rqst *rqstp
  * Set a file's attributes
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_setattr(struct svc_rqst *rqstp, struct nfsd_sattrargs *argp,
 					  struct nfsd_attrstat  *resp)
 {
@@ -92,7 +92,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp
  * doesn't exist yet.
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_lookup(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 					 struct nfsd_diropres  *resp)
 {
@@ -112,7 +112,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp,
 /*
  * Read a symlink.
  */
-static int
+static __be32
 nfsd_proc_readlink(struct svc_rqst *rqstp, struct nfsd_readlinkargs *argp,
 					   struct nfsd_readlinkres *resp)
 {
@@ -132,7 +132,7 @@ nfsd_proc_readlink(struct svc_rqst *rqst
  * Read a portion of a file.
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_read(struct svc_rqst *rqstp, struct nfsd_readargs *argp,
 				       struct nfsd_readres  *resp)
 {
@@ -172,7 +172,7 @@ nfsd_proc_read(struct svc_rqst *rqstp, s
  * Write data to a file
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_write(struct svc_rqst *rqstp, struct nfsd_writeargs *argp,
 					struct nfsd_attrstat  *resp)
 {
@@ -197,7 +197,7 @@ nfsd_proc_write(struct svc_rqst *rqstp, 
  * and the actual create() call in compliance with VFS protocols.
  * N.B. After this call _both_ argp->fh and resp->fh need an fh_put
  */
-static int
+static __be32
 nfsd_proc_create(struct svc_rqst *rqstp, struct nfsd_createargs *argp,
 					 struct nfsd_diropres   *resp)
 {
@@ -348,7 +348,7 @@ done:
 	return nfsd_return_dirop(nfserr, resp);
 }
 
-static int
+static __be32
 nfsd_proc_remove(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 					 void		       *resp)
 {
@@ -363,7 +363,7 @@ nfsd_proc_remove(struct svc_rqst *rqstp,
 	return nfserr;
 }
 
-static int
+static __be32
 nfsd_proc_rename(struct svc_rqst *rqstp, struct nfsd_renameargs *argp,
 				  	 void		        *resp)
 {
@@ -381,7 +381,7 @@ nfsd_proc_rename(struct svc_rqst *rqstp,
 	return nfserr;
 }
 
-static int
+static __be32
 nfsd_proc_link(struct svc_rqst *rqstp, struct nfsd_linkargs *argp,
 				void			    *resp)
 {
@@ -401,7 +401,7 @@ nfsd_proc_link(struct svc_rqst *rqstp, s
 	return nfserr;
 }
 
-static int
+static __be32
 nfsd_proc_symlink(struct svc_rqst *rqstp, struct nfsd_symlinkargs *argp,
 				          void			  *resp)
 {
@@ -430,7 +430,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp
  * Make directory. This operation is not idempotent.
  * N.B. After this call resp->fh needs an fh_put
  */
-static int
+static __be32
 nfsd_proc_mkdir(struct svc_rqst *rqstp, struct nfsd_createargs *argp,
 					struct nfsd_diropres   *resp)
 {
@@ -454,7 +454,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp, 
 /*
  * Remove a directory
  */
-static int
+static __be32
 nfsd_proc_rmdir(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 				 	void		      *resp)
 {
@@ -470,7 +470,7 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp, 
 /*
  * Read a portion of a directory.
  */
-static int
+static __be32
 nfsd_proc_readdir(struct svc_rqst *rqstp, struct nfsd_readdirargs *argp,
 					  struct nfsd_readdirres  *resp)
 {
@@ -509,7 +509,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp
 /*
  * Get file system info
  */
-static int
+static __be32
 nfsd_proc_statfs(struct svc_rqst * rqstp, struct nfsd_fhandle   *argp,
 					  struct nfsd_statfsres *resp)
 {
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 9c9a8ad..965d6c2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -335,7 +335,7 @@ struct svc_version {
 /*
  * RPC procedure info
  */
-typedef int	(*svc_procfunc)(struct svc_rqst *, void *argp, void *resp);
+typedef __be32	(*svc_procfunc)(struct svc_rqst *, void *argp, void *resp);
 struct svc_procedure {
 	svc_procfunc		pc_func;	/* process the request */
 	kxdrproc_t		pc_decode;	/* XDR decode args */
-- 
1.4.2.GIT


