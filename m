Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWJJDPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWJJDPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWJJDOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:14:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35501 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964933AbWJJDOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:22 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] xdr annotations: nfsd callback*
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX84T-0004Hx-Ev@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:14:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4callback.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f6ca9fb..75314ed 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -85,8 +85,8 @@ #define NFS4_dec_cb_recall_sz		(cb_compo
 /*
 * Generic encode routines from fs/nfs/nfs4xdr.c
 */
-static inline u32 *
-xdr_writemem(u32 *p, const void *ptr, int nbytes)
+static inline __be32 *
+xdr_writemem(__be32 *p, const void *ptr, int nbytes)
 {
 	int tmp = XDR_QUADLEN(nbytes);
 	if (!tmp)
@@ -205,7 +205,7 @@ nfs_cb_stat_to_errno(int stat)
 static int
 encode_cb_compound_hdr(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr)
 {
-	u32 * p;
+	__be32 * p;
 
 	RESERVE_SPACE(16);
 	WRITE32(0);            /* tag length is always 0 */
@@ -218,7 +218,7 @@ encode_cb_compound_hdr(struct xdr_stream
 static int
 encode_cb_recall(struct xdr_stream *xdr, struct nfs4_cb_recall *cb_rec)
 {
-	u32 *p;
+	__be32 *p;
 	int len = cb_rec->cbr_fhlen;
 
 	RESERVE_SPACE(12+sizeof(cb_rec->cbr_stateid) + len);
@@ -231,7 +231,7 @@ encode_cb_recall(struct xdr_stream *xdr,
 }
 
 static int
-nfs4_xdr_enc_cb_null(struct rpc_rqst *req, u32 *p)
+nfs4_xdr_enc_cb_null(struct rpc_rqst *req, __be32 *p)
 {
 	struct xdr_stream xdrs, *xdr = &xdrs;
 
@@ -241,7 +241,7 @@ nfs4_xdr_enc_cb_null(struct rpc_rqst *re
 }
 
 static int
-nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, u32 *p, struct nfs4_cb_recall *args)
+nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, __be32 *p, struct nfs4_cb_recall *args)
 {
 	struct xdr_stream xdr;
 	struct nfs4_cb_compound_hdr hdr = {
@@ -257,7 +257,7 @@ nfs4_xdr_enc_cb_recall(struct rpc_rqst *
 
 static int
 decode_cb_compound_hdr(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr){
-        u32 *p;
+        __be32 *p;
 
         READ_BUF(8);
         READ32(hdr->status);
@@ -272,7 +272,7 @@ decode_cb_compound_hdr(struct xdr_stream
 static int
 decode_cb_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected)
 {
-	u32 *p;
+	__be32 *p;
 	u32 op;
 	int32_t nfserr;
 
@@ -291,13 +291,13 @@ decode_cb_op_hdr(struct xdr_stream *xdr,
 }
 
 static int
-nfs4_xdr_dec_cb_null(struct rpc_rqst *req, u32 *p)
+nfs4_xdr_dec_cb_null(struct rpc_rqst *req, __be32 *p)
 {
 	return 0;
 }
 
 static int
-nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp, u32 *p)
+nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp, __be32 *p)
 {
 	struct xdr_stream xdr;
 	struct nfs4_cb_compound_hdr hdr;
-- 
1.4.2.GIT


