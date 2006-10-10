Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWJJDMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWJJDMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWJJDLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:11:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4269 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964900AbWJJDLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:32 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/25] xdr annotations: NFSv4
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX81j-0004Bb-0o@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on-the-wire data is big-endian

[in large part pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4xdr.c |  358 +++++++++++++++++++++++++++---------------------------
 1 files changed, 181 insertions(+), 177 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 3dd413f..e284123 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -471,7 +471,7 @@ #define RESERVE_SPACE(nbytes)	do {				\
 
 static void encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4 + len);
 	BUG_ON(p == NULL);
@@ -480,7 +480,7 @@ static void encode_string(struct xdr_str
 
 static int encode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	dprintk("encode_compound: tag=%.*s\n", (int)hdr->taglen, hdr->tag);
 	BUG_ON(hdr->taglen > NFS4_MAXTAGLEN);
@@ -494,7 +494,7 @@ static int encode_compound_hdr(struct xd
 
 static void encode_nfs4_verifier(struct xdr_stream *xdr, const nfs4_verifier *verf)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
 	BUG_ON(p == NULL);
@@ -507,8 +507,8 @@ static int encode_attrs(struct xdr_strea
 	char owner_group[IDMAP_NAMESZ];
 	int owner_namelen = 0;
 	int owner_grouplen = 0;
-	uint32_t *p;
-	uint32_t *q;
+	__be32 *p;
+	__be32 *q;
 	int len;
 	uint32_t bmval0 = 0;
 	uint32_t bmval1 = 0;
@@ -630,7 +630,7 @@ static int encode_attrs(struct xdr_strea
 
 static int encode_access(struct xdr_stream *xdr, u32 access)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8);
 	WRITE32(OP_ACCESS);
@@ -641,7 +641,7 @@ static int encode_access(struct xdr_stre
 
 static int encode_close(struct xdr_stream *xdr, const struct nfs_closeargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid->data));
 	WRITE32(OP_CLOSE);
@@ -653,7 +653,7 @@ static int encode_close(struct xdr_strea
 
 static int encode_commit(struct xdr_stream *xdr, const struct nfs_writeargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
         
         RESERVE_SPACE(16);
         WRITE32(OP_COMMIT);
@@ -665,7 +665,7 @@ static int encode_commit(struct xdr_stre
 
 static int encode_create(struct xdr_stream *xdr, const struct nfs4_create_arg *create)
 {
-	uint32_t *p;
+	__be32 *p;
 	
 	RESERVE_SPACE(8);
 	WRITE32(OP_CREATE);
@@ -697,7 +697,7 @@ static int encode_create(struct xdr_stre
 
 static int encode_getattr_one(struct xdr_stream *xdr, uint32_t bitmap)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(12);
         WRITE32(OP_GETATTR);
@@ -708,7 +708,7 @@ static int encode_getattr_one(struct xdr
 
 static int encode_getattr_two(struct xdr_stream *xdr, uint32_t bm0, uint32_t bm1)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(16);
         WRITE32(OP_GETATTR);
@@ -740,7 +740,7 @@ static int encode_fs_locations(struct xd
 
 static int encode_getfh(struct xdr_stream *xdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_GETFH);
@@ -750,7 +750,7 @@ static int encode_getfh(struct xdr_strea
 
 static int encode_link(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + name->len);
 	WRITE32(OP_LINK);
@@ -780,7 +780,7 @@ static inline uint64_t nfs4_lock_length(
  */
 static int encode_lock(struct xdr_stream *xdr, const struct nfs_lock_args *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(32);
 	WRITE32(OP_LOCK);
@@ -809,7 +809,7 @@ static int encode_lock(struct xdr_stream
 
 static int encode_lockt(struct xdr_stream *xdr, const struct nfs_lockt_args *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(40);
 	WRITE32(OP_LOCKT);
@@ -825,7 +825,7 @@ static int encode_lockt(struct xdr_strea
 
 static int encode_locku(struct xdr_stream *xdr, const struct nfs_locku_args *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(44);
 	WRITE32(OP_LOCKU);
@@ -841,7 +841,7 @@ static int encode_locku(struct xdr_strea
 static int encode_lookup(struct xdr_stream *xdr, const struct qstr *name)
 {
 	int len = name->len;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + len);
 	WRITE32(OP_LOOKUP);
@@ -853,7 +853,7 @@ static int encode_lookup(struct xdr_stre
 
 static void encode_share_access(struct xdr_stream *xdr, int open_flags)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8);
 	switch (open_flags & (FMODE_READ|FMODE_WRITE)) {
@@ -874,7 +874,7 @@ static void encode_share_access(struct x
 
 static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
  /*
  * opcode 4, seqid 4, share_access 4, share_deny 4, clientid 8, ownerlen 4,
  * owner 4 = 32
@@ -891,7 +891,7 @@ static inline void encode_openhdr(struct
 
 static inline void encode_createmode(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch(arg->open_flags & O_EXCL) {
@@ -907,7 +907,7 @@ static inline void encode_createmode(str
 
 static void encode_opentype(struct xdr_stream *xdr, const struct nfs_openargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch (arg->open_flags & O_CREAT) {
@@ -923,7 +923,7 @@ static void encode_opentype(struct xdr_s
 
 static inline void encode_delegation_type(struct xdr_stream *xdr, int delegation_type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	switch (delegation_type) {
@@ -943,7 +943,7 @@ static inline void encode_delegation_typ
 
 static inline void encode_claim_null(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(NFS4_OPEN_CLAIM_NULL);
@@ -952,7 +952,7 @@ static inline void encode_claim_null(str
 
 static inline void encode_claim_previous(struct xdr_stream *xdr, int type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(NFS4_OPEN_CLAIM_PREVIOUS);
@@ -961,7 +961,7 @@ static inline void encode_claim_previous
 
 static inline void encode_claim_delegate_cur(struct xdr_stream *xdr, const struct qstr *name, const nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4+sizeof(stateid->data));
 	WRITE32(NFS4_OPEN_CLAIM_DELEGATE_CUR);
@@ -991,7 +991,7 @@ static int encode_open(struct xdr_stream
 
 static int encode_open_confirm(struct xdr_stream *xdr, const struct nfs_open_confirmargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid->data));
 	WRITE32(OP_OPEN_CONFIRM);
@@ -1003,7 +1003,7 @@ static int encode_open_confirm(struct xd
 
 static int encode_open_downgrade(struct xdr_stream *xdr, const struct nfs_closeargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8+sizeof(arg->stateid->data));
 	WRITE32(OP_OPEN_DOWNGRADE);
@@ -1017,7 +1017,7 @@ static int
 encode_putfh(struct xdr_stream *xdr, const struct nfs_fh *fh)
 {
 	int len = fh->size;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + len);
 	WRITE32(OP_PUTFH);
@@ -1029,7 +1029,7 @@ encode_putfh(struct xdr_stream *xdr, con
 
 static int encode_putrootfh(struct xdr_stream *xdr)
 {
-        uint32_t *p;
+        __be32 *p;
         
         RESERVE_SPACE(4);
         WRITE32(OP_PUTROOTFH);
@@ -1040,7 +1040,7 @@ static int encode_putrootfh(struct xdr_s
 static void encode_stateid(struct xdr_stream *xdr, const struct nfs_open_context *ctx)
 {
 	nfs4_stateid stateid;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(16);
 	if (ctx->state != NULL) {
@@ -1052,7 +1052,7 @@ static void encode_stateid(struct xdr_st
 
 static int encode_read(struct xdr_stream *xdr, const struct nfs_readargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_READ);
@@ -1074,7 +1074,7 @@ static int encode_readdir(struct xdr_str
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
 	int replen;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(32+sizeof(nfs4_verifier));
 	WRITE32(OP_READDIR);
@@ -1116,7 +1116,7 @@ static int encode_readlink(struct xdr_st
 {
 	struct rpc_auth *auth = req->rq_task->tk_auth;
 	unsigned int replen;
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_READLINK);
@@ -1134,7 +1134,7 @@ static int encode_readlink(struct xdr_st
 
 static int encode_remove(struct xdr_stream *xdr, const struct qstr *name)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + name->len);
 	WRITE32(OP_REMOVE);
@@ -1146,7 +1146,7 @@ static int encode_remove(struct xdr_stre
 
 static int encode_rename(struct xdr_stream *xdr, const struct qstr *oldname, const struct qstr *newname)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(8 + oldname->len);
 	WRITE32(OP_RENAME);
@@ -1162,7 +1162,7 @@ static int encode_rename(struct xdr_stre
 
 static int encode_renew(struct xdr_stream *xdr, const struct nfs_client *client_stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(12);
 	WRITE32(OP_RENEW);
@@ -1174,7 +1174,7 @@ static int encode_renew(struct xdr_strea
 static int
 encode_restorefh(struct xdr_stream *xdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_RESTOREFH);
@@ -1185,7 +1185,7 @@ encode_restorefh(struct xdr_stream *xdr)
 static int
 encode_setacl(struct xdr_stream *xdr, struct nfs_setaclargs *arg)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4+sizeof(zero_stateid.data));
 	WRITE32(OP_SETATTR);
@@ -1204,7 +1204,7 @@ encode_setacl(struct xdr_stream *xdr, st
 static int
 encode_savefh(struct xdr_stream *xdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_SAVEFH);
@@ -1215,7 +1215,7 @@ encode_savefh(struct xdr_stream *xdr)
 static int encode_setattr(struct xdr_stream *xdr, const struct nfs_setattrargs *arg, const struct nfs_server *server)
 {
 	int status;
-	uint32_t *p;
+	__be32 *p;
 	
         RESERVE_SPACE(4+sizeof(arg->stateid.data));
         WRITE32(OP_SETATTR);
@@ -1229,7 +1229,7 @@ static int encode_setattr(struct xdr_str
 
 static int encode_setclientid(struct xdr_stream *xdr, const struct nfs4_setclientid *setclientid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4 + sizeof(setclientid->sc_verifier->data));
 	WRITE32(OP_SETCLIENTID);
@@ -1248,7 +1248,7 @@ static int encode_setclientid(struct xdr
 
 static int encode_setclientid_confirm(struct xdr_stream *xdr, const struct nfs_client *client_state)
 {
-        uint32_t *p;
+        __be32 *p;
 
         RESERVE_SPACE(12 + sizeof(client_state->cl_confirm.data));
         WRITE32(OP_SETCLIENTID_CONFIRM);
@@ -1260,7 +1260,7 @@ static int encode_setclientid_confirm(st
 
 static int encode_write(struct xdr_stream *xdr, const struct nfs_writeargs *args)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(4);
 	WRITE32(OP_WRITE);
@@ -1279,7 +1279,7 @@ static int encode_write(struct xdr_strea
 
 static int encode_delegreturn(struct xdr_stream *xdr, const nfs4_stateid *stateid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	RESERVE_SPACE(20);
 
@@ -1295,7 +1295,7 @@ static int encode_delegreturn(struct xdr
 /*
  * Encode an ACCESS request
  */
-static int nfs4_xdr_enc_access(struct rpc_rqst *req, uint32_t *p, const struct nfs4_accessargs *args)
+static int nfs4_xdr_enc_access(struct rpc_rqst *req, __be32 *p, const struct nfs4_accessargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1313,7 +1313,7 @@ static int nfs4_xdr_enc_access(struct rp
 /*
  * Encode LOOKUP request
  */
-static int nfs4_xdr_enc_lookup(struct rpc_rqst *req, uint32_t *p, const struct nfs4_lookup_arg *args)
+static int nfs4_xdr_enc_lookup(struct rpc_rqst *req, __be32 *p, const struct nfs4_lookup_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1337,7 +1337,7 @@ out:
 /*
  * Encode LOOKUP_ROOT request
  */
-static int nfs4_xdr_enc_lookup_root(struct rpc_rqst *req, uint32_t *p, const struct nfs4_lookup_root_arg *args)
+static int nfs4_xdr_enc_lookup_root(struct rpc_rqst *req, __be32 *p, const struct nfs4_lookup_root_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1358,7 +1358,7 @@ out:
 /*
  * Encode REMOVE request
  */
-static int nfs4_xdr_enc_remove(struct rpc_rqst *req, uint32_t *p, const struct nfs4_remove_arg *args)
+static int nfs4_xdr_enc_remove(struct rpc_rqst *req, __be32 *p, const struct nfs4_remove_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1380,7 +1380,7 @@ out:
 /*
  * Encode RENAME request
  */
-static int nfs4_xdr_enc_rename(struct rpc_rqst *req, uint32_t *p, const struct nfs4_rename_arg *args)
+static int nfs4_xdr_enc_rename(struct rpc_rqst *req, __be32 *p, const struct nfs4_rename_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1410,7 +1410,7 @@ out:
 /*
  * Encode LINK request
  */
-static int nfs4_xdr_enc_link(struct rpc_rqst *req, uint32_t *p, const struct nfs4_link_arg *args)
+static int nfs4_xdr_enc_link(struct rpc_rqst *req, __be32 *p, const struct nfs4_link_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1440,7 +1440,7 @@ out:
 /*
  * Encode CREATE request
  */
-static int nfs4_xdr_enc_create(struct rpc_rqst *req, uint32_t *p, const struct nfs4_create_arg *args)
+static int nfs4_xdr_enc_create(struct rpc_rqst *req, __be32 *p, const struct nfs4_create_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1470,7 +1470,7 @@ out:
 /*
  * Encode SYMLINK request
  */
-static int nfs4_xdr_enc_symlink(struct rpc_rqst *req, uint32_t *p, const struct nfs4_create_arg *args)
+static int nfs4_xdr_enc_symlink(struct rpc_rqst *req, __be32 *p, const struct nfs4_create_arg *args)
 {
 	return nfs4_xdr_enc_create(req, p, args);
 }
@@ -1478,7 +1478,7 @@ static int nfs4_xdr_enc_symlink(struct r
 /*
  * Encode GETATTR request
  */
-static int nfs4_xdr_enc_getattr(struct rpc_rqst *req, uint32_t *p, const struct nfs4_getattr_arg *args)
+static int nfs4_xdr_enc_getattr(struct rpc_rqst *req, __be32 *p, const struct nfs4_getattr_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1496,7 +1496,7 @@ static int nfs4_xdr_enc_getattr(struct r
 /*
  * Encode a CLOSE request
  */
-static int nfs4_xdr_enc_close(struct rpc_rqst *req, uint32_t *p, struct nfs_closeargs *args)
+static int nfs4_xdr_enc_close(struct rpc_rqst *req, __be32 *p, struct nfs_closeargs *args)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr = {
@@ -1520,7 +1520,7 @@ out:
 /*
  * Encode an OPEN request
  */
-static int nfs4_xdr_enc_open(struct rpc_rqst *req, uint32_t *p, struct nfs_openargs *args)
+static int nfs4_xdr_enc_open(struct rpc_rqst *req, __be32 *p, struct nfs_openargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1556,7 +1556,7 @@ out:
 /*
  * Encode an OPEN_CONFIRM request
  */
-static int nfs4_xdr_enc_open_confirm(struct rpc_rqst *req, uint32_t *p, struct nfs_open_confirmargs *args)
+static int nfs4_xdr_enc_open_confirm(struct rpc_rqst *req, __be32 *p, struct nfs_open_confirmargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1577,7 +1577,7 @@ out:
 /*
  * Encode an OPEN request with no attributes.
  */
-static int nfs4_xdr_enc_open_noattr(struct rpc_rqst *req, uint32_t *p, struct nfs_openargs *args)
+static int nfs4_xdr_enc_open_noattr(struct rpc_rqst *req, __be32 *p, struct nfs_openargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1601,7 +1601,7 @@ out:
 /*
  * Encode an OPEN_DOWNGRADE request
  */
-static int nfs4_xdr_enc_open_downgrade(struct rpc_rqst *req, uint32_t *p, struct nfs_closeargs *args)
+static int nfs4_xdr_enc_open_downgrade(struct rpc_rqst *req, __be32 *p, struct nfs_closeargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1625,7 +1625,7 @@ out:
 /*
  * Encode a LOCK request
  */
-static int nfs4_xdr_enc_lock(struct rpc_rqst *req, uint32_t *p, struct nfs_lock_args *args)
+static int nfs4_xdr_enc_lock(struct rpc_rqst *req, __be32 *p, struct nfs_lock_args *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1646,7 +1646,7 @@ out:
 /*
  * Encode a LOCKT request
  */
-static int nfs4_xdr_enc_lockt(struct rpc_rqst *req, uint32_t *p, struct nfs_lockt_args *args)
+static int nfs4_xdr_enc_lockt(struct rpc_rqst *req, __be32 *p, struct nfs_lockt_args *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1667,7 +1667,7 @@ out:
 /*
  * Encode a LOCKU request
  */
-static int nfs4_xdr_enc_locku(struct rpc_rqst *req, uint32_t *p, struct nfs_locku_args *args)
+static int nfs4_xdr_enc_locku(struct rpc_rqst *req, __be32 *p, struct nfs_locku_args *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1688,7 +1688,7 @@ out:
 /*
  * Encode a READLINK request
  */
-static int nfs4_xdr_enc_readlink(struct rpc_rqst *req, uint32_t *p, const struct nfs4_readlink *args)
+static int nfs4_xdr_enc_readlink(struct rpc_rqst *req, __be32 *p, const struct nfs4_readlink *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1709,7 +1709,7 @@ out:
 /*
  * Encode a READDIR request
  */
-static int nfs4_xdr_enc_readdir(struct rpc_rqst *req, uint32_t *p, const struct nfs4_readdir_arg *args)
+static int nfs4_xdr_enc_readdir(struct rpc_rqst *req, __be32 *p, const struct nfs4_readdir_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1730,7 +1730,7 @@ out:
 /*
  * Encode a READ request
  */
-static int nfs4_xdr_enc_read(struct rpc_rqst *req, uint32_t *p, struct nfs_readargs *args)
+static int nfs4_xdr_enc_read(struct rpc_rqst *req, __be32 *p, struct nfs_readargs *args)
 {
 	struct rpc_auth	*auth = req->rq_task->tk_auth;
 	struct xdr_stream xdr;
@@ -1762,7 +1762,7 @@ out:
 /*
  * Encode an SETATTR request
  */
-static int nfs4_xdr_enc_setattr(struct rpc_rqst *req, uint32_t *p, struct nfs_setattrargs *args)
+static int nfs4_xdr_enc_setattr(struct rpc_rqst *req, __be32 *p, struct nfs_setattrargs *args)
 
 {
         struct xdr_stream xdr;
@@ -1788,7 +1788,7 @@ out:
  * Encode a GETACL request
  */
 static int
-nfs4_xdr_enc_getacl(struct rpc_rqst *req, uint32_t *p,
+nfs4_xdr_enc_getacl(struct rpc_rqst *req, __be32 *p,
 		struct nfs_getaclargs *args)
 {
 	struct xdr_stream xdr;
@@ -1815,7 +1815,7 @@ out:
 /*
  * Encode a WRITE request
  */
-static int nfs4_xdr_enc_write(struct rpc_rqst *req, uint32_t *p, struct nfs_writeargs *args)
+static int nfs4_xdr_enc_write(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1839,7 +1839,7 @@ out:
 /*
  *  a COMMIT request
  */
-static int nfs4_xdr_enc_commit(struct rpc_rqst *req, uint32_t *p, struct nfs_writeargs *args)
+static int nfs4_xdr_enc_commit(struct rpc_rqst *req, __be32 *p, struct nfs_writeargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1863,7 +1863,7 @@ out:
 /*
  * FSINFO request
  */
-static int nfs4_xdr_enc_fsinfo(struct rpc_rqst *req, uint32_t *p, struct nfs4_fsinfo_arg *args)
+static int nfs4_xdr_enc_fsinfo(struct rpc_rqst *req, __be32 *p, struct nfs4_fsinfo_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1882,7 +1882,7 @@ static int nfs4_xdr_enc_fsinfo(struct rp
 /*
  * a PATHCONF request
  */
-static int nfs4_xdr_enc_pathconf(struct rpc_rqst *req, uint32_t *p, const struct nfs4_pathconf_arg *args)
+static int nfs4_xdr_enc_pathconf(struct rpc_rqst *req, __be32 *p, const struct nfs4_pathconf_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1902,7 +1902,7 @@ static int nfs4_xdr_enc_pathconf(struct 
 /*
  * a STATFS request
  */
-static int nfs4_xdr_enc_statfs(struct rpc_rqst *req, uint32_t *p, const struct nfs4_statfs_arg *args)
+static int nfs4_xdr_enc_statfs(struct rpc_rqst *req, __be32 *p, const struct nfs4_statfs_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1923,7 +1923,7 @@ static int nfs4_xdr_enc_statfs(struct rp
 /*
  * GETATTR_BITMAP request
  */
-static int nfs4_xdr_enc_server_caps(struct rpc_rqst *req, uint32_t *p, const struct nfs_fh *fhandle)
+static int nfs4_xdr_enc_server_caps(struct rpc_rqst *req, __be32 *p, const struct nfs_fh *fhandle)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1945,7 +1945,7 @@ static int nfs4_xdr_enc_server_caps(stru
 /*
  * a RENEW request
  */
-static int nfs4_xdr_enc_renew(struct rpc_rqst *req, uint32_t *p, struct nfs_client *clp)
+static int nfs4_xdr_enc_renew(struct rpc_rqst *req, __be32 *p, struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1960,7 +1960,7 @@ static int nfs4_xdr_enc_renew(struct rpc
 /*
  * a SETCLIENTID request
  */
-static int nfs4_xdr_enc_setclientid(struct rpc_rqst *req, uint32_t *p, struct nfs4_setclientid *sc)
+static int nfs4_xdr_enc_setclientid(struct rpc_rqst *req, __be32 *p, struct nfs4_setclientid *sc)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1975,7 +1975,7 @@ static int nfs4_xdr_enc_setclientid(stru
 /*
  * a SETCLIENTID_CONFIRM request
  */
-static int nfs4_xdr_enc_setclientid_confirm(struct rpc_rqst *req, uint32_t *p, struct nfs_client *clp)
+static int nfs4_xdr_enc_setclientid_confirm(struct rpc_rqst *req, __be32 *p, struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -1997,7 +1997,7 @@ static int nfs4_xdr_enc_setclientid_conf
 /*
  * DELEGRETURN request
  */
-static int nfs4_xdr_enc_delegreturn(struct rpc_rqst *req, uint32_t *p, const struct nfs4_delegreturnargs *args)
+static int nfs4_xdr_enc_delegreturn(struct rpc_rqst *req, __be32 *p, const struct nfs4_delegreturnargs *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -2021,7 +2021,7 @@ out:
 /*
  * Encode FS_LOCATIONS request
  */
-static int nfs4_xdr_enc_fs_locations(struct rpc_rqst *req, uint32_t *p, struct nfs4_fs_locations_arg *args)
+static int nfs4_xdr_enc_fs_locations(struct rpc_rqst *req, __be32 *p, struct nfs4_fs_locations_arg *args)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr = {
@@ -2086,7 +2086,7 @@ #define READ_BUF(nbytes)  do { \
 
 static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len, char **string)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(*len);
@@ -2097,7 +2097,7 @@ static int decode_opaque_inline(struct x
 
 static int decode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(8);
 	READ32(hdr->status);
@@ -2112,7 +2112,7 @@ static int decode_compound_hdr(struct xd
 
 static int decode_op_hdr(struct xdr_stream *xdr, enum nfs_opnum4 expected)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t opnum;
 	int32_t nfserr;
 
@@ -2134,7 +2134,7 @@ static int decode_op_hdr(struct xdr_stre
 /* Dummy routine */
 static int decode_ace(struct xdr_stream *xdr, void *ace, struct nfs_client *clp)
 {
-	uint32_t *p;
+	__be32 *p;
 	unsigned int strlen;
 	char *str;
 
@@ -2144,7 +2144,8 @@ static int decode_ace(struct xdr_stream 
 
 static int decode_attr_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 {
-	uint32_t bmlen, *p;
+	uint32_t bmlen;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(bmlen);
@@ -2159,9 +2160,9 @@ static int decode_attr_bitmap(struct xdr
 	return 0;
 }
 
-static inline int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen, uint32_t **savep)
+static inline int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen, __be32 **savep)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(4);
 	READ32(*attrlen);
@@ -2182,7 +2183,7 @@ static int decode_attr_supported(struct 
 
 static int decode_attr_type(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *type)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*type = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_TYPE - 1U)))
@@ -2202,7 +2203,7 @@ static int decode_attr_type(struct xdr_s
 
 static int decode_attr_change(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *change)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*change = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_CHANGE - 1U)))
@@ -2219,7 +2220,7 @@ static int decode_attr_change(struct xdr
 
 static int decode_attr_size(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *size)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*size = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_SIZE - 1U)))
@@ -2235,7 +2236,7 @@ static int decode_attr_size(struct xdr_s
 
 static int decode_attr_link_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_LINK_SUPPORT - 1U)))
@@ -2251,7 +2252,7 @@ static int decode_attr_link_support(stru
 
 static int decode_attr_symlink_support(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_SYMLINK_SUPPORT - 1U)))
@@ -2267,7 +2268,7 @@ static int decode_attr_symlink_support(s
 
 static int decode_attr_fsid(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_fsid *fsid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	fsid->major = 0;
 	fsid->minor = 0;
@@ -2287,7 +2288,7 @@ static int decode_attr_fsid(struct xdr_s
 
 static int decode_attr_lease_time(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = 60;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_LEASE_TIME - 1U)))
@@ -2303,7 +2304,7 @@ static int decode_attr_lease_time(struct
 
 static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*res = ACL4_SUPPORT_ALLOW_ACL|ACL4_SUPPORT_DENY_ACL;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_ACLSUPPORT - 1U)))
@@ -2319,7 +2320,7 @@ static int decode_attr_aclsupport(struct
 
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*fileid = 0;
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_FILEID - 1U)))
@@ -2335,7 +2336,7 @@ static int decode_attr_fileid(struct xdr
 
 static int decode_attr_mounted_on_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*fileid = 0;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_MOUNTED_ON_FILEID - 1U)))
@@ -2351,7 +2352,7 @@ static int decode_attr_mounted_on_fileid
 
 static int decode_attr_files_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2368,7 +2369,7 @@ static int decode_attr_files_avail(struc
 
 static int decode_attr_files_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2385,7 +2386,7 @@ static int decode_attr_files_free(struct
 
 static int decode_attr_files_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2403,7 +2404,7 @@ static int decode_attr_files_total(struc
 static int decode_pathname(struct xdr_stream *xdr, struct nfs4_pathname *path)
 {
 	int n;
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	READ_BUF(4);
@@ -2448,7 +2449,7 @@ out_eio:
 static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs4_fs_locations *res)
 {
 	int n;
-	uint32_t *p;
+	__be32 *p;
 	int status = -EIO;
 
 	if (unlikely(bitmap[0] & (FATTR4_WORD0_FS_LOCATIONS -1U)))
@@ -2512,7 +2513,7 @@ out_eio:
 
 static int decode_attr_maxfilesize(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2529,7 +2530,7 @@ static int decode_attr_maxfilesize(struc
 
 static int decode_attr_maxlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxlink)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*maxlink = 1;
@@ -2546,7 +2547,7 @@ static int decode_attr_maxlink(struct xd
 
 static int decode_attr_maxname(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *maxname)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*maxname = 1024;
@@ -2563,7 +2564,7 @@ static int decode_attr_maxname(struct xd
 
 static int decode_attr_maxread(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 1024;
@@ -2584,7 +2585,7 @@ static int decode_attr_maxread(struct xd
 
 static int decode_attr_maxwrite(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 1024;
@@ -2605,7 +2606,7 @@ static int decode_attr_maxwrite(struct x
 
 static int decode_attr_mode(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *mode)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*mode = 0;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_MODE - 1U)))
@@ -2622,7 +2623,7 @@ static int decode_attr_mode(struct xdr_s
 
 static int decode_attr_nlink(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *nlink)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*nlink = 1;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_NUMLINKS - 1U)))
@@ -2638,7 +2639,8 @@ static int decode_attr_nlink(struct xdr_
 
 static int decode_attr_owner(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_client *clp, int32_t *uid)
 {
-	uint32_t len, *p;
+	uint32_t len;
+	__be32 *p;
 
 	*uid = -2;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_OWNER - 1U)))
@@ -2662,7 +2664,8 @@ static int decode_attr_owner(struct xdr_
 
 static int decode_attr_group(struct xdr_stream *xdr, uint32_t *bitmap, struct nfs_client *clp, int32_t *gid)
 {
-	uint32_t len, *p;
+	uint32_t len;
+	__be32 *p;
 
 	*gid = -2;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_OWNER_GROUP - 1U)))
@@ -2686,7 +2689,8 @@ static int decode_attr_group(struct xdr_
 
 static int decode_attr_rdev(struct xdr_stream *xdr, uint32_t *bitmap, dev_t *rdev)
 {
-	uint32_t major = 0, minor = 0, *p;
+	uint32_t major = 0, minor = 0;
+	__be32 *p;
 
 	*rdev = MKDEV(0,0);
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_RAWDEV - 1U)))
@@ -2708,7 +2712,7 @@ static int decode_attr_rdev(struct xdr_s
 
 static int decode_attr_space_avail(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2725,7 +2729,7 @@ static int decode_attr_space_avail(struc
 
 static int decode_attr_space_free(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2742,7 +2746,7 @@ static int decode_attr_space_free(struct
 
 static int decode_attr_space_total(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status = 0;
 
 	*res = 0;
@@ -2759,7 +2763,7 @@ static int decode_attr_space_total(struc
 
 static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *used)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	*used = 0;
 	if (unlikely(bitmap[1] & (FATTR4_WORD1_SPACE_USED - 1U)))
@@ -2776,7 +2780,7 @@ static int decode_attr_space_used(struct
 
 static int decode_attr_time(struct xdr_stream *xdr, struct timespec *time)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint64_t sec;
 	uint32_t nsec;
 
@@ -2836,7 +2840,7 @@ static int decode_attr_time_modify(struc
 	return status;
 }
 
-static int verify_attr_len(struct xdr_stream *xdr, uint32_t *savep, uint32_t attrlen)
+static int verify_attr_len(struct xdr_stream *xdr, __be32 *savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
 	unsigned int nwords = xdr->p - savep;
@@ -2854,7 +2858,7 @@ static int verify_attr_len(struct xdr_st
 
 static int decode_change_info(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 {
-	uint32_t *p;
+	__be32 *p;
 
 	READ_BUF(20);
 	READ32(cinfo->atomic);
@@ -2865,7 +2869,7 @@ static int decode_change_info(struct xdr
 
 static int decode_access(struct xdr_stream *xdr, struct nfs4_accessres *access)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t supp, acc;
 	int status;
 
@@ -2882,7 +2886,7 @@ static int decode_access(struct xdr_stre
 
 static int decode_close(struct xdr_stream *xdr, struct nfs_closeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_CLOSE);
@@ -2895,7 +2899,7 @@ static int decode_close(struct xdr_strea
 
 static int decode_commit(struct xdr_stream *xdr, struct nfs_writeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_COMMIT);
@@ -2908,7 +2912,7 @@ static int decode_commit(struct xdr_stre
 
 static int decode_create(struct xdr_stream *xdr, struct nfs4_change_info *cinfo)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t bmlen;
 	int status;
 
@@ -2925,7 +2929,7 @@ static int decode_create(struct xdr_stre
 
 static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_res *res)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen, 
 		 bitmap[2] = {0};
 	int status;
@@ -2952,7 +2956,7 @@ xdr_error:
 	
 static int decode_statfs(struct xdr_stream *xdr, struct nfs_fsstat *fsstat)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen, 
 		 bitmap[2] = {0};
 	int status;
@@ -2985,7 +2989,7 @@ xdr_error:
 
 static int decode_pathconf(struct xdr_stream *xdr, struct nfs_pathconf *pathconf)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen, 
 		 bitmap[2] = {0};
 	int status;
@@ -3010,7 +3014,7 @@ xdr_error:
 
 static int decode_getfattr(struct xdr_stream *xdr, struct nfs_fattr *fattr, const struct nfs_server *server)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen,
 		 bitmap[2] = {0},
 		 type;
@@ -3079,7 +3083,7 @@ xdr_error:
 
 static int decode_fsinfo(struct xdr_stream *xdr, struct nfs_fsinfo *fsinfo)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen, bitmap[2];
 	int status;
 
@@ -3111,7 +3115,7 @@ xdr_error:
 
 static int decode_getfh(struct xdr_stream *xdr, struct nfs_fh *fh)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t len;
 	int status;
 
@@ -3147,7 +3151,7 @@ static int decode_link(struct xdr_stream
 static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 {
 	uint64_t offset, length, clientid;
-	uint32_t *p;
+	__be32 *p;
 	uint32_t namelen, type;
 
 	READ_BUF(32);
@@ -3172,7 +3176,7 @@ static int decode_lock_denied (struct xd
 
 static int decode_lock(struct xdr_stream *xdr, struct nfs_lock_res *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_LOCK);
@@ -3195,7 +3199,7 @@ static int decode_lockt(struct xdr_strea
 
 static int decode_locku(struct xdr_stream *xdr, struct nfs_locku_res *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_LOCKU);
@@ -3214,7 +3218,7 @@ static int decode_lookup(struct xdr_stre
 /* This is too sick! */
 static int decode_space_limit(struct xdr_stream *xdr, u64 *maxsize)
 {
-        uint32_t *p;
+        __be32 *p;
 	uint32_t limit_type, nblocks, blocksize;
 
 	READ_BUF(12);
@@ -3233,7 +3237,7 @@ static int decode_space_limit(struct xdr
 
 static int decode_delegation(struct xdr_stream *xdr, struct nfs_openres *res)
 {
-        uint32_t *p;
+        __be32 *p;
         uint32_t delegation_type;
 
 	READ_BUF(4);
@@ -3259,7 +3263,7 @@ static int decode_delegation(struct xdr_
 
 static int decode_open(struct xdr_stream *xdr, struct nfs_openres *res)
 {
-        uint32_t *p;
+        __be32 *p;
         uint32_t bmlen;
         int status;
 
@@ -3287,7 +3291,7 @@ xdr_error:
 
 static int decode_open_confirm(struct xdr_stream *xdr, struct nfs_open_confirmres *res)
 {
-        uint32_t *p;
+        __be32 *p;
 	int status;
 
         status = decode_op_hdr(xdr, OP_OPEN_CONFIRM);
@@ -3300,7 +3304,7 @@ static int decode_open_confirm(struct xd
 
 static int decode_open_downgrade(struct xdr_stream *xdr, struct nfs_closeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_OPEN_DOWNGRADE);
@@ -3324,7 +3328,7 @@ static int decode_putrootfh(struct xdr_s
 static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req, struct nfs_readres *res)
 {
 	struct kvec *iov = req->rq_rcv_buf.head;
-	uint32_t *p;
+	__be32 *p;
 	uint32_t count, eof, recvd, hdrlen;
 	int status;
 
@@ -3354,7 +3358,7 @@ static int decode_readdir(struct xdr_str
 	struct page	*page = *rcvbuf->pages;
 	struct kvec	*iov = rcvbuf->head;
 	unsigned int	nr, pglen = rcvbuf->page_len;
-	uint32_t	*end, *entry, *p, *kaddr;
+	__be32		*end, *entry, *p, *kaddr;
 	uint32_t	len, attrlen, xlen;
 	int 		hdrlen, recvd, status;
 
@@ -3376,7 +3380,7 @@ static int decode_readdir(struct xdr_str
 	xdr_read_pages(xdr, pglen);
 
 	BUG_ON(pglen + readdir->pgbase > PAGE_CACHE_SIZE);
-	kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
+	kaddr = p = kmap_atomic(page, KM_USER0);
 	end = p + ((pglen + readdir->pgbase) >> 2);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -3428,7 +3432,7 @@ static int decode_readlink(struct xdr_st
 	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct kvec *iov = rcvbuf->head;
 	int hdrlen, len, recvd;
-	uint32_t *p;
+	__be32 *p;
 	char *kaddr;
 	int status;
 
@@ -3505,7 +3509,7 @@ decode_restorefh(struct xdr_stream *xdr)
 static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 		size_t *acl_len)
 {
-	uint32_t *savep;
+	__be32 *savep;
 	uint32_t attrlen,
 		 bitmap[2] = {0};
 	struct kvec *iov = req->rq_rcv_buf.head;
@@ -3551,7 +3555,7 @@ decode_savefh(struct xdr_stream *xdr)
 
 static int decode_setattr(struct xdr_stream *xdr, struct nfs_setattrres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t bmlen;
 	int status;
 
@@ -3567,7 +3571,7 @@ static int decode_setattr(struct xdr_str
 
 static int decode_setclientid(struct xdr_stream *xdr, struct nfs_client *clp)
 {
-	uint32_t *p;
+	__be32 *p;
 	uint32_t opnum;
 	int32_t nfserr;
 
@@ -3610,7 +3614,7 @@ static int decode_setclientid_confirm(st
 
 static int decode_write(struct xdr_stream *xdr, struct nfs_writeres *res)
 {
-	uint32_t *p;
+	__be32 *p;
 	int status;
 
 	status = decode_op_hdr(xdr, OP_WRITE);
@@ -3632,7 +3636,7 @@ static int decode_delegreturn(struct xdr
 /*
  * Decode OPEN_DOWNGRADE response
  */
-static int nfs4_xdr_dec_open_downgrade(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_closeres *res)
+static int nfs4_xdr_dec_open_downgrade(struct rpc_rqst *rqstp, __be32 *p, struct nfs_closeres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -3660,7 +3664,7 @@ out:
 /*
  * Decode ACCESS response
  */
-static int nfs4_xdr_dec_access(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_accessres *res)
+static int nfs4_xdr_dec_access(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_accessres *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3678,7 +3682,7 @@ out:
 /*
  * Decode LOOKUP response
  */
-static int nfs4_xdr_dec_lookup(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_lookup_res *res)
+static int nfs4_xdr_dec_lookup(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_lookup_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3701,7 +3705,7 @@ out:
 /*
  * Decode LOOKUP_ROOT response
  */
-static int nfs4_xdr_dec_lookup_root(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_lookup_res *res)
+static int nfs4_xdr_dec_lookup_root(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_lookup_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3721,7 +3725,7 @@ out:
 /*
  * Decode REMOVE response
  */
-static int nfs4_xdr_dec_remove(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_remove_res *res)
+static int nfs4_xdr_dec_remove(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_remove_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3742,7 +3746,7 @@ out:
 /*
  * Decode RENAME response
  */
-static int nfs4_xdr_dec_rename(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_rename_res *res)
+static int nfs4_xdr_dec_rename(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_rename_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3772,7 +3776,7 @@ out:
 /*
  * Decode LINK response
  */
-static int nfs4_xdr_dec_link(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_link_res *res)
+static int nfs4_xdr_dec_link(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_link_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3805,7 +3809,7 @@ out:
 /*
  * Decode CREATE response
  */
-static int nfs4_xdr_dec_create(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_create_res *res)
+static int nfs4_xdr_dec_create(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_create_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3834,7 +3838,7 @@ out:
 /*
  * Decode SYMLINK response
  */
-static int nfs4_xdr_dec_symlink(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_create_res *res)
+static int nfs4_xdr_dec_symlink(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_create_res *res)
 {
 	return nfs4_xdr_dec_create(rqstp, p, res);
 }
@@ -3842,7 +3846,7 @@ static int nfs4_xdr_dec_symlink(struct r
 /*
  * Decode GETATTR response
  */
-static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_getattr_res *res)
+static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_getattr_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3865,7 +3869,7 @@ out:
  * Encode an SETACL request
  */
 static int
-nfs4_xdr_enc_setacl(struct rpc_rqst *req, uint32_t *p, struct nfs_setaclargs *args)
+nfs4_xdr_enc_setacl(struct rpc_rqst *req, __be32 *p, struct nfs_setaclargs *args)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr = {
@@ -3886,7 +3890,7 @@ out:
  * Decode SETACL response
  */
 static int
-nfs4_xdr_dec_setacl(struct rpc_rqst *rqstp, uint32_t *p, void *res)
+nfs4_xdr_dec_setacl(struct rpc_rqst *rqstp, __be32 *p, void *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3908,7 +3912,7 @@ out:
  * Decode GETACL response
  */
 static int
-nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, uint32_t *p, size_t *acl_len)
+nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, __be32 *p, size_t *acl_len)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -3930,7 +3934,7 @@ out:
 /*
  * Decode CLOSE response
  */
-static int nfs4_xdr_dec_close(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_closeres *res)
+static int nfs4_xdr_dec_close(struct rpc_rqst *rqstp, __be32 *p, struct nfs_closeres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -3960,7 +3964,7 @@ out:
 /*
  * Decode OPEN response
  */
-static int nfs4_xdr_dec_open(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_openres *res)
+static int nfs4_xdr_dec_open(struct rpc_rqst *rqstp, __be32 *p, struct nfs_openres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -3994,7 +3998,7 @@ out:
 /*
  * Decode OPEN_CONFIRM response
  */
-static int nfs4_xdr_dec_open_confirm(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_open_confirmres *res)
+static int nfs4_xdr_dec_open_confirm(struct rpc_rqst *rqstp, __be32 *p, struct nfs_open_confirmres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -4015,7 +4019,7 @@ out:
 /*
  * Decode OPEN response
  */
-static int nfs4_xdr_dec_open_noattr(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_openres *res)
+static int nfs4_xdr_dec_open_noattr(struct rpc_rqst *rqstp, __be32 *p, struct nfs_openres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -4039,7 +4043,7 @@ out:
 /*
  * Decode SETATTR response
  */
-static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_setattrres *res)
+static int nfs4_xdr_dec_setattr(struct rpc_rqst *rqstp, __be32 *p, struct nfs_setattrres *res)
 {
         struct xdr_stream xdr;
         struct compound_hdr hdr;
@@ -4065,7 +4069,7 @@ out:
 /*
  * Decode LOCK response
  */
-static int nfs4_xdr_dec_lock(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_lock_res *res)
+static int nfs4_xdr_dec_lock(struct rpc_rqst *rqstp, __be32 *p, struct nfs_lock_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4086,7 +4090,7 @@ out:
 /*
  * Decode LOCKT response
  */
-static int nfs4_xdr_dec_lockt(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_lockt_res *res)
+static int nfs4_xdr_dec_lockt(struct rpc_rqst *rqstp, __be32 *p, struct nfs_lockt_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4107,7 +4111,7 @@ out:
 /*
  * Decode LOCKU response
  */
-static int nfs4_xdr_dec_locku(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_locku_res *res)
+static int nfs4_xdr_dec_locku(struct rpc_rqst *rqstp, __be32 *p, struct nfs_locku_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4128,7 +4132,7 @@ out:
 /*
  * Decode READLINK response
  */
-static int nfs4_xdr_dec_readlink(struct rpc_rqst *rqstp, uint32_t *p, void *res)
+static int nfs4_xdr_dec_readlink(struct rpc_rqst *rqstp, __be32 *p, void *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4149,7 +4153,7 @@ out:
 /*
  * Decode READDIR response
  */
-static int nfs4_xdr_dec_readdir(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_readdir_res *res)
+static int nfs4_xdr_dec_readdir(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_readdir_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4170,7 +4174,7 @@ out:
 /*
  * Decode Read response
  */
-static int nfs4_xdr_dec_read(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_readres *res)
+static int nfs4_xdr_dec_read(struct rpc_rqst *rqstp, __be32 *p, struct nfs_readres *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4193,7 +4197,7 @@ out:
 /*
  * Decode WRITE response
  */
-static int nfs4_xdr_dec_write(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_writeres *res)
+static int nfs4_xdr_dec_write(struct rpc_rqst *rqstp, __be32 *p, struct nfs_writeres *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4219,7 +4223,7 @@ out:
 /*
  * Decode COMMIT response
  */
-static int nfs4_xdr_dec_commit(struct rpc_rqst *rqstp, uint32_t *p, struct nfs_writeres *res)
+static int nfs4_xdr_dec_commit(struct rpc_rqst *rqstp, __be32 *p, struct nfs_writeres *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4243,7 +4247,7 @@ out:
 /*
  * FSINFO request
  */
-static int nfs4_xdr_dec_fsinfo(struct rpc_rqst *req, uint32_t *p, struct nfs_fsinfo *fsinfo)
+static int nfs4_xdr_dec_fsinfo(struct rpc_rqst *req, __be32 *p, struct nfs_fsinfo *fsinfo)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4263,7 +4267,7 @@ static int nfs4_xdr_dec_fsinfo(struct rp
 /*
  * PATHCONF request
  */
-static int nfs4_xdr_dec_pathconf(struct rpc_rqst *req, uint32_t *p, struct nfs_pathconf *pathconf)
+static int nfs4_xdr_dec_pathconf(struct rpc_rqst *req, __be32 *p, struct nfs_pathconf *pathconf)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4281,7 +4285,7 @@ static int nfs4_xdr_dec_pathconf(struct 
 /*
  * STATFS request
  */
-static int nfs4_xdr_dec_statfs(struct rpc_rqst *req, uint32_t *p, struct nfs_fsstat *fsstat)
+static int nfs4_xdr_dec_statfs(struct rpc_rqst *req, __be32 *p, struct nfs_fsstat *fsstat)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4299,7 +4303,7 @@ static int nfs4_xdr_dec_statfs(struct rp
 /*
  * GETATTR_BITMAP request
  */
-static int nfs4_xdr_dec_server_caps(struct rpc_rqst *req, uint32_t *p, struct nfs4_server_caps_res *res)
+static int nfs4_xdr_dec_server_caps(struct rpc_rqst *req, __be32 *p, struct nfs4_server_caps_res *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4318,7 +4322,7 @@ out:
 /*
  * Decode RENEW response
  */
-static int nfs4_xdr_dec_renew(struct rpc_rqst *rqstp, uint32_t *p, void *dummy)
+static int nfs4_xdr_dec_renew(struct rpc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4334,7 +4338,7 @@ static int nfs4_xdr_dec_renew(struct rpc
 /*
  * a SETCLIENTID request
  */
-static int nfs4_xdr_dec_setclientid(struct rpc_rqst *req, uint32_t *p,
+static int nfs4_xdr_dec_setclientid(struct rpc_rqst *req, __be32 *p,
 		struct nfs_client *clp)
 {
 	struct xdr_stream xdr;
@@ -4353,7 +4357,7 @@ static int nfs4_xdr_dec_setclientid(stru
 /*
  * a SETCLIENTID_CONFIRM request
  */
-static int nfs4_xdr_dec_setclientid_confirm(struct rpc_rqst *req, uint32_t *p, struct nfs_fsinfo *fsinfo)
+static int nfs4_xdr_dec_setclientid_confirm(struct rpc_rqst *req, __be32 *p, struct nfs_fsinfo *fsinfo)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4375,7 +4379,7 @@ static int nfs4_xdr_dec_setclientid_conf
 /*
  * DELEGRETURN request
  */
-static int nfs4_xdr_dec_delegreturn(struct rpc_rqst *rqstp, uint32_t *p, struct nfs4_delegreturnres *res)
+static int nfs4_xdr_dec_delegreturn(struct rpc_rqst *rqstp, __be32 *p, struct nfs4_delegreturnres *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
@@ -4397,7 +4401,7 @@ out:
 /*
  * FS_LOCATIONS request
  */
-static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req, uint32_t *p, struct nfs4_fs_locations *res)
+static int nfs4_xdr_dec_fs_locations(struct rpc_rqst *req, __be32 *p, struct nfs4_fs_locations *res)
 {
 	struct xdr_stream xdr;
 	struct compound_hdr hdr;
-- 
1.4.2.GIT


