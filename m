Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWG0Uxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWG0Uxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWG0UxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750799AbWG0Uw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:52:58 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/30] NFS: Rename struct nfs4_client to struct nfs_client [try #11]
Date: Thu, 27 Jul 2006 21:52:37 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205236.8443.27909.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct nfs4_client to struct nfs_client so that it can become the basis
for a general client record for NFS2 and NFS3 in addition to NFS4.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/callback.c         |    2 +-
 fs/nfs/callback_proc.c    |    4 ++--
 fs/nfs/delegation.c       |   24 +++++++++++-----------
 fs/nfs/delegation.h       |   10 +++++----
 fs/nfs/idmap.c            |   12 +++++------
 fs/nfs/nfs4_fs.h          |   30 ++++++++++++++-------------
 fs/nfs/nfs4proc.c         |   32 ++++++++++++++---------------
 fs/nfs/nfs4renewd.c       |    8 ++++---
 fs/nfs/nfs4state.c        |   50 +++++++++++++++++++++++----------------------
 fs/nfs/nfs4xdr.c          |   18 ++++++++--------
 fs/nfs/super.c            |    4 ++--
 include/linux/nfs_fs_sb.h |    2 +-
 include/linux/nfs_idmap.h |   14 ++++++-------
 13 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index b1f7dc4..1b596b6 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -167,7 +167,7 @@ void nfs_callback_down(void)
 static int nfs_callback_authenticate(struct svc_rqst *rqstp)
 {
 	struct in_addr *addr = &rqstp->rq_addr.sin_addr;
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 
 	/* Don't talk to strangers */
 	clp = nfs4_find_client(addr);
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 7719483..55d6e2e 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -15,7 +15,7 @@ #define NFSDBG_FACILITY NFSDBG_CALLBACK
  
 unsigned nfs4_callback_getattr(struct cb_getattrargs *args, struct cb_getattrres *res)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	struct nfs_delegation *delegation;
 	struct nfs_inode *nfsi;
 	struct inode *inode;
@@ -56,7 +56,7 @@ out:
 
 unsigned nfs4_callback_recall(struct cb_recallargs *args, void *dummy)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	struct inode *inode;
 	unsigned res;
 	
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 9540a31..5a1105c 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -114,7 +114,7 @@ void nfs_inode_reclaim_delegation(struct
  */
 int nfs_inode_set_delegation(struct inode *inode, struct rpc_cred *cred, struct nfs_openres *res)
 {
-	struct nfs4_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int status = 0;
@@ -176,7 +176,7 @@ static void nfs_msync_inode(struct inode
  */
 int __nfs_inode_return_delegation(struct inode *inode)
 {
-	struct nfs4_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int res = 0;
@@ -208,7 +208,7 @@ int __nfs_inode_return_delegation(struct
  */
 void nfs_return_all_delegations(struct super_block *sb)
 {
-	struct nfs4_client *clp = NFS_SB(sb)->nfs4_state;
+	struct nfs_client *clp = NFS_SB(sb)->nfs4_state;
 	struct nfs_delegation *delegation;
 	struct inode *inode;
 
@@ -232,7 +232,7 @@ restart:
 
 int nfs_do_expire_all_delegations(void *ptr)
 {
-	struct nfs4_client *clp = ptr;
+	struct nfs_client *clp = ptr;
 	struct nfs_delegation *delegation;
 	struct inode *inode;
 
@@ -258,7 +258,7 @@ out:
 	module_put_and_exit(0);
 }
 
-void nfs_expire_all_delegations(struct nfs4_client *clp)
+void nfs_expire_all_delegations(struct nfs_client *clp)
 {
 	struct task_struct *task;
 
@@ -276,7 +276,7 @@ void nfs_expire_all_delegations(struct n
 /*
  * Return all delegations following an NFS4ERR_CB_PATH_DOWN error.
  */
-void nfs_handle_cb_pathdown(struct nfs4_client *clp)
+void nfs_handle_cb_pathdown(struct nfs_client *clp)
 {
 	struct nfs_delegation *delegation;
 	struct inode *inode;
@@ -299,7 +299,7 @@ restart:
 
 struct recall_threadargs {
 	struct inode *inode;
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	const nfs4_stateid *stateid;
 
 	struct completion started;
@@ -310,7 +310,7 @@ static int recall_thread(void *data)
 {
 	struct recall_threadargs *args = (struct recall_threadargs *)data;
 	struct inode *inode = igrab(args->inode);
-	struct nfs4_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 
@@ -371,7 +371,7 @@ out_module_put:
 /*
  * Retrieve the inode associated with a delegation
  */
-struct inode *nfs_delegation_find_inode(struct nfs4_client *clp, const struct nfs_fh *fhandle)
+struct inode *nfs_delegation_find_inode(struct nfs_client *clp, const struct nfs_fh *fhandle)
 {
 	struct nfs_delegation *delegation;
 	struct inode *res = NULL;
@@ -389,7 +389,7 @@ struct inode *nfs_delegation_find_inode(
 /*
  * Mark all delegations as needing to be reclaimed
  */
-void nfs_delegation_mark_reclaim(struct nfs4_client *clp)
+void nfs_delegation_mark_reclaim(struct nfs_client *clp)
 {
 	struct nfs_delegation *delegation;
 	spin_lock(&clp->cl_lock);
@@ -401,7 +401,7 @@ void nfs_delegation_mark_reclaim(struct 
 /*
  * Reap all unclaimed delegations after reboot recovery is done
  */
-void nfs_delegation_reap_unclaimed(struct nfs4_client *clp)
+void nfs_delegation_reap_unclaimed(struct nfs_client *clp)
 {
 	struct nfs_delegation *delegation, *n;
 	LIST_HEAD(head);
@@ -423,7 +423,7 @@ void nfs_delegation_reap_unclaimed(struc
 
 int nfs4_copy_delegation_stateid(nfs4_stateid *dst, struct inode *inode)
 {
-	struct nfs4_client *clp = NFS_SERVER(inode)->nfs4_state;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs4_state;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
 	int res = 0;
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 3858694..2cfd4b2 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -29,13 +29,13 @@ void nfs_inode_reclaim_delegation(struct
 int __nfs_inode_return_delegation(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
 
-struct inode *nfs_delegation_find_inode(struct nfs4_client *clp, const struct nfs_fh *fhandle);
+struct inode *nfs_delegation_find_inode(struct nfs_client *clp, const struct nfs_fh *fhandle);
 void nfs_return_all_delegations(struct super_block *sb);
-void nfs_expire_all_delegations(struct nfs4_client *clp);
-void nfs_handle_cb_pathdown(struct nfs4_client *clp);
+void nfs_expire_all_delegations(struct nfs_client *clp);
+void nfs_handle_cb_pathdown(struct nfs_client *clp);
 
-void nfs_delegation_mark_reclaim(struct nfs4_client *clp);
-void nfs_delegation_reap_unclaimed(struct nfs4_client *clp);
+void nfs_delegation_mark_reclaim(struct nfs_client *clp);
+void nfs_delegation_reap_unclaimed(struct nfs_client *clp);
 
 /* NFSv4 delegation-related procedures */
 int nfs4_proc_delegreturn(struct inode *inode, struct rpc_cred *cred, const nfs4_stateid *stateid);
diff --git a/fs/nfs/idmap.c b/fs/nfs/idmap.c
index 447ae91..b151053 100644
--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -109,7 +109,7 @@ static struct rpc_pipe_ops idmap_upcall_
 };
 
 void
-nfs_idmap_new(struct nfs4_client *clp)
+nfs_idmap_new(struct nfs_client *clp)
 {
 	struct idmap *idmap;
 
@@ -138,7 +138,7 @@ nfs_idmap_new(struct nfs4_client *clp)
 }
 
 void
-nfs_idmap_delete(struct nfs4_client *clp)
+nfs_idmap_delete(struct nfs_client *clp)
 {
 	struct idmap *idmap = clp->cl_idmap;
 
@@ -493,27 +493,27 @@ static unsigned int fnvhash32(const void
 	return (hash);
 }
 
-int nfs_map_name_to_uid(struct nfs4_client *clp, const char *name, size_t namelen, __u32 *uid)
+int nfs_map_name_to_uid(struct nfs_client *clp, const char *name, size_t namelen, __u32 *uid)
 {
 	struct idmap *idmap = clp->cl_idmap;
 
 	return nfs_idmap_id(idmap, &idmap->idmap_user_hash, name, namelen, uid);
 }
 
-int nfs_map_group_to_gid(struct nfs4_client *clp, const char *name, size_t namelen, __u32 *uid)
+int nfs_map_group_to_gid(struct nfs_client *clp, const char *name, size_t namelen, __u32 *uid)
 {
 	struct idmap *idmap = clp->cl_idmap;
 
 	return nfs_idmap_id(idmap, &idmap->idmap_group_hash, name, namelen, uid);
 }
 
-int nfs_map_uid_to_name(struct nfs4_client *clp, __u32 uid, char *buf)
+int nfs_map_uid_to_name(struct nfs_client *clp, __u32 uid, char *buf)
 {
 	struct idmap *idmap = clp->cl_idmap;
 
 	return nfs_idmap_name(idmap, &idmap->idmap_user_hash, uid, buf);
 }
-int nfs_map_gid_to_group(struct nfs4_client *clp, __u32 uid, char *buf)
+int nfs_map_gid_to_group(struct nfs_client *clp, __u32 uid, char *buf)
 {
 	struct idmap *idmap = clp->cl_idmap;
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 9a10286..4e334cb 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -43,9 +43,9 @@ enum nfs4_client_state {
 };
 
 /*
- * The nfs4_client identifies our client state to the server.
+ * The nfs_client identifies our client state to the server.
  */
-struct nfs4_client {
+struct nfs_client {
 	struct list_head	cl_servers;	/* Global list of servers */
 	struct in_addr		cl_addr;	/* Server identifier */
 	u64			cl_clientid;	/* constant */
@@ -127,7 +127,7 @@ static inline void nfs_confirm_seqid(str
 struct nfs4_state_owner {
 	spinlock_t	     so_lock;
 	struct list_head     so_list;	 /* per-clientid list of state_owners */
-	struct nfs4_client   *so_client;
+	struct nfs_client    *so_client;
 	u32                  so_id;      /* 32-bit identifier, unique */
 	atomic_t	     so_count;
 
@@ -210,10 +210,10 @@ extern ssize_t nfs4_listxattr(struct den
 
 /* nfs4proc.c */
 extern int nfs4_map_errors(int err);
-extern int nfs4_proc_setclientid(struct nfs4_client *, u32, unsigned short, struct rpc_cred *);
-extern int nfs4_proc_setclientid_confirm(struct nfs4_client *, struct rpc_cred *);
-extern int nfs4_proc_async_renew(struct nfs4_client *, struct rpc_cred *);
-extern int nfs4_proc_renew(struct nfs4_client *, struct rpc_cred *);
+extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, struct rpc_cred *);
+extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct rpc_cred *);
+extern int nfs4_proc_async_renew(struct nfs_client *, struct rpc_cred *);
+extern int nfs4_proc_renew(struct nfs_client *, struct rpc_cred *);
 extern int nfs4_do_close(struct inode *inode, struct nfs4_state *state);
 extern struct dentry *nfs4_atomic_open(struct inode *, struct dentry *, struct nameidata *);
 extern int nfs4_open_revalidate(struct inode *, struct dentry *, int, struct nameidata *);
@@ -231,19 +231,19 @@ extern const u32 nfs4_fsinfo_bitmap[2];
 extern const u32 nfs4_fs_locations_bitmap[2];
 
 /* nfs4renewd.c */
-extern void nfs4_schedule_state_renewal(struct nfs4_client *);
+extern void nfs4_schedule_state_renewal(struct nfs_client *);
 extern void nfs4_renewd_prepare_shutdown(struct nfs_server *);
-extern void nfs4_kill_renewd(struct nfs4_client *);
+extern void nfs4_kill_renewd(struct nfs_client *);
 extern void nfs4_renew_state(void *);
 
 /* nfs4state.c */
 extern void init_nfsv4_state(struct nfs_server *);
 extern void destroy_nfsv4_state(struct nfs_server *);
-extern struct nfs4_client *nfs4_get_client(struct in_addr *);
-extern void nfs4_put_client(struct nfs4_client *clp);
-extern struct nfs4_client *nfs4_find_client(struct in_addr *);
-struct rpc_cred *nfs4_get_renew_cred(struct nfs4_client *clp);
-extern u32 nfs4_alloc_lockowner_id(struct nfs4_client *);
+extern struct nfs_client *nfs4_get_client(struct in_addr *);
+extern void nfs4_put_client(struct nfs_client *clp);
+extern struct nfs_client *nfs4_find_client(struct in_addr *);
+struct rpc_cred *nfs4_get_renew_cred(struct nfs_client *clp);
+extern u32 nfs4_alloc_lockowner_id(struct nfs_client *);
 
 extern struct nfs4_state_owner * nfs4_get_state_owner(struct nfs_server *, struct rpc_cred *);
 extern void nfs4_put_state_owner(struct nfs4_state_owner *);
@@ -252,7 +252,7 @@ extern struct nfs4_state * nfs4_get_open
 extern void nfs4_put_open_state(struct nfs4_state *);
 extern void nfs4_close_state(struct nfs4_state *, mode_t);
 extern void nfs4_state_set_mode_locked(struct nfs4_state *, mode_t);
-extern void nfs4_schedule_state_recovery(struct nfs4_client *);
+extern void nfs4_schedule_state_recovery(struct nfs_client *);
 extern void nfs4_put_lock_state(struct nfs4_lock_state *lsp);
 extern int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl);
 extern void nfs4_copy_stateid(nfs4_stateid *, struct nfs4_state *, fl_owner_t);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6ee97f..73f72a2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -64,7 +64,7 @@ static int nfs4_do_fsinfo(struct nfs_ser
 static int nfs4_async_handle_error(struct rpc_task *, const struct nfs_server *);
 static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry);
 static int nfs4_handle_exception(const struct nfs_server *server, int errorcode, struct nfs4_exception *exception);
-static int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs4_client *clp);
+static int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs_client *clp);
 
 /* Prevent leaks of NFSv4 errors into userland */
 int nfs4_map_errors(int err)
@@ -195,7 +195,7 @@ static void nfs4_setup_readdir(u64 cooki
 
 static void renew_lease(const struct nfs_server *server, unsigned long timestamp)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	spin_lock(&clp->cl_lock);
 	if (time_before(clp->cl_last_renewal,timestamp))
 		clp->cl_last_renewal = timestamp;
@@ -792,7 +792,7 @@ out:
 
 int nfs4_recover_expired_lease(struct nfs_server *server)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 
 	if (test_and_clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state))
 		nfs4_schedule_state_recovery(clp);
@@ -867,7 +867,7 @@ static int _nfs4_open_delegated(struct i
 {
 	struct nfs_delegation *delegation;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs4_state_owner *sp = NULL;
 	struct nfs4_state *state = NULL;
@@ -953,7 +953,7 @@ static int _nfs4_do_open(struct inode *d
 	struct nfs4_state_owner  *sp;
 	struct nfs4_state     *state = NULL;
 	struct nfs_server       *server = NFS_SERVER(dir);
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	struct nfs4_opendata *opendata;
 	int                     status;
 
@@ -2521,7 +2521,7 @@ static void nfs4_proc_commit_setup(struc
  */
 static void nfs4_renew_done(struct rpc_task *task, void *data)
 {
-	struct nfs4_client *clp = (struct nfs4_client *)task->tk_msg.rpc_argp;
+	struct nfs_client *clp = (struct nfs_client *)task->tk_msg.rpc_argp;
 	unsigned long timestamp = (unsigned long)data;
 
 	if (task->tk_status < 0) {
@@ -2543,7 +2543,7 @@ static const struct rpc_call_ops nfs4_re
 	.rpc_call_done = nfs4_renew_done,
 };
 
-int nfs4_proc_async_renew(struct nfs4_client *clp, struct rpc_cred *cred)
+int nfs4_proc_async_renew(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
@@ -2555,7 +2555,7 @@ int nfs4_proc_async_renew(struct nfs4_cl
 			&nfs4_renew_ops, (void *)jiffies);
 }
 
-int nfs4_proc_renew(struct nfs4_client *clp, struct rpc_cred *cred)
+int nfs4_proc_renew(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_RENEW],
@@ -2766,7 +2766,7 @@ static int nfs4_proc_set_acl(struct inod
 static int
 nfs4_async_handle_error(struct rpc_task *task, const struct nfs_server *server)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 
 	if (!clp || task->tk_status >= 0)
 		return 0;
@@ -2803,7 +2803,7 @@ static int nfs4_wait_bit_interruptible(v
 	return 0;
 }
 
-static int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs4_client *clp)
+static int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs_client *clp)
 {
 	sigset_t oldset;
 	int res;
@@ -2846,7 +2846,7 @@ static int nfs4_delay(struct rpc_clnt *c
  */
 int nfs4_handle_exception(const struct nfs_server *server, int errorcode, struct nfs4_exception *exception)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	int ret = errorcode;
 
 	exception->retry = 0;
@@ -2873,7 +2873,7 @@ int nfs4_handle_exception(const struct n
 	return nfs4_map_errors(ret);
 }
 
-int nfs4_proc_setclientid(struct nfs4_client *clp, u32 program, unsigned short port, struct rpc_cred *cred)
+int nfs4_proc_setclientid(struct nfs_client *clp, u32 program, unsigned short port, struct rpc_cred *cred)
 {
 	nfs4_verifier sc_verifier;
 	struct nfs4_setclientid setclientid = {
@@ -2920,7 +2920,7 @@ int nfs4_proc_setclientid(struct nfs4_cl
 	return status;
 }
 
-static int _nfs4_proc_setclientid_confirm(struct nfs4_client *clp, struct rpc_cred *cred)
+static int _nfs4_proc_setclientid_confirm(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	struct nfs_fsinfo fsinfo;
 	struct rpc_message msg = {
@@ -2944,7 +2944,7 @@ static int _nfs4_proc_setclientid_confir
 	return status;
 }
 
-int nfs4_proc_setclientid_confirm(struct nfs4_client *clp, struct rpc_cred *cred)
+int nfs4_proc_setclientid_confirm(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	long timeout;
 	int err;
@@ -3081,7 +3081,7 @@ static int _nfs4_proc_getlk(struct nfs4_
 {
 	struct inode *inode = state->inode;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	struct nfs_lockt_args arg = {
 		.fh = NFS_FH(inode),
 		.fl = request,
@@ -3488,7 +3488,7 @@ static int nfs4_lock_expired(struct nfs4
 
 static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 {
-	struct nfs4_client *clp = state->owner->so_client;
+	struct nfs_client *clp = state->owner->so_client;
 	unsigned char fl_flags = request->fl_flags;
 	int status;
 
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 5d764d8..2087640 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -61,7 +61,7 @@ #define NFSDBG_FACILITY	NFSDBG_PROC
 void
 nfs4_renew_state(void *data)
 {
-	struct nfs4_client *clp = (struct nfs4_client *)data;
+	struct nfs_client *clp = (struct nfs_client *)data;
 	struct rpc_cred *cred;
 	long lease, timeout;
 	unsigned long last, now;
@@ -108,7 +108,7 @@ out:
 
 /* Must be called with clp->cl_sem locked for writes */
 void
-nfs4_schedule_state_renewal(struct nfs4_client *clp)
+nfs4_schedule_state_renewal(struct nfs_client *clp)
 {
 	long timeout;
 
@@ -127,7 +127,7 @@ nfs4_schedule_state_renewal(struct nfs4_
 void
 nfs4_renewd_prepare_shutdown(struct nfs_server *server)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 
 	if (!clp)
 		return;
@@ -140,7 +140,7 @@ nfs4_renewd_prepare_shutdown(struct nfs_
 
 /* Must be called with clp->cl_sem locked for writes */
 void
-nfs4_kill_renewd(struct nfs4_client *clp)
+nfs4_kill_renewd(struct nfs_client *clp)
 {
 	down_read(&clp->cl_sem);
 	if (!list_empty(&clp->cl_superblocks)) {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 090a36b..c0b6439 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -83,10 +83,10 @@ destroy_nfsv4_state(struct nfs_server *s
  * Since these are allocated/deallocated very rarely, we don't
  * bother putting them in a slab cache...
  */
-static struct nfs4_client *
+static struct nfs_client *
 nfs4_alloc_client(struct in_addr *addr)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 
 	if (nfs_callback_up() < 0)
 		return NULL;
@@ -111,7 +111,7 @@ nfs4_alloc_client(struct in_addr *addr)
 }
 
 static void
-nfs4_free_client(struct nfs4_client *clp)
+nfs4_free_client(struct nfs_client *clp)
 {
 	struct nfs4_state_owner *sp;
 
@@ -130,9 +130,9 @@ nfs4_free_client(struct nfs4_client *clp
 	nfs_callback_down();
 }
 
-static struct nfs4_client *__nfs4_find_client(struct in_addr *addr)
+static struct nfs_client *__nfs4_find_client(struct in_addr *addr)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	list_for_each_entry(clp, &nfs4_clientid_list, cl_servers) {
 		if (memcmp(&clp->cl_addr, addr, sizeof(clp->cl_addr)) == 0) {
 			atomic_inc(&clp->cl_count);
@@ -142,19 +142,19 @@ static struct nfs4_client *__nfs4_find_c
 	return NULL;
 }
 
-struct nfs4_client *nfs4_find_client(struct in_addr *addr)
+struct nfs_client *nfs4_find_client(struct in_addr *addr)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	spin_lock(&state_spinlock);
 	clp = __nfs4_find_client(addr);
 	spin_unlock(&state_spinlock);
 	return clp;
 }
 
-struct nfs4_client *
+struct nfs_client *
 nfs4_get_client(struct in_addr *addr)
 {
-	struct nfs4_client *clp, *new = NULL;
+	struct nfs_client *clp, *new = NULL;
 
 	spin_lock(&state_spinlock);
 	for (;;) {
@@ -180,7 +180,7 @@ nfs4_get_client(struct in_addr *addr)
 }
 
 void
-nfs4_put_client(struct nfs4_client *clp)
+nfs4_put_client(struct nfs_client *clp)
 {
 	if (!atomic_dec_and_lock(&clp->cl_count, &state_spinlock))
 		return;
@@ -192,7 +192,7 @@ nfs4_put_client(struct nfs4_client *clp)
 	nfs4_free_client(clp);
 }
 
-static int nfs4_init_client(struct nfs4_client *clp, struct rpc_cred *cred)
+static int nfs4_init_client(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	int status = nfs4_proc_setclientid(clp, NFS4_CALLBACK,
 			nfs_callback_tcpport, cred);
@@ -204,13 +204,13 @@ static int nfs4_init_client(struct nfs4_
 }
 
 u32
-nfs4_alloc_lockowner_id(struct nfs4_client *clp)
+nfs4_alloc_lockowner_id(struct nfs_client *clp)
 {
 	return clp->cl_lockowner_id ++;
 }
 
 static struct nfs4_state_owner *
-nfs4_client_grab_unused(struct nfs4_client *clp, struct rpc_cred *cred)
+nfs4_client_grab_unused(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	struct nfs4_state_owner *sp = NULL;
 
@@ -224,7 +224,7 @@ nfs4_client_grab_unused(struct nfs4_clie
 	return sp;
 }
 
-struct rpc_cred *nfs4_get_renew_cred(struct nfs4_client *clp)
+struct rpc_cred *nfs4_get_renew_cred(struct nfs_client *clp)
 {
 	struct nfs4_state_owner *sp;
 	struct rpc_cred *cred = NULL;
@@ -238,7 +238,7 @@ struct rpc_cred *nfs4_get_renew_cred(str
 	return cred;
 }
 
-struct rpc_cred *nfs4_get_setclientid_cred(struct nfs4_client *clp)
+struct rpc_cred *nfs4_get_setclientid_cred(struct nfs_client *clp)
 {
 	struct nfs4_state_owner *sp;
 
@@ -251,7 +251,7 @@ struct rpc_cred *nfs4_get_setclientid_cr
 }
 
 static struct nfs4_state_owner *
-nfs4_find_state_owner(struct nfs4_client *clp, struct rpc_cred *cred)
+nfs4_find_state_owner(struct nfs_client *clp, struct rpc_cred *cred)
 {
 	struct nfs4_state_owner *sp, *res = NULL;
 
@@ -294,7 +294,7 @@ nfs4_alloc_state_owner(void)
 void
 nfs4_drop_state_owner(struct nfs4_state_owner *sp)
 {
-	struct nfs4_client *clp = sp->so_client;
+	struct nfs_client *clp = sp->so_client;
 	spin_lock(&clp->cl_lock);
 	list_del_init(&sp->so_list);
 	spin_unlock(&clp->cl_lock);
@@ -306,7 +306,7 @@ nfs4_drop_state_owner(struct nfs4_state_
  */
 struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *server, struct rpc_cred *cred)
 {
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	struct nfs4_state_owner *sp, *new;
 
 	get_rpccred(cred);
@@ -337,7 +337,7 @@ struct nfs4_state_owner *nfs4_get_state_
  */
 void nfs4_put_state_owner(struct nfs4_state_owner *sp)
 {
-	struct nfs4_client *clp = sp->so_client;
+	struct nfs_client *clp = sp->so_client;
 	struct rpc_cred *cred = sp->so_cred;
 
 	if (!atomic_dec_and_lock(&sp->so_count, &clp->cl_lock))
@@ -540,7 +540,7 @@ __nfs4_find_lock_state(struct nfs4_state
 static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t fl_owner)
 {
 	struct nfs4_lock_state *lsp;
-	struct nfs4_client *clp = state->owner->so_client;
+	struct nfs_client *clp = state->owner->so_client;
 
 	lsp = kzalloc(sizeof(*lsp), GFP_KERNEL);
 	if (lsp == NULL)
@@ -752,7 +752,7 @@ out:
 
 static int reclaimer(void *);
 
-static inline void nfs4_clear_recover_bit(struct nfs4_client *clp)
+static inline void nfs4_clear_recover_bit(struct nfs_client *clp)
 {
 	smp_mb__before_clear_bit();
 	clear_bit(NFS4CLNT_STATE_RECOVER, &clp->cl_state);
@@ -764,7 +764,7 @@ static inline void nfs4_clear_recover_bi
 /*
  * State recovery routine
  */
-static void nfs4_recover_state(struct nfs4_client *clp)
+static void nfs4_recover_state(struct nfs_client *clp)
 {
 	struct task_struct *task;
 
@@ -782,7 +782,7 @@ static void nfs4_recover_state(struct nf
 /*
  * Schedule a state recovery attempt
  */
-void nfs4_schedule_state_recovery(struct nfs4_client *clp)
+void nfs4_schedule_state_recovery(struct nfs_client *clp)
 {
 	if (!clp)
 		return;
@@ -879,7 +879,7 @@ out_err:
 	return status;
 }
 
-static void nfs4_state_mark_reclaim(struct nfs4_client *clp)
+static void nfs4_state_mark_reclaim(struct nfs_client *clp)
 {
 	struct nfs4_state_owner *sp;
 	struct nfs4_state *state;
@@ -903,7 +903,7 @@ static void nfs4_state_mark_reclaim(stru
 
 static int reclaimer(void *ptr)
 {
-	struct nfs4_client *clp = ptr;
+	struct nfs_client *clp = ptr;
 	struct nfs4_state_owner *sp;
 	struct nfs4_state_recovery_ops *ops;
 	struct rpc_cred *cred;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 14377f2..44ea44c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1160,7 +1160,7 @@ static int encode_rename(struct xdr_stre
 	return 0;
 }
 
-static int encode_renew(struct xdr_stream *xdr, const struct nfs4_client *client_stateid)
+static int encode_renew(struct xdr_stream *xdr, const struct nfs_client *client_stateid)
 {
 	uint32_t *p;
 
@@ -1246,7 +1246,7 @@ static int encode_setclientid(struct xdr
 	return 0;
 }
 
-static int encode_setclientid_confirm(struct xdr_stream *xdr, const struct nfs4_client *client_state)
+static int encode_setclientid_confirm(struct xdr_stream *xdr, const struct nfs_client *client_state)
 {
         uint32_t *p;
 
@@ -1945,7 +1945,7 @@ static int nfs4_xdr_enc_server_caps(stru
 /*
  * a RENEW request
  */
-static int nfs4_xdr_enc_renew(struct rpc_rqst *req, uint32_t *p, struct nfs4_client *clp)
+static int nfs4_xdr_enc_renew(struct rpc_rqst *req, uint32_t *p, struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1975,7 +1975,7 @@ static int nfs4_xdr_enc_setclientid(stru
 /*
  * a SETCLIENTID_CONFIRM request
  */
-static int nfs4_xdr_enc_setclientid_confirm(struct rpc_rqst *req, uint32_t *p, struct nfs4_client *clp)
+static int nfs4_xdr_enc_setclientid_confirm(struct rpc_rqst *req, uint32_t *p, struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -2132,7 +2132,7 @@ static int decode_op_hdr(struct xdr_stre
 }
 
 /* Dummy routine */
-static int decode_ace(struct xdr_stream *xdr, void *ace, struct nfs4_client *clp)
+static int decode_ace(struct xdr_stream *xdr, void *ace, struct nfs_client *clp)
 {
 	uint32_t *p;
 	unsigned int strlen;
@@ -2636,7 +2636,7 @@ static int decode_attr_nlink(struct xdr_
 	return 0;
 }
 
-static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_client *clp, int32_t *uid)
+static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_client *clp, int32_t *uid)
 {
 	uint32_t len, *p;
 
@@ -2660,7 +2660,7 @@ static int decode_attr_owner(struct xdr_
 	return 0;
 }
 
-static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_client *clp, int32_t *gid)
+static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_client *clp, int32_t *gid)
 {
 	uint32_t len, *p;
 
@@ -3564,7 +3564,7 @@ static int decode_setattr(struct xdr_str
 	return 0;
 }
 
-static int decode_setclientid(struct xdr_stream *xdr, struct nfs4_client *clp)
+static int decode_setclientid(struct xdr_stream *xdr, struct nfs_client *clp)
 {
 	uint32_t *p;
 	uint32_t opnum;
@@ -4334,7 +4334,7 @@ static int nfs4_xdr_dec_renew(struct rpc
  * a SETCLIENTID request
  */
 static int nfs4_xdr_dec_setclientid(struct rpc_rqst *req, uint32_t *p,
-		struct nfs4_client *clp)
+		struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 1c20ff0..b9a7c2b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1094,7 +1094,7 @@ #ifdef CONFIG_NFS_V4
 static struct rpc_clnt *nfs4_create_client(struct nfs_server *server,
 	struct rpc_timeout *timeparms, int proto, rpc_authflavor_t flavor)
 {
-	struct nfs4_client *clp;
+	struct nfs_client *clp;
 	struct rpc_xprt *xprt = NULL;
 	struct rpc_clnt *clnt = NULL;
 	int err = -EIO;
@@ -1411,7 +1411,7 @@ static inline char *nfs4_dup_path(const 
 static struct super_block *nfs4_clone_sb(struct nfs_server *server, struct nfs_clone_mount *data)
 {
 	const struct dentry *dentry = data->dentry;
-	struct nfs4_client *clp = server->nfs4_state;
+	struct nfs_client *clp = server->nfs4_state;
 	struct super_block *sb;
 
 	server->fsid = data->fattr->fsid;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 6b4a13c..4db90df 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -43,7 +43,7 @@ #ifdef CONFIG_NFS_V4
 	 */
 	char			ip_addr[16];
 	char *			mnt_path;
-	struct nfs4_client *	nfs4_state;	/* all NFSv4 state starts here */
+	struct nfs_client *	nfs4_state;	/* all NFSv4 state starts here */
 	struct list_head	nfs4_siblings;	/* List of other nfs_server structs
 						 * that share the same clientid
 						 */
diff --git a/include/linux/nfs_idmap.h b/include/linux/nfs_idmap.h
index 102e560..678fe68 100644
--- a/include/linux/nfs_idmap.h
+++ b/include/linux/nfs_idmap.h
@@ -62,15 +62,15 @@ struct idmap_msg {
 #ifdef __KERNEL__
 
 /* Forward declaration to make this header independent of others */
-struct nfs4_client;
+struct nfs_client;
 
-void nfs_idmap_new(struct nfs4_client *);
-void nfs_idmap_delete(struct nfs4_client *);
+void nfs_idmap_new(struct nfs_client *);
+void nfs_idmap_delete(struct nfs_client *);
 
-int nfs_map_name_to_uid(struct nfs4_client *, const char *, size_t, __u32 *);
-int nfs_map_group_to_gid(struct nfs4_client *, const char *, size_t, __u32 *);
-int nfs_map_uid_to_name(struct nfs4_client *, __u32, char *);
-int nfs_map_gid_to_group(struct nfs4_client *, __u32, char *);
+int nfs_map_name_to_uid(struct nfs_client *, const char *, size_t, __u32 *);
+int nfs_map_group_to_gid(struct nfs_client *, const char *, size_t, __u32 *);
+int nfs_map_uid_to_name(struct nfs_client *, __u32, char *);
+int nfs_map_gid_to_group(struct nfs_client *, __u32, char *);
 
 extern unsigned int nfs_idmap_cache_timeout;
 #endif /* __KERNEL__ */
