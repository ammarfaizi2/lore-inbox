Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVIJQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVIJQcL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIJQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 12:32:11 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:9448 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVIJQcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 12:32:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hscyiTEV6uY3ZBwwl5jX5bToUMf0mosc5+DBu1a2Q1WdhjCU5zo0J7rGRRwEw1Ad0tNrhnObTLmn5aVkPghgVmRRVvvY6W0Rc3fP+gSwV6NP3imCuXNA+tQnqWhPMxkOOdd7ocI4CqpbiOU7bUaMsG2gtuUdLHHOvGagQDWMLSk=
Date: Sat, 10 Sep 2005 20:42:08 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] lockd: add endian annotations
Message-ID: <20050910164208.GB23850@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also touch sunrpc headers a little. Some functions there weren't called
from net/sunrpc/*

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/lockd/clntlock.c         |    4 +-
 fs/lockd/mon.c              |   12 +++---
 fs/lockd/svc4proc.c         |   52 ++++++++++++++--------------
 fs/lockd/svclock.c          |    8 ++--
 fs/lockd/svcproc.c          |   56 +++++++++++++++---------------
 fs/lockd/svcshare.c         |    4 +-
 fs/lockd/svcsubs.c          |    4 +-
 fs/lockd/xdr.c              |   76 ++++++++++++++++++++---------------------
 fs/lockd/xdr4.c             |   80 ++++++++++++++++++++++----------------------
 include/linux/lockd/lockd.h |   12 +++---
 include/linux/lockd/share.h |    4 +-
 include/linux/lockd/xdr.h   |   26 +++++++-------
 include/linux/lockd/xdr4.h  |   26 +++++++-------
 include/linux/sunrpc/svc.h  |    2 -
 include/linux/sunrpc/xdr.h  |    8 ++--
 15 files changed, 187 insertions(+), 187 deletions(-)

diff -uprN linux-001/fs/lockd/clntlock.c linux-002/fs/lockd/clntlock.c
--- linux-001/fs/lockd/clntlock.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/clntlock.c	2005-09-10 12:21:20.000000000 +0400
@@ -111,11 +111,11 @@ long nlmclnt_block(struct nlm_rqst *req,
 /*
  * The server lockd has called us back to tell us the lock was granted
  */
