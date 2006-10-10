Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWJJDTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWJJDTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWJJDMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:12:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9901 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964899AbWJJDMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:01 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/25] xdr annotations: fs/nfs/callback*
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX82D-0004CO-2C@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on-the-wire data is big-endian

[mostly pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/callback.h     |    4 ++--
 fs/nfs/callback_xdr.c |   44 ++++++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 6921d82..db3d791 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -31,10 +31,10 @@ struct cb_compound_hdr_arg {
 };
 
 struct cb_compound_hdr_res {
-	uint32_t *status;
+	__be32 *status;
 	int taglen;
 	const char *tag;
-	uint32_t *nops;
+	__be32 *nops;
 };
 
 struct cb_getattrargs {
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 909a140..f8ea1f5 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -41,19 +41,19 @@ static __be32 nfs4_callback_null(struct 
 	return htonl(NFS4_OK);
 }
 
-static int nfs4_decode_void(struct svc_rqst *rqstp, uint32_t *p, void *dummy)
+static int nfs4_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
-static int nfs4_encode_void(struct svc_rqst *rqstp, uint32_t *p, void *dummy)
+static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
 
-static uint32_t *read_buf(struct xdr_stream *xdr, int nbytes)
+static __be32 *read_buf(struct xdr_stream *xdr, int nbytes)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_inline_decode(xdr, nbytes);
 	if (unlikely(p == NULL))
@@ -63,7 +63,7 @@ static uint32_t *read_buf(struct xdr_str
 
 static __be32 decode_string(struct xdr_stream *xdr, unsigned int *len, const char **str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
@@ -83,7 +83,7 @@ static __be32 decode_string(struct xdr_s
 
 static __be32 decode_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
@@ -101,7 +101,7 @@ static __be32 decode_fh(struct xdr_strea
 
 static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 {
-	uint32_t *p;
+	__be32 *p;
 	unsigned int attrlen;
 
 	p = read_buf(xdr, 4);
@@ -120,7 +120,7 @@ static __be32 decode_bitmap(struct xdr_s
 
 static __be32 decode_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = read_buf(xdr, 16);
 	if (unlikely(p == NULL))
@@ -131,7 +131,7 @@ static __be32 decode_stateid(struct xdr_
 
 static __be32 decode_compound_hdr_arg(struct xdr_stream *xdr, struct cb_compound_hdr_arg *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 	unsigned int minor_version;
 	__be32 status;
 
@@ -161,7 +161,7 @@ static __be32 decode_compound_hdr_arg(st
 
 static __be32 decode_op_hdr(struct xdr_stream *xdr, unsigned int *op)
 {
-	uint32_t *p;
+	__be32 *p;
 	p = read_buf(xdr, 4);
 	if (unlikely(p == NULL))
 		return htonl(NFS4ERR_RESOURCE);
@@ -185,7 +185,7 @@ out:
 
 static __be32 decode_recall_args(struct svc_rqst *rqstp, struct xdr_stream *xdr, struct cb_recallargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
 	__be32 status;
 
 	args->addr = &rqstp->rq_addr;
@@ -206,7 +206,7 @@ out:
 
 static __be32 encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4 + len);
 	if (unlikely(p == NULL))
@@ -217,10 +217,10 @@ static __be32 encode_string(struct xdr_s
 
 #define CB_SUPPORTED_ATTR0 (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE)
 #define CB_SUPPORTED_ATTR1 (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY)
-static __be32 encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, uint32_t **savep)
+static __be32 encode_attr_bitmap(struct xdr_stream *xdr, const uint32_t *bitmap, __be32 **savep)
 {
-	uint32_t bm[2];
-	uint32_t *p;
+	__be32 bm[2];
+	__be32 *p;
 
 	bm[0] = htonl(bitmap[0] & CB_SUPPORTED_ATTR0);
 	bm[1] = htonl(bitmap[1] & CB_SUPPORTED_ATTR1);
@@ -249,7 +249,7 @@ static __be32 encode_attr_bitmap(struct 
 
 static __be32 encode_attr_change(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t change)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	if (!(bitmap[0] & FATTR4_WORD0_CHANGE))
 		return 0;
@@ -262,7 +262,7 @@ static __be32 encode_attr_change(struct 
 
 static __be32 encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, uint64_t size)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	if (!(bitmap[0] & FATTR4_WORD0_SIZE))
 		return 0;
@@ -275,7 +275,7 @@ static __be32 encode_attr_size(struct xd
 
 static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 12);
 	if (unlikely(p == 0))
@@ -317,7 +317,7 @@ static __be32 encode_compound_hdr_res(st
 
 static __be32 encode_op_hdr(struct xdr_stream *xdr, uint32_t op, __be32 res)
 {
-	uint32_t *p;
+	__be32 *p;
 	
 	p = xdr_reserve_space(xdr, 8);
 	if (unlikely(p == NULL))
@@ -329,7 +329,7 @@ static __be32 encode_op_hdr(struct xdr_s
 
 static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr, const struct cb_getattrres *res)
 {
-	uint32_t *savep = NULL;
+	__be32 *savep = NULL;
 	__be32 status = res->status;
 	
 	if (unlikely(status != 0))
@@ -404,7 +404,7 @@ static __be32 nfs4_callback_compound(str
 	struct cb_compound_hdr_arg hdr_arg;
 	struct cb_compound_hdr_res hdr_res;
 	struct xdr_stream xdr_in, xdr_out;
-	uint32_t *p;
+	__be32 *p;
 	__be32 status;
 	unsigned int nops = 1;
 
@@ -412,7 +412,7 @@ static __be32 nfs4_callback_compound(str
 
 	xdr_init_decode(&xdr_in, &rqstp->rq_arg, rqstp->rq_arg.head[0].iov_base);
 
-	p = (uint32_t*)((char *)rqstp->rq_res.head[0].iov_base + rqstp->rq_res.head[0].iov_len);
+	p = (__be32*)((char *)rqstp->rq_res.head[0].iov_base + rqstp->rq_res.head[0].iov_len);
 	xdr_init_encode(&xdr_out, &rqstp->rq_res, p);
 
 	decode_compound_hdr_arg(&xdr_in, &hdr_arg);
-- 
1.4.2.GIT


