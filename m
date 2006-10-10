Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWJJDLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWJJDLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWJJDLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:11:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2989 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964827AbWJJDLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:21 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/25] xdr annotations: NFSv3
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX81Y-0004BK-Ve@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on-the-wire data is big-endian

[in large part pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs3xdr.c |  114 +++++++++++++++++++++++++++---------------------------
 1 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 16556fa..b4e740e 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -105,14 +105,14 @@ static struct {
 /*
  * Common NFS XDR functions as inlines
  */
-static inline u32 *
-xdr_encode_fhandle(u32 *p, struct nfs_fh *fh)
+static inline __be32 *
+xdr_encode_fhandle(__be32 *p, struct nfs_fh *fh)
 {
 	return xdr_encode_array(p, fh->data, fh->size);
 }
 
-static inline u32 *
-xdr_decode_fhandle(u32 *p, struct nfs_fh *fh)
+static inline __be32 *
+xdr_decode_fhandle(__be32 *p, struct nfs_fh *fh)
 {
 	if ((fh->size = ntohl(*p++)) <= NFS3_FHSIZE) {
 		memcpy(fh->data, p, fh->size);
@@ -124,24 +124,24 @@ xdr_decode_fhandle(u32 *p, struct nfs_fh
 /*
  * Encode/decode time.
  */
-static inline u32 *
-xdr_encode_time3(u32 *p, struct timespec *timep)
+static inline __be32 *
+xdr_encode_time3(__be32 *p, struct timespec *timep)
 {
 	*p++ = htonl(timep->tv_sec);
 	*p++ = htonl(timep->tv_nsec);
 	return p;
 }
 
-static inline u32 *
-xdr_decode_time3(u32 *p, struct timespec *timep)
+static inline __be32 *
+xdr_decode_time3(__be32 *p, struct timespec *timep)
 {
 	timep->tv_sec = ntohl(*p++);
 	timep->tv_nsec = ntohl(*p++);
 	return p;
 }
 
-static u32 *
-xdr_decode_fattr(u32 *p, struct nfs_fattr *fattr)
+static __be32 *
+xdr_decode_fattr(__be32 *p, struct nfs_fattr *fattr)
 {
 	unsigned int	type, major, minor;
 	int		fmode;
@@ -177,8 +177,8 @@ xdr_decode_fattr(u32 *p, struct nfs_fatt
 	return p;
 }
 
-static inline u32 *
-xdr_encode_sattr(u32 *p, struct iattr *attr)
+static inline __be32 *
+xdr_encode_sattr(__be32 *p, struct iattr *attr)
 {
 	if (attr->ia_valid & ATTR_MODE) {
 		*p++ = xdr_one;
@@ -223,8 +223,8 @@ xdr_encode_sattr(u32 *p, struct iattr *a
 	return p;
 }
 
-static inline u32 *
-xdr_decode_wcc_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_wcc_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	p = xdr_decode_hyper(p, &fattr->pre_size);
 	p = xdr_decode_time3(p, &fattr->pre_mtime);
@@ -233,16 +233,16 @@ xdr_decode_wcc_attr(u32 *p, struct nfs_f
 	return p;
 }
 
-static inline u32 *
-xdr_decode_post_op_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_post_op_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	if (*p++)
 		p = xdr_decode_fattr(p, fattr);
 	return p;
 }
 
-static inline u32 *
-xdr_decode_pre_op_attr(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_pre_op_attr(__be32 *p, struct nfs_fattr *fattr)
 {
 	if (*p++)
 		return xdr_decode_wcc_attr(p, fattr);
@@ -250,8 +250,8 @@ xdr_decode_pre_op_attr(u32 *p, struct nf
 }
 
 
-static inline u32 *
-xdr_decode_wcc_data(u32 *p, struct nfs_fattr *fattr)
+static inline __be32 *
+xdr_decode_wcc_data(__be32 *p, struct nfs_fattr *fattr)
 {
 	p = xdr_decode_pre_op_attr(p, fattr);
 	return xdr_decode_post_op_attr(p, fattr);
@@ -265,7 +265,7 @@ xdr_decode_wcc_data(u32 *p, struct nfs_f
  * Encode file handle argument
  */
 static int
-nfs3_xdr_fhandle(struct rpc_rqst *req, u32 *p, struct nfs_fh *fh)
+nfs3_xdr_fhandle(struct rpc_rqst *req, __be32 *p, struct nfs_fh *fh)
 {
 	p = xdr_encode_fhandle(p, fh);
 	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
@@ -276,7 +276,7 @@ nfs3_xdr_fhandle(struct rpc_rqst *req, u
  * Encode SETATTR arguments
  */
 static int
-nfs3_xdr_sattrargs(struct rpc_rqst *req, u32 *p, struct nfs3_sattrargs *args)
+nfs3_xdr_sattrargs(struct rpc_rqst *req, __be32 *p, struct nfs3_sattrargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_sattr(p, args->sattr);
@@ -291,7 +291,7 @@ nfs3_xdr_sattrargs(struct rpc_rqst *req,
  * Encode directory ops argument
  */
 static int
-nfs3_xdr_diropargs(struct rpc_rqst *req, u32 *p, struct nfs3_diropargs *args)
+nfs3_xdr_diropargs(struct rpc_rqst *req, __be32 *p, struct nfs3_diropargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -303,7 +303,7 @@ nfs3_xdr_diropargs(struct rpc_rqst *req,
  * Encode access() argument
  */
 static int
-nfs3_xdr_accessargs(struct rpc_rqst *req, u32 *p, struct nfs3_accessargs *args)
+nfs3_xdr_accessargs(struct rpc_rqst *req, __be32 *p, struct nfs3_accessargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	*p++ = htonl(args->access);
@@ -317,7 +317,7 @@ nfs3_xdr_accessargs(struct rpc_rqst *req
  * exactly to the page we want to fetch.
  */
 static int
-nfs3_xdr_readargs(struct rpc_rqst *req, u32 *p, struct nfs_readargs *args)
+nfs3_xdr_readargs(struct rpc_rqst *req, __be32 *p, struct nfs_readargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -339,7 +339,7 @@ nfs3_xdr_readargs(struct rpc_rqst *req, 
  * Write arguments. Splice the buffer to be written into the iovec.
  */
 static int
-nfs3_xdr_writeargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs3_xdr_writeargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_buf *sndbuf = &req->rq_snd_buf;
 	u32 count = args->count;
@@ -360,7 +360,7 @@ nfs3_xdr_writeargs(struct rpc_rqst *req,
  * Encode CREATE arguments
  */
 static int
-nfs3_xdr_createargs(struct rpc_rqst *req, u32 *p, struct nfs3_createargs *args)
+nfs3_xdr_createargs(struct rpc_rqst *req, __be32 *p, struct nfs3_createargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -380,7 +380,7 @@ nfs3_xdr_createargs(struct rpc_rqst *req
  * Encode MKDIR arguments
  */
 static int
-nfs3_xdr_mkdirargs(struct rpc_rqst *req, u32 *p, struct nfs3_mkdirargs *args)
+nfs3_xdr_mkdirargs(struct rpc_rqst *req, __be32 *p, struct nfs3_mkdirargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -393,7 +393,7 @@ nfs3_xdr_mkdirargs(struct rpc_rqst *req,
  * Encode SYMLINK arguments
  */
 static int
-nfs3_xdr_symlinkargs(struct rpc_rqst *req, u32 *p, struct nfs3_symlinkargs *args)
+nfs3_xdr_symlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_symlinkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -410,7 +410,7 @@ nfs3_xdr_symlinkargs(struct rpc_rqst *re
  * Encode MKNOD arguments
  */
 static int
-nfs3_xdr_mknodargs(struct rpc_rqst *req, u32 *p, struct nfs3_mknodargs *args)
+nfs3_xdr_mknodargs(struct rpc_rqst *req, __be32 *p, struct nfs3_mknodargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_array(p, args->name, args->len);
@@ -429,7 +429,7 @@ nfs3_xdr_mknodargs(struct rpc_rqst *req,
  * Encode RENAME arguments
  */
 static int
-nfs3_xdr_renameargs(struct rpc_rqst *req, u32 *p, struct nfs3_renameargs *args)
+nfs3_xdr_renameargs(struct rpc_rqst *req, __be32 *p, struct nfs3_renameargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_array(p, args->fromname, args->fromlen);
@@ -443,7 +443,7 @@ nfs3_xdr_renameargs(struct rpc_rqst *req
  * Encode LINK arguments
  */
 static int
-nfs3_xdr_linkargs(struct rpc_rqst *req, u32 *p, struct nfs3_linkargs *args)
+nfs3_xdr_linkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_linkargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fromfh);
 	p = xdr_encode_fhandle(p, args->tofh);
@@ -456,7 +456,7 @@ nfs3_xdr_linkargs(struct rpc_rqst *req, 
  * Encode arguments to readdir call
  */
 static int
-nfs3_xdr_readdirargs(struct rpc_rqst *req, u32 *p, struct nfs3_readdirargs *args)
+nfs3_xdr_readdirargs(struct rpc_rqst *req, __be32 *p, struct nfs3_readdirargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -485,7 +485,7 @@ nfs3_xdr_readdirargs(struct rpc_rqst *re
  * We just check for syntactical correctness.
  */
 static int
-nfs3_xdr_readdirres(struct rpc_rqst *req, u32 *p, struct nfs3_readdirres *res)
+nfs3_xdr_readdirres(struct rpc_rqst *req, __be32 *p, struct nfs3_readdirres *res)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -493,7 +493,7 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *entry, *end, *kaddr;
+	__be32 *entry, *end, *kaddr;
 
 	status = ntohl(*p++);
 	/* Decode post_op_attrs */
@@ -523,8 +523,8 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
-	end = (u32 *)((char *)p + pglen);
+	kaddr = p = kmap_atomic(*page, KM_USER0);
+	end = (__be32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
 		if (p + 3 > end)
@@ -626,7 +626,7 @@ nfs3_decode_dirent(u32 *p, struct nfs_en
  * Encode COMMIT arguments
  */
 static int
-nfs3_xdr_commitargs(struct rpc_rqst *req, u32 *p, struct nfs_writeargs *args)
+nfs3_xdr_commitargs(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	p = xdr_encode_fhandle(p, args->fh);
 	p = xdr_encode_hyper(p, args->offset);
@@ -640,7 +640,7 @@ #ifdef CONFIG_NFS_V3_ACL
  * Encode GETACL arguments
  */
 static int
-nfs3_xdr_getaclargs(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_getaclargs(struct rpc_rqst *req, __be32 *p,
 		    struct nfs3_getaclargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
@@ -664,7 +664,7 @@ nfs3_xdr_getaclargs(struct rpc_rqst *req
  * Encode SETACL arguments
  */
 static int
-nfs3_xdr_setaclargs(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_setaclargs(struct rpc_rqst *req, __be32 *p,
                    struct nfs3_setaclargs *args)
 {
 	struct xdr_buf *buf = &req->rq_snd_buf;
@@ -711,7 +711,7 @@ #endif  /* CONFIG_NFS_V3_ACL */
  * Decode attrstat reply.
  */
 static int
-nfs3_xdr_attrstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_attrstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -726,7 +726,7 @@ nfs3_xdr_attrstat(struct rpc_rqst *req, 
  * SATTR, REMOVE, RMDIR
  */
 static int
-nfs3_xdr_wccstat(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_wccstat(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int	status;
 
@@ -740,7 +740,7 @@ nfs3_xdr_wccstat(struct rpc_rqst *req, u
  * Decode LOOKUP reply
  */
 static int
-nfs3_xdr_lookupres(struct rpc_rqst *req, u32 *p, struct nfs3_diropres *res)
+nfs3_xdr_lookupres(struct rpc_rqst *req, __be32 *p, struct nfs3_diropres *res)
 {
 	int	status;
 
@@ -759,7 +759,7 @@ nfs3_xdr_lookupres(struct rpc_rqst *req,
  * Decode ACCESS reply
  */
 static int
-nfs3_xdr_accessres(struct rpc_rqst *req, u32 *p, struct nfs3_accessres *res)
+nfs3_xdr_accessres(struct rpc_rqst *req, __be32 *p, struct nfs3_accessres *res)
 {
 	int	status = ntohl(*p++);
 
@@ -771,7 +771,7 @@ nfs3_xdr_accessres(struct rpc_rqst *req,
 }
 
 static int
-nfs3_xdr_readlinkargs(struct rpc_rqst *req, u32 *p, struct nfs3_readlinkargs *args)
+nfs3_xdr_readlinkargs(struct rpc_rqst *req, __be32 *p, struct nfs3_readlinkargs *args)
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
@@ -789,7 +789,7 @@ nfs3_xdr_readlinkargs(struct rpc_rqst *r
  * Decode READLINK reply
  */
 static int
-nfs3_xdr_readlinkres(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_readlinkres(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
@@ -837,7 +837,7 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
  * Decode READ reply
  */
 static int
-nfs3_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
+nfs3_xdr_readres(struct rpc_rqst *req, __be32 *p, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
 	int	status, count, ocount, recvd, hdrlen;
@@ -888,7 +888,7 @@ nfs3_xdr_readres(struct rpc_rqst *req, u
  * Decode WRITE response
  */
 static int
-nfs3_xdr_writeres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs3_xdr_writeres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	int	status;
 
@@ -910,7 +910,7 @@ nfs3_xdr_writeres(struct rpc_rqst *req, 
  * Decode a CREATE response
  */
 static int
-nfs3_xdr_createres(struct rpc_rqst *req, u32 *p, struct nfs3_diropres *res)
+nfs3_xdr_createres(struct rpc_rqst *req, __be32 *p, struct nfs3_diropres *res)
 {
 	int	status;
 
@@ -937,7 +937,7 @@ nfs3_xdr_createres(struct rpc_rqst *req,
  * Decode RENAME reply
  */
 static int
-nfs3_xdr_renameres(struct rpc_rqst *req, u32 *p, struct nfs3_renameres *res)
+nfs3_xdr_renameres(struct rpc_rqst *req, __be32 *p, struct nfs3_renameres *res)
 {
 	int	status;
 
@@ -952,7 +952,7 @@ nfs3_xdr_renameres(struct rpc_rqst *req,
  * Decode LINK reply
  */
 static int
-nfs3_xdr_linkres(struct rpc_rqst *req, u32 *p, struct nfs3_linkres *res)
+nfs3_xdr_linkres(struct rpc_rqst *req, __be32 *p, struct nfs3_linkres *res)
 {
 	int	status;
 
@@ -967,7 +967,7 @@ nfs3_xdr_linkres(struct rpc_rqst *req, u
  * Decode FSSTAT reply
  */
 static int
-nfs3_xdr_fsstatres(struct rpc_rqst *req, u32 *p, struct nfs_fsstat *res)
+nfs3_xdr_fsstatres(struct rpc_rqst *req, __be32 *p, struct nfs_fsstat *res)
 {
 	int		status;
 
@@ -992,7 +992,7 @@ nfs3_xdr_fsstatres(struct rpc_rqst *req,
  * Decode FSINFO reply
  */
 static int
-nfs3_xdr_fsinfores(struct rpc_rqst *req, u32 *p, struct nfs_fsinfo *res)
+nfs3_xdr_fsinfores(struct rpc_rqst *req, __be32 *p, struct nfs_fsinfo *res)
 {
 	int		status;
 
@@ -1020,7 +1020,7 @@ nfs3_xdr_fsinfores(struct rpc_rqst *req,
  * Decode PATHCONF reply
  */
 static int
-nfs3_xdr_pathconfres(struct rpc_rqst *req, u32 *p, struct nfs_pathconf *res)
+nfs3_xdr_pathconfres(struct rpc_rqst *req, __be32 *p, struct nfs_pathconf *res)
 {
 	int		status;
 
@@ -1040,7 +1040,7 @@ nfs3_xdr_pathconfres(struct rpc_rqst *re
  * Decode COMMIT reply
  */
 static int
-nfs3_xdr_commitres(struct rpc_rqst *req, u32 *p, struct nfs_writeres *res)
+nfs3_xdr_commitres(struct rpc_rqst *req, __be32 *p, struct nfs_writeres *res)
 {
 	int		status;
 
@@ -1059,7 +1059,7 @@ #ifdef CONFIG_NFS_V3_ACL
  * Decode GETACL reply
  */
 static int
-nfs3_xdr_getaclres(struct rpc_rqst *req, u32 *p,
+nfs3_xdr_getaclres(struct rpc_rqst *req, __be32 *p,
 		   struct nfs3_getaclres *res)
 {
 	struct xdr_buf *buf = &req->rq_rcv_buf;
@@ -1091,7 +1091,7 @@ nfs3_xdr_getaclres(struct rpc_rqst *req,
  * Decode setacl reply.
  */
 static int
-nfs3_xdr_setaclres(struct rpc_rqst *req, u32 *p, struct nfs_fattr *fattr)
+nfs3_xdr_setaclres(struct rpc_rqst *req, __be32 *p, struct nfs_fattr *fattr)
 {
 	int status = ntohl(*p++);
 
-- 
1.4.2.GIT