-u32
+__be32
 nlmclnt_grant(struct nlm_lock *lock)
 {
 	struct nlm_wait	*block;
-	u32 res = nlm_lck_denied;
+	__be32 res = nlm_lck_denied;
 
 	/*
 	 * Look up blocked request based on arguments. 
diff -uprN linux-001/fs/lockd/mon.c linux-002/fs/lockd/mon.c
--- linux-001/fs/lockd/mon.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/mon.c	2005-09-10 12:54:55.000000000 +0400
@@ -135,8 +135,8 @@ out_err:
  * XDR functions for NSM.
  */
 
-static u32 *
-xdr_encode_common(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+static __be32 *
+xdr_encode_common(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	char	buffer[20];
 
@@ -158,7 +158,7 @@ xdr_encode_common(struct rpc_rqst *rqstp
 }
 
 static int
-xdr_encode_mon(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+xdr_encode_mon(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	p = xdr_encode_common(rqstp, p, argp);
 	if (IS_ERR(p))
@@ -172,7 +172,7 @@ xdr_encode_mon(struct rpc_rqst *rqstp, u
 }
 
 static int
-xdr_encode_unmon(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
+xdr_encode_unmon(struct rpc_rqst *rqstp, __be32 *p, struct nsm_args *argp)
 {
 	p = xdr_encode_common(rqstp, p, argp);
 	if (IS_ERR(p))
@@ -182,7 +182,7 @@ xdr_encode_unmon(struct rpc_rqst *rqstp,
 }
 
 static int
-xdr_decode_stat_res(struct rpc_rqst *rqstp, u32 *p, struct nsm_res *resp)
+xdr_decode_stat_res(struct rpc_rqst *rqstp, __be32 *p, struct nsm_res *resp)
 {
 	resp->status = ntohl(*p++);
 	resp->state = ntohl(*p++);
@@ -192,7 +192,7 @@ xdr_decode_stat_res(struct rpc_rqst *rqs
 }
 
 static int
-xdr_decode_stat(struct rpc_rqst *rqstp, u32 *p, struct nsm_res *resp)
+xdr_decode_stat(struct rpc_rqst *rqstp, __be32 *p, struct nsm_res *resp)
 {
 	resp->state = ntohl(*p++);
 	return 0;
diff -uprN linux-001/fs/lockd/svc4proc.c linux-002/fs/lockd/svc4proc.c
--- linux-001/fs/lockd/svc4proc.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/svc4proc.c	2005-09-10 14:07:55.000000000 +0400
@@ -21,20 +21,20 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
-static u32	nlm4svc_callback(struct svc_rqst *, u32, struct nlm_res *);
+static __be32	nlm4svc_callback(struct svc_rqst *, u32, struct nlm_res *);
 static void	nlm4svc_callback_exit(struct rpc_task *);
 
 /*
  * Obtain client and file from arguments
  */
-static u32
+static __be32
 nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 			struct nlm_host **hostp, struct nlm_file **filp)
 {
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
-	u32			error = 0;
+	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
 	if (!nlmsvc_ops)
@@ -71,7 +71,7 @@ no_locks:
 /*
  * NULL: Test for presence of service
  */
-static int
+static __be32
 nlm4svc_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	dprintk("lockd: NULL          called\n");
@@ -81,7 +81,7 @@ nlm4svc_proc_null(struct svc_rqst *rqstp
 /*
  * TEST: Check for conflicting lock
  */
-static int
+static __be32
 nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -110,7 +110,7 @@ nlm4svc_proc_test(struct svc_rqst *rqstp
 	return rpc_success;
 }
 
-static int
+static __be32
 nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -153,7 +153,7 @@ nlm4svc_proc_lock(struct svc_rqst *rqstp
 	return rpc_success;
 }
 
-static int
+static __be32
 nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -186,7 +186,7 @@ nlm4svc_proc_cancel(struct svc_rqst *rqs
 /*
  * UNLOCK: release a lock
  */
-static int
+static __be32
 nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -220,7 +220,7 @@ nlm4svc_proc_unlock(struct svc_rqst *rqs
  * GRANTED: A server calls us to tell that a process' lock request
  * was granted
  */
-static int
+static __be32
 nlm4svc_proc_granted(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -237,12 +237,12 @@ nlm4svc_proc_granted(struct svc_rqst *rq
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
  */
-static int
+static __be32
 nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: TEST_MSG      called\n");
 	memset(&res, 0, sizeof(res));
@@ -252,12 +252,12 @@ nlm4svc_proc_test_msg(struct svc_rqst *r
 	return stat;
 }
 
-static int
+static __be32
 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: LOCK_MSG      called\n");
 	memset(&res, 0, sizeof(res));
@@ -267,12 +267,12 @@ nlm4svc_proc_lock_msg(struct svc_rqst *r
 	return stat;
 }
 
-static int
+static __be32
 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					       void	       *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: CANCEL_MSG    called\n");
 	memset(&res, 0, sizeof(res));
@@ -282,12 +282,12 @@ nlm4svc_proc_cancel_msg(struct svc_rqst 
 	return stat;
 }
 
-static int
+static __be32
 nlm4svc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                void            *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: UNLOCK_MSG    called\n");
 	memset(&res, 0, sizeof(res));
@@ -297,12 +297,12 @@ nlm4svc_proc_unlock_msg(struct svc_rqst 
 	return stat;
 }
 
-static int
+static __be32
 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                 void            *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: GRANTED_MSG   called\n");
 	memset(&res, 0, sizeof(res));
@@ -315,7 +315,7 @@ nlm4svc_proc_granted_msg(struct svc_rqst
 /*
  * SHARE: create a DOS share or alter existing share.
  */
-static int
+static __be32
 nlm4svc_proc_share(struct svc_rqst *rqstp, struct nlm_args *argp,
 				          struct nlm_res  *resp)
 {
@@ -348,7 +348,7 @@ nlm4svc_proc_share(struct svc_rqst *rqst
 /*
  * UNSHARE: Release a DOS share.
  */
-static int
+static __be32
 nlm4svc_proc_unshare(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -381,7 +381,7 @@ nlm4svc_proc_unshare(struct svc_rqst *rq
 /*
  * NM_LOCK: Create an unmonitored lock
  */
-static int
+static __be32
 nlm4svc_proc_nm_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -394,7 +394,7 @@ nlm4svc_proc_nm_lock(struct svc_rqst *rq
 /*
  * FREE_ALL: Release all locks and shares held by client
  */
-static int
+static __be32
 nlm4svc_proc_free_all(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void            *resp)
 {
@@ -412,7 +412,7 @@ nlm4svc_proc_free_all(struct svc_rqst *r
 /*
  * SM_NOTIFY: private callback from statd (not part of official NLM proto)
  */
-static int
+static __be32
 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
@@ -456,7 +456,7 @@ nlm4svc_proc_sm_notify(struct svc_rqst *
 /*
  * client sent a GRANTED_RES, let's remove the associated block
  */
-static int
+static __be32
 nlm4svc_proc_granted_res(struct svc_rqst *rqstp, struct nlm_res  *argp,
                                                 void            *resp)
 {
@@ -474,7 +474,7 @@ nlm4svc_proc_granted_res(struct svc_rqst
 /*
  * This is the generic lockd callback for async RPC calls
  */
-static u32
+static __be32
 nlm4svc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_res *resp)
 {
 	struct nlm_host	*host;
diff -uprN linux-001/fs/lockd/svclock.c linux-002/fs/lockd/svclock.c
--- linux-001/fs/lockd/svclock.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/svclock.c	2005-09-10 12:23:53.000000000 +0400
@@ -294,7 +294,7 @@ nlmsvc_traverse_blocks(struct nlm_host *
  * Attempt to establish a lock, and if it can't be granted, block it
  * if required.
  */
-u32
+__be32
 nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			struct nlm_lock *lock, int wait, struct nlm_cookie *cookie)
 {
@@ -379,7 +379,7 @@ again:
 /*
  * Test for presence of a conflicting lock.
  */
-u32
+__be32
 nlmsvc_testlock(struct nlm_file *file, struct nlm_lock *lock,
 				       struct nlm_lock *conflock)
 {
@@ -412,7 +412,7 @@ nlmsvc_testlock(struct nlm_file *file, s
  * afterwards. In this case the block will still be there, and hence
  * must be removed.
  */
-u32
+__be32
 nlmsvc_unlock(struct nlm_file *file, struct nlm_lock *lock)
 {
 	int	error;
@@ -440,7 +440,7 @@ nlmsvc_unlock(struct nlm_file *file, str
  * be in progress.
  * The calling procedure must check whether the file can be closed.
  */
-u32
+__be32
 nlmsvc_cancel_blocked(struct nlm_file *file, struct nlm_lock *lock)
 {
 	struct nlm_block	*block;
diff -uprN linux-001/fs/lockd/svcproc.c linux-002/fs/lockd/svcproc.c
--- linux-001/fs/lockd/svcproc.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/svcproc.c	2005-09-10 14:10:06.000000000 +0400
@@ -22,12 +22,12 @@
 
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
-static u32	nlmsvc_callback(struct svc_rqst *, u32, struct nlm_res *);
+static __be32	nlmsvc_callback(struct svc_rqst *, u32, struct nlm_res *);
 static void	nlmsvc_callback_exit(struct rpc_task *);
 
 #ifdef CONFIG_LOCKD_V4
-static u32
-cast_to_nlm(u32 status, u32 vers)
+static __be32
+cast_to_nlm(__be32 status, u32 vers)
 {
 	/* Note: status is assumed to be in network byte order !!! */
 	if (vers != 4){
@@ -56,14 +56,14 @@ cast_to_nlm(u32 status, u32 vers)
 /*
  * Obtain client and file from arguments
  */
-static u32
+static __be32
 nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 			struct nlm_host **hostp, struct nlm_file **filp)
 {
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
-	u32			error;
+	__be32			error;
 
 	/* nfsd callbacks must have been installed for this procedure */
 	if (!nlmsvc_ops)
@@ -98,7 +98,7 @@ no_locks:
 /*
  * NULL: Test for presence of service
  */
-static int
+static __be32
 nlmsvc_proc_null(struct svc_rqst *rqstp, void *argp, void *resp)
 {
 	dprintk("lockd: NULL          called\n");
@@ -108,7 +108,7 @@ nlmsvc_proc_null(struct svc_rqst *rqstp,
 /*
  * TEST: Check for conflicting lock
  */
-static int
+static __be32
 nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -138,7 +138,7 @@ nlmsvc_proc_test(struct svc_rqst *rqstp,
 	return rpc_success;
 }
 
-static int
+static __be32
 nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				         struct nlm_res  *resp)
 {
@@ -181,7 +181,7 @@ nlmsvc_proc_lock(struct svc_rqst *rqstp,
 	return rpc_success;
 }
 
-static int
+static __be32
 nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -214,7 +214,7 @@ nlmsvc_proc_cancel(struct svc_rqst *rqst
 /*
  * UNLOCK: release a lock
  */
-static int
+static __be32
 nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				           struct nlm_res  *resp)
 {
@@ -248,7 +248,7 @@ nlmsvc_proc_unlock(struct svc_rqst *rqst
  * GRANTED: A server calls us to tell that a process' lock request
  * was granted
  */
-static int
+static __be32
 nlmsvc_proc_granted(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -265,12 +265,12 @@ nlmsvc_proc_granted(struct svc_rqst *rqs
  * because we send the callback before the reply proper. I hope this
  * doesn't break any clients.
  */
-static int
+static __be32
 nlmsvc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: TEST_MSG      called\n");
 	memset(&res, 0, sizeof(res));
@@ -280,12 +280,12 @@ nlmsvc_proc_test_msg(struct svc_rqst *rq
 	return stat;
 }
 
-static int
+static __be32
 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void	     *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: LOCK_MSG      called\n");
 	memset(&res, 0, sizeof(res));
@@ -295,12 +295,12 @@ nlmsvc_proc_lock_msg(struct svc_rqst *rq
 	return stat;
 }
 
-static int
+static __be32
 nlmsvc_proc_cancel_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
 					       void	       *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: CANCEL_MSG    called\n");
 	memset(&res, 0, sizeof(res));
@@ -310,12 +310,12 @@ nlmsvc_proc_cancel_msg(struct svc_rqst *
 	return stat;
 }
 
-static int
+static __be32
 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                void            *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: UNLOCK_MSG    called\n");
 	memset(&res, 0, sizeof(res));
@@ -325,12 +325,12 @@ nlmsvc_proc_unlock_msg(struct svc_rqst *
 	return stat;
 }
 
-static int
+static __be32
 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp, struct nlm_args *argp,
                                                 void            *resp)
 {
 	struct nlm_res	res;
-	u32		stat;
+	__be32		stat;
 
 	dprintk("lockd: GRANTED_MSG   called\n");
 	memset(&res, 0, sizeof(res));
@@ -343,7 +343,7 @@ nlmsvc_proc_granted_msg(struct svc_rqst 
 /*
  * SHARE: create a DOS share or alter existing share.
  */
-static int
+static __be32
 nlmsvc_proc_share(struct svc_rqst *rqstp, struct nlm_args *argp,
 				          struct nlm_res  *resp)
 {
@@ -376,7 +376,7 @@ nlmsvc_proc_share(struct svc_rqst *rqstp
 /*
  * UNSHARE: Release a DOS share.
  */
-static int
+static __be32
 nlmsvc_proc_unshare(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -409,7 +409,7 @@ nlmsvc_proc_unshare(struct svc_rqst *rqs
 /*
  * NM_LOCK: Create an unmonitored lock
  */
-static int
+static __be32
 nlmsvc_proc_nm_lock(struct svc_rqst *rqstp, struct nlm_args *argp,
 				            struct nlm_res  *resp)
 {
@@ -422,7 +422,7 @@ nlmsvc_proc_nm_lock(struct svc_rqst *rqs
 /*
  * FREE_ALL: Release all locks and shares held by client
  */
-static int
+static __be32
 nlmsvc_proc_free_all(struct svc_rqst *rqstp, struct nlm_args *argp,
 					     void            *resp)
 {
@@ -440,7 +440,7 @@ nlmsvc_proc_free_all(struct svc_rqst *rq
 /*
  * SM_NOTIFY: private callback from statd (not part of official NLM proto)
  */
-static int
+static __be32
 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp, struct nlm_reboot *argp,
 					      void	        *resp)
 {
@@ -482,7 +482,7 @@ nlmsvc_proc_sm_notify(struct svc_rqst *r
 /*
  * client sent a GRANTED_RES, let's remove the associated block
  */
-static int
+static __be32
 nlmsvc_proc_granted_res(struct svc_rqst *rqstp, struct nlm_res  *argp,
                                                 void            *resp)
 {
@@ -498,7 +498,7 @@ nlmsvc_proc_granted_res(struct svc_rqst 
 /*
  * This is the generic lockd callback for async RPC calls
  */
-static u32
+static __be32
 nlmsvc_callback(struct svc_rqst *rqstp, u32 proc, struct nlm_res *resp)
 {
 	struct nlm_host	*host;
diff -uprN linux-001/fs/lockd/svcshare.c linux-002/fs/lockd/svcshare.c
--- linux-001/fs/lockd/svcshare.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/svcshare.c	2005-09-10 12:24:50.000000000 +0400
@@ -23,7 +23,7 @@ nlm_cmp_owner(struct nlm_share *share, s
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
-u32
+__be32
 nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 			struct nlm_args *argp)
 {
@@ -64,7 +64,7 @@ update:
 /*
  * Delete a share.
  */
-u32
+__be32
 nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 			struct nlm_args *argp)
 {
diff -uprN linux-001/fs/lockd/svcsubs.c linux-002/fs/lockd/svcsubs.c
--- linux-001/fs/lockd/svcsubs.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/svcsubs.c	2005-09-10 13:40:44.000000000 +0400
@@ -48,13 +48,13 @@ static inline unsigned int file_hash(str
  * This is not quite right, but for now, we assume the client performs
  * the proper R/W checking.
  */
-u32
+__be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 					struct nfs_fh *f)
 {
 	struct nlm_file	*file;
 	unsigned int	hash;
-	u32		nfserr;
+	__be32		nfserr;
 	u32		*fhp = (u32*)f->data;
 
 	dprintk("lockd: nlm_file_lookup(%08x %08x %08x %08x %08x %08x)\n",
diff -uprN linux-001/fs/lockd/xdr.c linux-002/fs/lockd/xdr.c
--- linux-001/fs/lockd/xdr.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/xdr.c	2005-09-10 13:48:34.000000000 +0400
@@ -44,7 +44,7 @@ loff_t_to_s32(loff_t offset)
 /*
  * XDR functions for basic NLM types
  */
-static inline u32 *nlm_decode_cookie(u32 *p, struct nlm_cookie *c)
+static inline __be32 *nlm_decode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	unsigned int	len;
 
@@ -70,8 +70,8 @@ static inline u32 *nlm_decode_cookie(u32
 	return p;
 }
 
-static inline u32 *
-nlm_encode_cookie(u32 *p, struct nlm_cookie *c)
+static inline __be32 *
+nlm_encode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	*p++ = htonl(c->len);
 	memcpy(p, c->data, c->len);
@@ -79,8 +79,8 @@ nlm_encode_cookie(u32 *p, struct nlm_coo
 	return p;
 }
 
-static inline u32 *
-nlm_decode_fh(u32 *p, struct nfs_fh *f)
+static inline __be32 *
+nlm_decode_fh(__be32 *p, struct nfs_fh *f)
 {
 	unsigned int	len;
 
@@ -96,8 +96,8 @@ nlm_decode_fh(u32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32 *
-nlm_encode_fh(u32 *p, struct nfs_fh *f)
+static inline __be32 *
+nlm_encode_fh(__be32 *p, struct nfs_fh *f)
 {
 	*p++ = htonl(NFS2_FHSIZE);
 	memcpy(p, f->data, NFS2_FHSIZE);
@@ -107,20 +107,20 @@ nlm_encode_fh(u32 *p, struct nfs_fh *f)
 /*
  * Encode and decode owner handle
  */
-static inline u32 *
-nlm_decode_oh(u32 *p, struct xdr_netobj *oh)
+static inline __be32 *
+nlm_decode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_decode_netobj(p, oh);
 }
 
-static inline u32 *
-nlm_encode_oh(u32 *p, struct xdr_netobj *oh)
+static inline __be32 *
+nlm_encode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_encode_netobj(p, oh);
 }
 
-static inline u32 *
-nlm_decode_lock(u32 *p, struct nlm_lock *lock)
+static inline __be32 *
+nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	s32			start, len, end;
@@ -153,8 +153,8 @@ nlm_decode_lock(u32 *p, struct nlm_lock 
 /*
  * Encode a lock as part of an NLM call
  */
-static u32 *
-nlm_encode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm_encode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s32			start, len;
@@ -184,8 +184,8 @@ nlm_encode_lock(u32 *p, struct nlm_lock 
 /*
  * Encode result of a TEST/TEST_MSG call
  */
-static u32 *
-nlm_encode_testres(u32 *p, struct nlm_res *resp)
+static __be32 *
+nlm_encode_testres(__be32 *p, struct nlm_res *resp)
 {
 	s32		start, len;
 
@@ -221,7 +221,7 @@ nlm_encode_testres(u32 *p, struct nlm_re
  * First, the server side XDR functions
  */
 int
-nlmsvc_decode_testargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -238,7 +238,7 @@ nlmsvc_decode_testargs(struct svc_rqst *
 }
 
 int
-nlmsvc_encode_testres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_testres(p, resp)))
 		return 0;
@@ -246,7 +246,7 @@ nlmsvc_encode_testres(struct svc_rqst *r
 }
 
 int
-nlmsvc_decode_lockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -266,7 +266,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *
 }
 
 int
-nlmsvc_decode_cancargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -282,7 +282,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *
 }
 
 int
-nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	if (!(p = nlm_decode_cookie(p, &argp->cookie))
 	 || !(p = nlm_decode_lock(p, &argp->lock)))
@@ -292,7 +292,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst
 }
 
 int
-nlmsvc_decode_shareargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -312,7 +312,7 @@ nlmsvc_decode_shareargs(struct svc_rqst 
 }
 
 int
-nlmsvc_encode_shareres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_shareres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -322,7 +322,7 @@ nlmsvc_encode_shareres(struct svc_rqst *
 }
 
 int
-nlmsvc_encode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -331,7 +331,7 @@ nlmsvc_encode_res(struct svc_rqst *rqstp
 }
 
 int
-nlmsvc_decode_notify(struct svc_rqst *rqstp, u32 *p, struct nlm_args *argp)
+nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p, struct nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -343,7 +343,7 @@ nlmsvc_decode_notify(struct svc_rqst *rq
 }
 
 int
-nlmsvc_decode_reboot(struct svc_rqst *rqstp, u32 *p, struct nlm_reboot *argp)
+nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p, struct nlm_reboot *argp)
 {
 	if (!(p = xdr_decode_string_inplace(p, &argp->mon, &argp->len, SM_MAXSTRLEN)))
 		return 0;
@@ -356,7 +356,7 @@ nlmsvc_decode_reboot(struct svc_rqst *rq
 }
 
 int
-nlmsvc_decode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return 0;
@@ -365,13 +365,13 @@ nlmsvc_decode_res(struct svc_rqst *rqstp
 }
 
 int
-nlmsvc_decode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
 int
-nlmsvc_encode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
@@ -388,7 +388,7 @@ nlmclt_decode_void(struct rpc_rqst *req,
 #endif
 
 static int
-nlmclt_encode_testargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_testargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -402,7 +402,7 @@ nlmclt_encode_testargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_decode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_decode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -436,7 +436,7 @@ nlmclt_decode_testres(struct rpc_rqst *r
 
 
 static int
-nlmclt_encode_lockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_lockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -453,7 +453,7 @@ nlmclt_encode_lockargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_encode_cancargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_cancargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -468,7 +468,7 @@ nlmclt_encode_cancargs(struct rpc_rqst *
 }
 
 static int
-nlmclt_encode_unlockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlmclt_encode_unlockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -481,7 +481,7 @@ nlmclt_encode_unlockargs(struct rpc_rqst
 }
 
 static int
-nlmclt_encode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_encode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -491,7 +491,7 @@ nlmclt_encode_res(struct rpc_rqst *req, 
 }
 
 static int
-nlmclt_encode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_encode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_encode_testres(p, resp)))
 		return -EIO;
@@ -500,7 +500,7 @@ nlmclt_encode_testres(struct rpc_rqst *r
 }
 
 static int
-nlmclt_decode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlmclt_decode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm_decode_cookie(p, &resp->cookie)))
 		return -EIO;
diff -uprN linux-001/fs/lockd/xdr4.c linux-002/fs/lockd/xdr4.c
--- linux-001/fs/lockd/xdr4.c	2005-09-10 10:52:22.000000000 +0400
+++ linux-002/fs/lockd/xdr4.c	2005-09-10 13:59:33.000000000 +0400
@@ -44,8 +44,8 @@ loff_t_to_s64(loff_t offset)
 /*
  * XDR functions for basic NLM types
  */
-static u32 *
-nlm4_decode_cookie(u32 *p, struct nlm_cookie *c)
+static __be32 *
+nlm4_decode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	unsigned int	len;
 
@@ -71,8 +71,8 @@ nlm4_decode_cookie(u32 *p, struct nlm_co
 	return p;
 }
 
-static u32 *
-nlm4_encode_cookie(u32 *p, struct nlm_cookie *c)
+static __be32 *
+nlm4_encode_cookie(__be32 *p, struct nlm_cookie *c)
 {
 	*p++ = htonl(c->len);
 	memcpy(p, c->data, c->len);
@@ -80,8 +80,8 @@ nlm4_encode_cookie(u32 *p, struct nlm_co
 	return p;
 }
 
-static u32 *
-nlm4_decode_fh(u32 *p, struct nfs_fh *f)
+static __be32 *
+nlm4_decode_fh(__be32 *p, struct nfs_fh *f)
 {
 	memset(f->data, 0, sizeof(f->data));
 	f->size = ntohl(*p++);
@@ -95,8 +95,8 @@ nlm4_decode_fh(u32 *p, struct nfs_fh *f)
 	return p + XDR_QUADLEN(f->size);
 }
 
-static u32 *
-nlm4_encode_fh(u32 *p, struct nfs_fh *f)
+static __be32 *
+nlm4_encode_fh(__be32 *p, struct nfs_fh *f)
 {
 	*p++ = htonl(f->size);
 	if (f->size) p[XDR_QUADLEN(f->size)-1] = 0; /* don't leak anything */
@@ -107,20 +107,20 @@ nlm4_encode_fh(u32 *p, struct nfs_fh *f)
 /*
  * Encode and decode owner handle
  */
-static u32 *
-nlm4_decode_oh(u32 *p, struct xdr_netobj *oh)
+static __be32 *
+nlm4_decode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_decode_netobj(p, oh);
 }
 
-static u32 *
-nlm4_encode_oh(u32 *p, struct xdr_netobj *oh)
+static __be32 *
+nlm4_encode_oh(__be32 *p, struct xdr_netobj *oh)
 {
 	return xdr_encode_netobj(p, oh);
 }
 
-static u32 *
-nlm4_decode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s64			len, start, end;
@@ -152,8 +152,8 @@ nlm4_decode_lock(u32 *p, struct nlm_lock
 /*
  * Encode a lock as part of an NLM call
  */
-static u32 *
-nlm4_encode_lock(u32 *p, struct nlm_lock *lock)
+static __be32 *
+nlm4_encode_lock(__be32 *p, struct nlm_lock *lock)
 {
 	struct file_lock	*fl = &lock->fl;
 	__s64			start, len;
@@ -184,8 +184,8 @@ nlm4_encode_lock(u32 *p, struct nlm_lock
 /*
  * Encode result of a TEST/TEST_MSG call
  */
-static u32 *
-nlm4_encode_testres(u32 *p, struct nlm_res *resp)
+static __be32 *
+nlm4_encode_testres(__be32 *p, struct nlm_res *resp)
 {
 	s64		start, len;
 
@@ -226,7 +226,7 @@ nlm4_encode_testres(u32 *p, struct nlm_r
  * First, the server side XDR functions
  */
 int
-nlm4svc_decode_testargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -243,7 +243,7 @@ nlm4svc_decode_testargs(struct svc_rqst 
 }
 
 int
-nlm4svc_encode_testres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_testres(p, resp)))
 		return 0;
@@ -251,7 +251,7 @@ nlm4svc_encode_testres(struct svc_rqst *
 }
 
 int
-nlm4svc_decode_lockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_lockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -271,7 +271,7 @@ nlm4svc_decode_lockargs(struct svc_rqst 
 }
 
 int
-nlm4svc_decode_cancargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_cancargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	u32	exclusive;
 
@@ -287,7 +287,7 @@ nlm4svc_decode_cancargs(struct svc_rqst 
 }
 
 int
-nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	if (!(p = nlm4_decode_cookie(p, &argp->cookie))
 	 || !(p = nlm4_decode_lock(p, &argp->lock)))
@@ -297,7 +297,7 @@ nlm4svc_decode_unlockargs(struct svc_rqs
 }
 
 int
-nlm4svc_decode_shareargs(struct svc_rqst *rqstp, u32 *p, nlm_args *argp)
+nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -317,7 +317,7 @@ nlm4svc_decode_shareargs(struct svc_rqst
 }
 
 int
-nlm4svc_encode_shareres(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_shareres(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -327,7 +327,7 @@ nlm4svc_encode_shareres(struct svc_rqst 
 }
 
 int
-nlm4svc_encode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return 0;
@@ -336,7 +336,7 @@ nlm4svc_encode_res(struct svc_rqst *rqst
 }
 
 int
-nlm4svc_decode_notify(struct svc_rqst *rqstp, u32 *p, struct nlm_args *argp)
+nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p, struct nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -348,7 +348,7 @@ nlm4svc_decode_notify(struct svc_rqst *r
 }
 
 int
-nlm4svc_decode_reboot(struct svc_rqst *rqstp, u32 *p, struct nlm_reboot *argp)
+nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p, struct nlm_reboot *argp)
 {
 	if (!(p = xdr_decode_string_inplace(p, &argp->mon, &argp->len, SM_MAXSTRLEN)))
 		return 0;
@@ -359,7 +359,7 @@ nlm4svc_decode_reboot(struct svc_rqst *r
 }
 
 int
-nlm4svc_decode_res(struct svc_rqst *rqstp, u32 *p, struct nlm_res *resp)
+nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return 0;
@@ -368,13 +368,13 @@ nlm4svc_decode_res(struct svc_rqst *rqst
 }
 
 int
-nlm4svc_decode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
 int
-nlm4svc_encode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
@@ -384,14 +384,14 @@ nlm4svc_encode_void(struct svc_rqst *rqs
  */
 #ifdef NLMCLNT_SUPPORT_SHARES
 static int
-nlm4clt_decode_void(struct rpc_rqst *req, u32 *p, void *ptr)
+nlm4clt_decode_void(struct rpc_rqst *req, __be32 *p, void *ptr)
 {
 	return 0;
 }
 #endif
 
 static int
-nlm4clt_encode_testargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_testargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -405,7 +405,7 @@ nlm4clt_encode_testargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_decode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_decode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -439,7 +439,7 @@ nlm4clt_decode_testres(struct rpc_rqst *
 
 
 static int
-nlm4clt_encode_lockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_lockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -456,7 +456,7 @@ nlm4clt_encode_lockargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_encode_cancargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_cancargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -471,7 +471,7 @@ nlm4clt_encode_cancargs(struct rpc_rqst 
 }
 
 static int
-nlm4clt_encode_unlockargs(struct rpc_rqst *req, u32 *p, nlm_args *argp)
+nlm4clt_encode_unlockargs(struct rpc_rqst *req, __be32 *p, nlm_args *argp)
 {
 	struct nlm_lock	*lock = &argp->lock;
 
@@ -484,7 +484,7 @@ nlm4clt_encode_unlockargs(struct rpc_rqs
 }
 
 static int
-nlm4clt_encode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_encode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_cookie(p, &resp->cookie)))
 		return -EIO;
@@ -494,7 +494,7 @@ nlm4clt_encode_res(struct rpc_rqst *req,
 }
 
 static int
-nlm4clt_encode_testres(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_encode_testres(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_encode_testres(p, resp)))
 		return -EIO;
@@ -503,7 +503,7 @@ nlm4clt_encode_testres(struct rpc_rqst *
 }
 
 static int
-nlm4clt_decode_res(struct rpc_rqst *req, u32 *p, struct nlm_res *resp)
+nlm4clt_decode_res(struct rpc_rqst *req, __be32 *p, struct nlm_res *resp)
 {
 	if (!(p = nlm4_decode_cookie(p, &resp->cookie)))
 		return -EIO;
diff -uprN linux-001/include/linux/lockd/lockd.h linux-002/include/linux/lockd/lockd.h
--- linux-001/include/linux/lockd/lockd.h	2005-09-10 10:52:28.000000000 +0400
+++ linux-002/include/linux/lockd/lockd.h	2005-09-10 13:39:35.000000000 +0400
@@ -149,7 +149,7 @@ int		  nlmclnt_prepare_block(struct nlm_
 void		  nlmclnt_finish_block(struct nlm_rqst *req);
 long		  nlmclnt_block(struct nlm_rqst *req, long timeout);
 int		  nlmclnt_cancel(struct nlm_host *, struct file_lock *);
-u32		  nlmclnt_grant(struct nlm_lock *);
+__be32		  nlmclnt_grant(struct nlm_lock *);
 void		  nlmclnt_recovery(struct nlm_host *, u32);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
 int		  nlmclnt_setgrantargs(struct nlm_rqst *, struct nlm_lock *);
@@ -173,12 +173,12 @@ extern struct nlm_host *nlm_find_client(
  * Server-side lock handling
  */
 int		  nlmsvc_async_call(struct nlm_rqst *, u32, rpc_action);
-u32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
+__be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
 					struct nlm_lock *, int, struct nlm_cookie *);
-u32		  nlmsvc_unlock(struct nlm_file *, struct nlm_lock *);
-u32		  nlmsvc_testlock(struct nlm_file *, struct nlm_lock *,
+__be32		  nlmsvc_unlock(struct nlm_file *, struct nlm_lock *);
+__be32		  nlmsvc_testlock(struct nlm_file *, struct nlm_lock *,
 					struct nlm_lock *);
-u32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
+__be32		  nlmsvc_cancel_blocked(struct nlm_file *, struct nlm_lock *);
 unsigned long	  nlmsvc_retry_blocked(void);
 int		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
 					int action);
@@ -187,7 +187,7 @@ void	  nlmsvc_grant_reply(struct svc_rqs
 /*
  * File handling for the server personality
  */
-u32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
+__be32		  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
 					struct nfs_fh *);
 void		  nlm_release_file(struct nlm_file *);
 void		  nlmsvc_mark_resources(void);
diff -uprN linux-001/include/linux/lockd/share.h linux-002/include/linux/lockd/share.h
--- linux-001/include/linux/lockd/share.h	2005-09-10 10:52:28.000000000 +0400
+++ linux-002/include/linux/lockd/share.h	2005-09-10 12:24:55.000000000 +0400
@@ -21,9 +21,9 @@ struct nlm_share {
 	u32			s_mode;		/* deny mode */
 };
 
-u32	nlmsvc_share_file(struct nlm_host *, struct nlm_file *,
+__be32	nlmsvc_share_file(struct nlm_host *, struct nlm_file *,
 					       struct nlm_args *);
-u32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
+__be32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
 					       struct nlm_args *);
 int	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *, int);
 
diff -uprN linux-001/include/linux/lockd/xdr.h linux-002/include/linux/lockd/xdr.h
--- linux-001/include/linux/lockd/xdr.h	2005-09-10 10:52:28.000000000 +0400
+++ linux-002/include/linux/lockd/xdr.h	2005-09-10 13:47:51.000000000 +0400
@@ -85,19 +85,19 @@ struct nlm_reboot {
  */
 #define NLMSVC_XDRSIZE		sizeof(struct nlm_args)
 
-int	nlmsvc_decode_testargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_testres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_lockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_cancargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_unlockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_encode_void(struct svc_rqst *, u32 *, void *);
-int	nlmsvc_decode_void(struct svc_rqst *, u32 *, void *);
-int	nlmsvc_decode_shareargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_encode_shareres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlmsvc_decode_notify(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlmsvc_decode_reboot(struct svc_rqst *, u32 *, struct nlm_reboot *);
+int	nlmsvc_decode_testargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_testres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_lockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_cancargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_unlockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_encode_void(struct svc_rqst *, __be32 *, void *);
+int	nlmsvc_decode_void(struct svc_rqst *, __be32 *, void *);
+int	nlmsvc_decode_shareargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlmsvc_decode_notify(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlmsvc_decode_reboot(struct svc_rqst *, __be32 *, struct nlm_reboot *);
 /*
 int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
 int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
diff -uprN linux-001/include/linux/lockd/xdr4.h linux-002/include/linux/lockd/xdr4.h
--- linux-001/include/linux/lockd/xdr4.h	2005-09-10 10:52:28.000000000 +0400
+++ linux-002/include/linux/lockd/xdr4.h	2005-09-10 13:56:52.000000000 +0400
@@ -23,19 +23,19 @@
 
 
 
-int	nlm4svc_decode_testargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_testres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_lockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_cancargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_unlockargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_res(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_encode_void(struct svc_rqst *, u32 *, void *);
-int	nlm4svc_decode_void(struct svc_rqst *, u32 *, void *);
-int	nlm4svc_decode_shareargs(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_encode_shareres(struct svc_rqst *, u32 *, struct nlm_res *);
-int	nlm4svc_decode_notify(struct svc_rqst *, u32 *, struct nlm_args *);
-int	nlm4svc_decode_reboot(struct svc_rqst *, u32 *, struct nlm_reboot *);
+int	nlm4svc_decode_testargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_testres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_lockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_cancargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_unlockargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_res(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_encode_void(struct svc_rqst *, __be32 *, void *);
+int	nlm4svc_decode_void(struct svc_rqst *, __be32 *, void *);
+int	nlm4svc_decode_shareargs(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *, struct nlm_res *);
+int	nlm4svc_decode_notify(struct svc_rqst *, __be32 *, struct nlm_args *);
+int	nlm4svc_decode_reboot(struct svc_rqst *, __be32 *, struct nlm_reboot *);
 /*
 int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
 int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
diff -uprN linux-001/include/linux/sunrpc/svc.h linux-002/include/linux/sunrpc/svc.h
--- linux-001/include/linux/sunrpc/svc.h	2005-09-10 12:10:29.000000000 +0400
+++ linux-002/include/linux/sunrpc/svc.h	2005-09-10 13:43:05.000000000 +0400
@@ -184,7 +184,7 @@ struct svc_rqst {
  * Check buffer bounds after decoding arguments
  */
 static inline int
-xdr_argsize_check(struct svc_rqst *rqstp, u32 *p)
+xdr_argsize_check(struct svc_rqst *rqstp, __be32 *p)
 {
 	char *cp = (char *)p;
 	struct kvec *vec = &rqstp->rq_arg.head[0];
diff -uprN linux-001/include/linux/sunrpc/xdr.h linux-002/include/linux/sunrpc/xdr.h
--- linux-001/include/linux/sunrpc/xdr.h	2005-09-10 11:59:48.000000000 +0400
+++ linux-002/include/linux/sunrpc/xdr.h	2005-09-10 13:51:59.000000000 +0400
@@ -109,16 +109,16 @@ static inline __be32 *xdr_encode_array(_
 /*
  * Decode 64bit quantities (NFSv3 support)
  */
-static inline u32 *
-xdr_encode_hyper(u32 *p, __u64 val)
+static inline __be32 *
+xdr_encode_hyper(__be32 *p, __u64 val)
 {
 	*p++ = htonl(val >> 32);
 	*p++ = htonl(val & 0xFFFFFFFF);
 	return p;
 }
 
-static inline u32 *
-xdr_decode_hyper(u32 *p, __u64 *valp)
+static inline __be32 *
+xdr_decode_hyper(__be32 *p, __u64 *valp)
 {
 	*valp  = ((__u64) ntohl(*p++)) << 32;
 	*valp |= ntohl(*p++);

