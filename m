Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWJJDLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWJJDLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWJJDLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:11:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47520 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932988AbWJJDLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/25] xdr annotations: NFSv2
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX81O-0004Ak-Vy@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on-the-wire data is big-endian

[in large part pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs2xdr.c |   74 +++++++++++++++++++++++++++---------------------------
 1 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index b49501f..1d801e3 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -66,15 +66,15 @@ #define NFS_statfsres_sz	(1+NFS_info_sz)
 /*
  * Common NFS XDR functions as inlines
  */
-static inline u32 *
-xdr_encode_fhandle(u32 *p, struct nfs_fh *fhandle)
+static inline __be32 *
+xdr_encode_fhandle(__be32 *p, struct nfs_fh *fhandle)
 {
 	memcpy(p, fhandle->data, NFS2_FHSIZE);
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32 *
-xdr_decode_fhandle(u32 *p, struct nfs_fh *fhandle)
+static inline __be32 *
+xdr_decode_fhandle(__be32 *p, struct nfs_fh *fhandle)
 {
 	/* NFSv2 handles have a fixed length */
 	fhandle->size = NFS2_FHSIZE;
@@ -82,8 +82,8 @@ xdr_decode_fhandle(u32 *p, struct nfs_fh
 	return p + XDR_QUADLEN(NFS2_FHSIZE);
 }
 
-static inline u32*
-xdr_encode_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_encode_time(__be32 *p, struct timespec *timep)
 {
 	*p++ = htonl(timep->tv_sec);
 	/* Convert nanoseconds into microseconds */
@@ -91,8 +91,8 @@ xdr_encode_time(u32 *p, struct timespec 
 	return p;
 }
 
-static inline u32*
-xdr_encode_current_server_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_encode_current_server_time(__be32 *p, struct timespec *timep)
 {
 	/*
 	 * Passing the invalid value useconds=1000000 is a
@@ -108,8 +108,8 @@ xdr_encode_current_server_time(u32 *p, s
 	return p;
 }
 
-static inline u32*
-xdr_decode_time(u32 *p, struct timespec *timep)
+static inline __be32*
+xdr_decode_time(__be32 *p, struct timespec *timep)
 {
 	timep->tv_sec = ntohl(*p++);
 	/* Convert microseconds into nanoseconds */
@@ -117,8 +117,8 @@ xdr_decode_time(u32 *p, struct timespec 
 	return p;
 }
 
-static u32 *
-xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr)
+static __be32 *
+xdr_decode_fattr(__be32 *p, struct nfs_fattr *fattr)
 {
 	u32 rdev;
 	fattr->type = (enum nfs_ftype) ntohl(*p++);
@@ -146,10 +146,10 @@ xdr_decode_fattr(u32 *p, struct nfs_fatt
 	return p;
 }
 
-static inline u32 *
-xdr_encode_sattr(u32 *p, struct iattr *attr)
+static inline __be32 *
+xdr_encode_sattr(__be32 *p, struct iattr *attr)
 {
-	const u32 not_set = __constant_htonl(0xFFFFFFFF);
+	const __be32 not_set = __constant_htonl(0xFFFFFFFF);
 
 	*p++ = (attr->ia_valid & ATTR_MODE) ? htonl(attr->ia_mode) : not_set;
 	*p++ = (attr->ia_valid & ATTR_UID) ? htonl(attr->ia_uid) : not_set;
@@ -184,7 +184,7 @@ xdr_encode_sattr(u32 *p, struct iattr *a
  * GETATTR, READLINK, STATFS
  */
 static int
-nfs_xdr_fhandle(struct rpc_rqst *req, u32 *p, struct nfs_fh *fh)
+nfs_xdr_fhandle(struct rpc_rqst *req, __be32 *p, struct nfs_fh *fh)
 {
 	p = xdr_encode_fhandle(p, fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -195,7 +195,7 @@ nfs_xdr_fhandle(struct rpc_rqst *req, u3
  * Encode SETATTR arguments
  */
 static int
-nfs_xdr_sattrargs(struct rpc_rqst *req, u32 *p, struct nfs_sattrargs *args)
+nfs_xdr_sattrargs(struct rpc_rqst *req, __be32 *p, struct nfs_sattrargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_sattr(p, args->sattr);
@@ -208,7 +208,7 @@ nfs_xdr_sattrargs(struct rpc_rqst *req, 
  * LOOKUP, REMOVE, RMDIR
  */
 static int
-nfs_xdr_diropargs(struct rpc_rqst *req, u32 *p, struct nfs_diropargs *args)
+nfs_xdr_diropargs(struct rpc_rqst *req, __be32 *p, struct nfs_diropargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -222,7 +222,7 @@ nfs_xdr_diropargs(struct rpc_rqst *req, 
  * exactly to the page we want to fetch.
  */
 static int
-nfs_xdr_readargs(struct rpc_rqst *req, u32 *p, struct nfs_readargs *args)
+nfs_xdr_readargs(struct rpc_rqst *req, __be32 *p, struct nfs_readargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -246,7 +246,7 @@ nfs_xdr_readargs(struct rpc_rqst *req, u
  * Decode READ reply
  */
 static int
-nfs_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
+nfs_xdr_readres(struct rpc_rqst *req, __be32 *p, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
 	int	status, count, recvd, hdrlen;
@@ -286,7 +286,7 @@ nfs_xdr_readres(struct rpc_rqst *req, u3
  * Write arguments. Splice the buffer to be written into the iovec.
  */
 static int
-nfs_xdr_writeargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs_xdr_writeargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_buf *sndbuf = &req->rq_snd_buf;
 	u32 offset = (u32)args->offset;
@@ -309,7 +309,7 @@ nfs_xdr_writeargs(struct rpc_rqst *req, 
  * CREATE, MKDIR
  */
 static int
-nfs_xdr_createargs(struct rpc_rqst *req, u32 *p, struct nfs_createargs *args)
+nfs_xdr_createargs(struct rpc_rqst *req, __be32 *p, struct nfs_createargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -322,7 +322,7 @@ nfs_xdr_createargs(struct rpc_rqst *req,
  * Encode RENAME arguments
  */
 static int
-nfs_xdr_renameargs(struct rpc_rqst *req, u32 *p, struct nfs_renameargs *args)
+nfs_xdr_renameargs(struct rpc_rqst *req, __be32 *p, struct nfs_renameargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -336,7 +336,7 @@ nfs_xdr_renameargs(struct rpc_rqst *req,
  * Encode LINK arguments
  */
 static int
-nfs_xdr_linkargs(struct rpc_rqst *req, u32 *p, struct nfs_linkargs *args)
+nfs_xdr_linkargs(struct rpc_rqst *req, __be32 *p, struct nfs_linkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_fhandle(p, args->tofh);
@@ -349,7 +349,7 @@ nfs_xdr_linkargs(struct rpc_rqst *req, u
  * Encode SYMLINK arguments
  */
 static int
-nfs_xdr_symlinkargs(struct rpc_rqst *req, u32 *p, struct nfs_symlinkargs *args)
+nfs_xdr_symlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs_symlinkargs *args)
 {
 	struct xdr_buf *sndbuf = &req->rq_snd_buf;
 	size_t pad;
@@ -378,7 +378,7 @@ nfs_xdr_symlinkargs(struct rpc_rqst *req
  * Encode arguments to readdir call
  */
 static int
-nfs_xdr_readdirargs(struct rpc_rqst *req, u32 *p, struct nfs_readdirargs *args)
+nfs_xdr_readdirargs(struct rpc_rqst *req, __be32 *p, struct nfs_readdirargs *args)
 {
 	struct rpc_task	*task = req->rq_task;
 	struct rpc_auth	*auth = task->tk_auth;
@@ -404,7 +404,7 @@ nfs_xdr_readdirargs(struct rpc_rqst *req
  * from nfs_readdir for each entry.
  */
 static int
-nfs_xdr_readdirres(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_readdirres(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -412,7 +412,7 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *end, *entry, *kaddr;
+	__be32 *end, *entry, *kaddr;
 
 	if ((status = ntohl(*p++)))
 		return -nfs_stat_to_errno(status);
@@ -432,8 +432,8 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
-	end = (u32 *)((char *)p + pglen);
+	kaddr = p = kmap_atomic(*page, KM_USER0);
+	end = (__be32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
 		if (p + 2 > end)
@@ -496,7 +496,7 @@ nfs_decode_dirent(u32 *p, struct nfs_ent
  * Decode simple status reply
  */
 static int
-nfs_xdr_stat(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_stat(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	int	status;
 
@@ -510,7 +510,7 @@ nfs_xdr_stat(struct rpc_rqst *req, u32 *
  * GETATTR, SETATTR, WRITE
  */
 static int
-nfs_xdr_attrstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs_xdr_attrstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -525,7 +525,7 @@ nfs_xdr_attrstat(struct rpc_rqst *req, u
  * LOOKUP, CREATE, MKDIR
  */
 static int
-nfs_xdr_diropres(struct rpc_rqst *req, u32 *p, struct nfs_diropok *res)
+nfs_xdr_diropres(struct rpc_rqst *req, __be32 *p, struct nfs_diropok *res)
 {
 	int	status;
 
@@ -540,7 +540,7 @@ nfs_xdr_diropres(struct rpc_rqst *req, u
  * Encode READLINK args
  */
 static int
-nfs_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs_readlinkargs *args)
+nfs_xdr_readlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -558,7 +558,7 @@ nfs_xdr_readlinkargs(struct rpc_rqst *re
  * Decode READLINK reply
  */
 static int
-nfs_xdr_readlinkres(struct rpc_rqst *req, u32 *p, void *dummy)
+nfs_xdr_readlinkres(struct rpc_rqst *req, __be32 *p, void *dummy)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -601,7 +601,7 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
  * Decode WRITE reply
  */
 static int
-nfs_xdr_writeres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs_xdr_writeres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	res->verf->committed = NFS_FILE_SYNC;
 	return nfs_xdr_attrstat(req, p, res->fattr);
@@ -611,7 +611,7 @@ nfs_xdr_writeres(struct rpc_rqst *req, u
  * Decode STATFS reply
  */
 static int
-nfs_xdr_statfsres(struct rpc_rqst *req, u32 *p, struct nfs2_fsstat *res)
+nfs_xdr_statfsres(struct rpc_rqst *req, __be32 *p, struct nfs2_fsstat *res)
 {
 	int	status;
 
-- 
1.4.2.GIT


