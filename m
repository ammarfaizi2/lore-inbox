Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWJJDQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWJJDQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWJJDPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:15:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36269 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964911AbWJJDOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:32 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] nfsd: misc endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX84d-0004IC-De@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:14:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/export.c            |    4 ++--
 fs/nfsd/lockd.c             |    2 +-
 fs/nfsd/nfs4callback.c      |    2 +-
 fs/nfsd/nfs4state.c         |    4 ++--
 fs/nfsd/nfscache.c          |    8 ++++----
 fs/nfsd/nfssvc.c            |    2 +-
 include/linux/nfsd/cache.h  |    6 +++---
 include/linux/nfsd/export.h |    2 +-
 include/linux/nfsd/nfsd.h   |    2 +-
 include/linux/nfsd/nfsfh.h  |    2 +-
 include/linux/nfsd/state.h  |    2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e13fa23..f37df46 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1148,12 +1148,12 @@ exp_find(struct auth_domain *clp, int fs
  * for a given NFSv4 client.   The root is defined to be the
  * export point with fsid==0
  */
-int
+__be32
 exp_pseudoroot(struct auth_domain *clp, struct svc_fh *fhp,
 	       struct cache_req *creq)
 {
 	struct svc_export *exp;
-	int rv;
+	__be32 rv;
 	u32 fsidv[2];
 
 	mk_fsid_v1(fsidv, 0);
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 7b889ff..7ab9c1a 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -25,7 +25,7 @@ #define NFSDDBG_FACILITY		NFSDDBG_LOCKD
 static u32
 nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
 {
-	u32		nfserr;
+	__be32		nfserr;
 	struct svc_fh	fh;
 
 	/* must initialize before using! but maxsize doesn't matter */
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 75314ed..8da6c13 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -461,7 +461,7 @@ nfs4_cb_null(struct rpc_task *task, void
 {
 	struct nfs4_client *clp = (struct nfs4_client *)task->tk_msg.rpc_argp;
 	struct nfs4_callback *cb = &clp->cl_callback;
-	u32 addr = htonl(cb->cb_addr);
+	__be32 addr = htonl(cb->cb_addr);
 
 	dprintk("NFSD: nfs4_cb_null task->tk_status %d\n", task->tk_status);
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ae1d477..2e468c9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -713,7 +713,7 @@ out_err:
 __be32
 nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_setclientid *setclid)
 {
-	u32 			ip_addr = rqstp->rq_addr.sin_addr.s_addr;
+	__be32 			ip_addr = rqstp->rq_addr.sin_addr.s_addr;
 	struct xdr_netobj 	clname = { 
 		.len = setclid->se_namelen,
 		.data = setclid->se_name,
@@ -878,7 +878,7 @@ out:
 __be32
 nfsd4_setclientid_confirm(struct svc_rqst *rqstp, struct nfsd4_setclientid_confirm *setclientid_confirm)
 {
-	u32 ip_addr = rqstp->rq_addr.sin_addr.s_addr;
+	__be32 ip_addr = rqstp->rq_addr.sin_addr.s_addr;
 	struct nfs4_client *conf, *unconf;
 	nfs4_verifier confirm = setclientid_confirm->sc_confirm; 
 	clientid_t * clid = &setclientid_confirm->sc_clientid;
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index fdf7cf3..6100bbe 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -29,7 +29,7 @@ #include <linux/nfsd/cache.h>
  */
 #define CACHESIZE		1024
 #define HASHSIZE		64
-#define REQHASH(xid)		((((xid) >> 24) ^ (xid)) & (HASHSIZE-1))
+#define REQHASH(xid)		(((((__force __u32)xid) >> 24) ^ ((__force __u32)xid)) & (HASHSIZE-1))
 
 static struct hlist_head *	hash_list;
 static struct list_head 	lru_head;
@@ -127,8 +127,8 @@ nfsd_cache_lookup(struct svc_rqst *rqstp
 	struct hlist_node	*hn;
 	struct hlist_head 	*rh;
 	struct svc_cacherep	*rp;
-	u32			xid = rqstp->rq_xid,
-				proto =  rqstp->rq_prot,
+	__be32			xid = rqstp->rq_xid;
+	u32			proto =  rqstp->rq_prot,
 				vers = rqstp->rq_vers,
 				proc = rqstp->rq_proc;
 	unsigned long		age;
@@ -258,7 +258,7 @@ found_entry:
  * In this case, nfsd_cache_update is called with statp == NULL.
  */
 void
-nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, u32 *statp)
+nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 {
 	struct svc_cacherep *rp;
 	struct kvec	*resv = &rqstp->rq_res.head[0], *cachv;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8067118..0aaccb0 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -491,7 +491,7 @@ out:
 }
 
 int
-nfsd_dispatch(struct svc_rqst *rqstp, u32 *statp)
+nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	struct svc_procedure	*proc;
 	kxdrproc_t		xdr;
diff --git a/include/linux/nfsd/cache.h b/include/linux/nfsd/cache.h
index c3a3557..007480c 100644
--- a/include/linux/nfsd/cache.h
+++ b/include/linux/nfsd/cache.h
@@ -26,14 +26,14 @@ struct svc_cacherep {
 				c_type,		/* status, buffer */
 				c_secure : 1;	/* req came from port < 1024 */
 	struct sockaddr_in	c_addr;
-	u32			c_xid;
+	__be32			c_xid;
 	u32			c_prot;
 	u32			c_proc;
 	u32			c_vers;
 	unsigned long		c_timestamp;
 	union {
 		struct kvec	u_vec;
-		u32		u_status;
+		__be32		u_status;
 	}			c_u;
 };
 
@@ -75,7 +75,7 @@ #define RC_DELAY		(HZ/5)
 void	nfsd_cache_init(void);
 void	nfsd_cache_shutdown(void);
 int	nfsd_cache_lookup(struct svc_rqst *, int);
-void	nfsd_cache_update(struct svc_rqst *, int, u32 *);
+void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
 
 #endif /* __KERNEL__ */
 #endif /* NFSCACHE_H */
diff --git a/include/linux/nfsd/export.h b/include/linux/nfsd/export.h
index 27666f5..045e38c 100644
--- a/include/linux/nfsd/export.h
+++ b/include/linux/nfsd/export.h
@@ -117,7 +117,7 @@ struct svc_export *	exp_parent(struct au
 				   struct cache_req *reqp);
 int			exp_rootfh(struct auth_domain *, 
 					char *path, struct knfsd_fh *, int maxsize);
-int			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
+__be32			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
 __be32			nfserrno(int errno);
 
 extern struct cache_detail svc_export_cache;
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index 19a3c83..68d29b6 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -64,7 +64,7 @@ extern struct svc_serv		*nfsd_serv;
  * Function prototypes.
  */
 int		nfsd_svc(unsigned short port, int nrservs);
-int		nfsd_dispatch(struct svc_rqst *rqstp, u32 *statp);
+int		nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp);
 
 /* nfsd/vfs.c */
 int		fh_lock_parent(struct svc_fh *, struct dentry *);
diff --git a/include/linux/nfsd/nfsfh.h b/include/linux/nfsd/nfsfh.h
index 749bad1..f3b51d6 100644
--- a/include/linux/nfsd/nfsfh.h
+++ b/include/linux/nfsd/nfsfh.h
@@ -157,7 +157,7 @@ #ifdef CONFIG_NFSD_V3
 	__u64			fh_post_size;	/* i_size */
 	unsigned long		fh_post_blocks; /* i_blocks */
 	unsigned long		fh_post_blksize;/* i_blksize */
-	__u32			fh_post_rdev[2];/* i_rdev */
+	__be32			fh_post_rdev[2];/* i_rdev */
 	struct timespec		fh_post_atime;	/* i_atime */
 	struct timespec		fh_post_mtime;	/* i_mtime */
 	struct timespec		fh_post_ctime;	/* i_ctime */
diff --git a/include/linux/nfsd/state.h b/include/linux/nfsd/state.h
index a597e2e..c3673f4 100644
--- a/include/linux/nfsd/state.h
+++ b/include/linux/nfsd/state.h
@@ -125,7 +125,7 @@ struct nfs4_client {
 	char                    cl_recdir[HEXDIR_LEN]; /* recovery dir */
 	nfs4_verifier		cl_verifier; 	/* generated by client */
 	time_t                  cl_time;        /* time of last lease renewal */
-	u32			cl_addr; 	/* client ipaddress */
+	__be32			cl_addr; 	/* client ipaddress */
 	struct svc_cred		cl_cred; 	/* setclientid principal */
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
-- 
1.4.2.GIT


