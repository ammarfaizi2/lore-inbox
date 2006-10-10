Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWJJDNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWJJDNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWJJDNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28077 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964926AbWJJDNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:32 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] xdr annotations: NFSv4 server
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83f-0004G0-9m@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs4proc.c        |    2 +
 fs/nfsd/nfs4xdr.c         |   66 +++++++++++++++++++++++----------------------
 include/linux/nfsd/xdr4.h |   24 ++++++++--------
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0b3000c..d0a8ee2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -664,7 +664,7 @@ nfsd4_write(struct svc_rqst *rqstp, stru
 static int
 nfsd4_verify(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_verify *verify)
 {
-	u32 *buf, *p;
+	__be32 *buf, *p;
 	int count;
 	int status;
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 77be0c4..3419d99 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -94,7 +94,7 @@ check_filename(char *str, int len, int e
  * consistent with the style used in NFSv2/v3...
  */
 #define DECODE_HEAD				\
-	u32 *p;					\
+	__be32 *p;				\
 	int status
 #define DECODE_TAIL				\
 	status = 0;				\
@@ -144,13 +144,13 @@ #define READ_BUF(nbytes)  do {			\
 	}					\
 } while (0)
 
-static u32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
+static __be32 *read_buf(struct nfsd4_compoundargs *argp, int nbytes)
 {
 	/* We want more bytes than seem to be available.
 	 * Maybe we need a new page, maybe we have just run out
 	 */
 	int avail = (char*)argp->end - (char*)argp->p;
-	u32 *p;
+	__be32 *p;
 	if (avail + argp->pagelen < nbytes)
 		return NULL;
 	if (avail + PAGE_SIZE < nbytes) /* need more than a page !! */
@@ -197,7 +197,7 @@ defer_free(struct nfsd4_compoundargs *ar
 	return 0;
 }
 
-static char *savemem(struct nfsd4_compoundargs *argp, u32 *p, int nbytes)
+static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 {
 	void *new = NULL;
 	if (p == argp->tmp) {
@@ -951,8 +951,8 @@ nfsd4_decode_write(struct nfsd4_compound
 			argp->pagelen -= len;
 		}
 	}
-	argp->end = (u32*) (argp->rqstp->rq_vec[v].iov_base + argp->rqstp->rq_vec[v].iov_len);
-	argp->p = (u32*)  (argp->rqstp->rq_vec[v].iov_base + (XDR_QUADLEN(len) << 2));
+	argp->end = (__be32*) (argp->rqstp->rq_vec[v].iov_base + argp->rqstp->rq_vec[v].iov_len);
+	argp->p = (__be32*)  (argp->rqstp->rq_vec[v].iov_base + (XDR_QUADLEN(len) << 2));
 	argp->rqstp->rq_vec[v].iov_len = len;
 	write->wr_vlen = v+1;
 
@@ -1179,7 +1179,7 @@ nfsd4_decode_compound(struct nfsd4_compo
  * task to translate them into Linux-specific versions which are more
  * consistent with the style used in NFSv2/v3...
  */
-#define ENCODE_HEAD              u32 *p
+#define ENCODE_HEAD              __be32 *p
 
 #define WRITE32(n)               *p++ = htonl(n)
 #define WRITE64(n)               do {				\
@@ -1209,8 +1209,8 @@ #define ADJUST_ARGS()		resp->p = p
  * Header routine to setup seqid operation replay cache
  */
 #define ENCODE_SEQID_OP_HEAD					\
-	u32 *p;							\
-	u32 *save;						\
+	__be32 *p;						\
+	__be32 *save;						\
 								\
 	save = resp->p;
 
@@ -1235,10 +1235,10 @@ #define ENCODE_SEQID_OP_TAIL(stateowner)
  * seperated @sep.
  */
 static int nfsd4_encode_components(char sep, char *components,
-				   u32 **pp, int *buflen)
+				   __be32 **pp, int *buflen)
 {
-	u32 *p = *pp;
-	u32 *countp = p;
+	__be32 *p = *pp;
+	__be32 *countp = p;
 	int strlen, count=0;
 	char *str, *end;
 
@@ -1272,10 +1272,10 @@ static int nfsd4_encode_components(char 
  * encode a location element of a fs_locations structure
  */
 static int nfsd4_encode_fs_location4(struct nfsd4_fs_location *location,
-				    u32 **pp, int *buflen)
+				    __be32 **pp, int *buflen)
 {
 	int status;
-	u32 *p = *pp;
+	__be32 *p = *pp;
 
 	status = nfsd4_encode_components(':', location->hosts, &p, buflen);
 	if (status)
@@ -1320,11 +1320,11 @@ static char *nfsd4_path(struct svc_rqst 
  */
 static int nfsd4_encode_fs_locations(struct svc_rqst *rqstp,
 				     struct svc_export *exp,
-				     u32 **pp, int *buflen)
+				     __be32 **pp, int *buflen)
 {
 	u32 status;
 	int i;
-	u32 *p = *pp;
+	__be32 *p = *pp;
 	struct nfsd4_fs_locations *fslocs = &exp->ex_fslocs;
 	char *root = nfsd4_path(rqstp, exp, &status);
 
@@ -1355,7 +1355,7 @@ static u32 nfs4_ftypes[16] = {
 
 static int
 nfsd4_encode_name(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
-			u32 **p, int *buflen)
+			__be32 **p, int *buflen)
 {
 	int status;
 
@@ -1376,20 +1376,20 @@ nfsd4_encode_name(struct svc_rqst *rqstp
 }
 
 static inline int
-nfsd4_encode_user(struct svc_rqst *rqstp, uid_t uid, u32 **p, int *buflen)
+nfsd4_encode_user(struct svc_rqst *rqstp, uid_t uid, __be32 **p, int *buflen)
 {
 	return nfsd4_encode_name(rqstp, NFS4_ACL_WHO_NAMED, uid, 0, p, buflen);
 }
 
 static inline int
-nfsd4_encode_group(struct svc_rqst *rqstp, uid_t gid, u32 **p, int *buflen)
+nfsd4_encode_group(struct svc_rqst *rqstp, uid_t gid, __be32 **p, int *buflen)
 {
 	return nfsd4_encode_name(rqstp, NFS4_ACL_WHO_NAMED, gid, 1, p, buflen);
 }
 
 static inline int
 nfsd4_encode_aclname(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
-		u32 **p, int *buflen)
+		__be32 **p, int *buflen)
 {
 	return nfsd4_encode_name(rqstp, whotype, id, group, p, buflen);
 }
@@ -1423,7 +1423,7 @@ static int fattr_handle_absent_fs(u32 *b
  */
 int
 nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
-		struct dentry *dentry, u32 *buffer, int *countp, u32 *bmval,
+		struct dentry *dentry, __be32 *buffer, int *countp, u32 *bmval,
 		struct svc_rqst *rqstp)
 {
 	u32 bmval0 = bmval[0];
@@ -1432,11 +1432,11 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	struct svc_fh tempfh;
 	struct kstatfs statfs;
 	int buflen = *countp << 2;
-	u32 *attrlenp;
+	__be32 *attrlenp;
 	u32 dummy;
 	u64 dummy64;
 	u32 rdattr_err = 0;
-	u32 *p = buffer;
+	__be32 *p = buffer;
 	int status;
 	int aclsupport = 0;
 	struct nfs4_acl *acl = NULL;
@@ -1831,7 +1831,7 @@ out_serverfault:
 
 static int
 nfsd4_encode_dirent_fattr(struct nfsd4_readdir *cd,
-		const char *name, int namlen, u32 *p, int *buflen)
+		const char *name, int namlen, __be32 *p, int *buflen)
 {
 	struct svc_export *exp = cd->rd_fhp->fh_export;
 	struct dentry *dentry;
@@ -1864,10 +1864,10 @@ out_put:
 	return nfserr;
 }
 
-static u32 *
-nfsd4_encode_rdattr_error(u32 *p, int buflen, int nfserr)
+static __be32 *
+nfsd4_encode_rdattr_error(__be32 *p, int buflen, int nfserr)
 {
-	u32 *attrlenp;
+	__be32 *attrlenp;
 
 	if (buflen < 6)
 		return NULL;
@@ -1887,7 +1887,7 @@ nfsd4_encode_dirent(struct readdir_cd *c
 {
 	struct nfsd4_readdir *cd = container_of(ccd, struct nfsd4_readdir, common);
 	int buflen;
-	u32 *p = cd->buffer;
+	__be32 *p = cd->buffer;
 	int nfserr = nfserr_toosmall;
 
 	/* In nfsv4, "." and ".." never make it onto the wire.. */
@@ -2321,7 +2321,7 @@ nfsd4_encode_readdir(struct nfsd4_compou
 {
 	int maxcount;
 	loff_t offset;
-	u32 *page, *savep, *tailbase;
+	__be32 *page, *savep, *tailbase;
 	ENCODE_HEAD;
 
 	if (nfserr)
@@ -2479,7 +2479,7 @@ nfsd4_encode_write(struct nfsd4_compound
 void
 nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 {
-	u32 *statp;
+	__be32 *statp;
 	ENCODE_HEAD;
 
 	RESERVE_SPACE(8);
@@ -2617,7 +2617,7 @@ nfsd4_encode_replay(struct nfsd4_compoun
  */
 
 int
-nfs4svc_encode_voidres(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nfs4svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
         return xdr_ressize_check(rqstp, p);
 }
@@ -2639,7 +2639,7 @@ void nfsd4_release_compoundargs(struct n
 }
 
 int
-nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, u32 *p, struct nfsd4_compoundargs *args)
+nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p, struct nfsd4_compoundargs *args)
 {
 	int status;
 
@@ -2660,7 +2660,7 @@ nfs4svc_decode_compoundargs(struct svc_r
 }
 
 int
-nfs4svc_encode_compoundres(struct svc_rqst *rqstp, u32 *p, struct nfsd4_compoundres *resp)
+nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p, struct nfsd4_compoundres *resp)
 {
 	/*
 	 * All that remains is to write the tag and operation count...
diff --git a/include/linux/nfsd/xdr4.h b/include/linux/nfsd/xdr4.h
index 66e6427..003193f 100644
--- a/include/linux/nfsd/xdr4.h
+++ b/include/linux/nfsd/xdr4.h
@@ -258,9 +258,9 @@ struct nfsd4_readdir {
 	struct svc_fh * rd_fhp;             /* response */
 
 	struct readdir_cd	common;
-	u32 *			buffer;
+	__be32 *		buffer;
 	int			buflen;
-	u32 *			offset;
+	__be32 *		offset;
 };
 
 struct nfsd4_release_lockowner {
@@ -371,12 +371,12 @@ struct nfsd4_op {
 
 struct nfsd4_compoundargs {
 	/* scratch variables for XDR decode */
-	u32 *				p;
-	u32 *				end;
+	__be32 *			p;
+	__be32 *			end;
 	struct page **			pagelist;
 	int				pagelen;
-	u32				tmp[8];
-	u32 *				tmpp;
+	__be32				tmp[8];
+	__be32 *			tmpp;
 	struct tmpbuf {
 		struct tmpbuf *next;
 		void (*release)(const void *);
@@ -395,15 +395,15 @@ struct nfsd4_compoundargs {
 
 struct nfsd4_compoundres {
 	/* scratch variables for XDR encode */
-	u32 *				p;
-	u32 *				end;
+	__be32 *			p;
+	__be32 *			end;
 	struct xdr_buf *		xbuf;
 	struct svc_rqst *		rqstp;
 
 	u32				taglen;
 	char *				tag;
 	u32				opcnt;
-	u32 *				tagp; /* where to encode tag and  opcount */
+	__be32 *			tagp; /* where to encode tag and  opcount */
 };
 
 #define NFS4_SVC_XDRSIZE		sizeof(struct nfsd4_compoundargs)
@@ -419,10 +419,10 @@ set_change_info(struct nfsd4_change_info
 	cinfo->after_ctime_nsec = fhp->fh_post_ctime.tv_nsec;
 }
 
-int nfs4svc_encode_voidres(struct svc_rqst *, u32 *, void *);
-int nfs4svc_decode_compoundargs(struct svc_rqst *, u32 *, 
+int nfs4svc_encode_voidres(struct svc_rqst *, __be32 *, void *);
+int nfs4svc_decode_compoundargs(struct svc_rqst *, __be32 *,
 		struct nfsd4_compoundargs *);
-int nfs4svc_encode_compoundres(struct svc_rqst *, u32 *, 
+int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *,
 		struct nfsd4_compoundres *);
 void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct nfsd4_compoundres *resp, struct nfsd4_op *op);
-- 
1.4.2.GIT


