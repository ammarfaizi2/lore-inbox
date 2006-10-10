Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWJJDNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWJJDNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWJJDNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27309 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964824AbWJJDNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:22 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] xdr annotations: NFSv3 server
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83V-0004Fi-9H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs3acl.c         |   10 ++--
 fs/nfsd/nfs3xdr.c         |  126 +++++++++++++++++++++++----------------------
 include/linux/nfsd/xdr3.h |  114 ++++++++++++++++++++---------------------
 3 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index ed6e2c2..78b2c83 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -122,7 +122,7 @@ static __be32 nfsd3_proc_setacl(struct s
 /*
  * XDR decode functions
  */
-static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, u32 *p,
+static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclargs *args)
 {
 	if (!(p = nfs3svc_decode_fh(p, &args->fh)))
@@ -133,7 +133,7 @@ static int nfs3svc_decode_getaclargs(str
 }
 
 
-static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, u32 *p,
+static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_setaclargs *args)
 {
 	struct kvec *head = rqstp->rq_arg.head;
@@ -163,7 +163,7 @@ static int nfs3svc_decode_setaclargs(str
  */
 
 /* GETACL */
-static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, u32 *p,
+static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclres *resp)
 {
 	struct dentry *dentry = resp->fh.fh_dentry;
@@ -208,7 +208,7 @@ static int nfs3svc_encode_getaclres(stru
 }
 
 /* SETACL */
-static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, u32 *p,
+static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_attrstat *resp)
 {
 	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
@@ -219,7 +219,7 @@ static int nfs3svc_encode_setaclres(stru
 /*
  * XDR release functions
  */
-static int nfs3svc_release_getacl(struct svc_rqst *rqstp, u32 *p,
+static int nfs3svc_release_getacl(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclres *resp)
 {
 	fh_put(&resp->fh);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 247d518..b4baca3 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -42,23 +42,23 @@ static u32	nfs3_ftypes[] = {
 /*
  * XDR functions for basic NFS types
  */
-static inline u32 *
-encode_time3(u32 *p, struct timespec *time)
+static inline __be32 *
+encode_time3(__be32 *p, struct timespec *time)
 {
 	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
 	return p;
 }
 
-static inline u32 *
-decode_time3(u32 *p, struct timespec *time)
+static inline __be32 *
+decode_time3(__be32 *p, struct timespec *time)
 {
 	time->tv_sec = ntohl(*p++);
 	time->tv_nsec = ntohl(*p++);
 	return p;
 }
 
-static inline u32 *
-decode_fh(u32 *p, struct svc_fh *fhp)
+static inline __be32 *
+decode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	unsigned int size;
 	fh_init(fhp, NFS3_FHSIZE);
@@ -72,13 +72,13 @@ decode_fh(u32 *p, struct svc_fh *fhp)
 }
 
 /* Helper function for NFSv3 ACL code */
-u32 *nfs3svc_decode_fh(u32 *p, struct svc_fh *fhp)
+__be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	return decode_fh(p, fhp);
 }
 
-static inline u32 *
-encode_fh(u32 *p, struct svc_fh *fhp)
+static inline __be32 *
+encode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	unsigned int size = fhp->fh_handle.fh_size;
 	*p++ = htonl(size);
@@ -91,8 +91,8 @@ encode_fh(u32 *p, struct svc_fh *fhp)
  * Decode a file name and make sure that the path contains
  * no slashes or null bytes.
  */
-static inline u32 *
-decode_filename(u32 *p, char **namp, int *lenp)
+static inline __be32 *
+decode_filename(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
 	int		i;
@@ -107,8 +107,8 @@ decode_filename(u32 *p, char **namp, int
 	return p;
 }
 
-static inline u32 *
-decode_sattr3(u32 *p, struct iattr *iap)
+static inline __be32 *
+decode_sattr3(__be32 *p, struct iattr *iap)
 {
 	u32	tmp;
 
@@ -153,8 +153,8 @@ decode_sattr3(u32 *p, struct iattr *iap)
 	return p;
 }
 
-static inline u32 *
-encode_fattr3(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp,
+static inline __be32 *
+encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	      struct kstat *stat)
 {
 	struct dentry	*dentry = fhp->fh_dentry;
@@ -186,8 +186,8 @@ encode_fattr3(struct svc_rqst *rqstp, u3
 	return p;
 }
 
-static inline u32 *
-encode_saved_post_attr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
+static inline __be32 *
+encode_saved_post_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct inode	*inode = fhp->fh_dentry->d_inode;
 
@@ -224,8 +224,8 @@ encode_saved_post_attr(struct svc_rqst *
  * The inode may be NULL if the call failed because of a stale file
  * handle. In this case, no attributes are returned.
  */
-static u32 *
-encode_post_op_attr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
+static __be32 *
+encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct dentry *dentry = fhp->fh_dentry;
 	if (dentry && dentry->d_inode != NULL) {
@@ -243,8 +243,8 @@ encode_post_op_attr(struct svc_rqst *rqs
 }
 
 /* Helper for NFSv3 ACLs */
-u32 *
-nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
+__be32 *
+nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	return encode_post_op_attr(rqstp, p, fhp);
 }
@@ -252,8 +252,8 @@ nfs3svc_encode_post_op_attr(struct svc_r
 /*
  * Enocde weak cache consistency data
  */
-static u32 *
-encode_wcc_data(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
+static __be32 *
+encode_wcc_data(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct dentry	*dentry = fhp->fh_dentry;
 
@@ -278,7 +278,7 @@ encode_wcc_data(struct svc_rqst *rqstp, 
  * XDR decode functions
  */
 int
-nfs3svc_decode_fhandle(struct svc_rqst *rqstp, u32 *p, struct nfsd_fhandle *args)
+nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p, struct nfsd_fhandle *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
@@ -286,7 +286,7 @@ nfs3svc_decode_fhandle(struct svc_rqst *
 }
 
 int
-nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_sattrargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -303,7 +303,7 @@ nfs3svc_decode_sattrargs(struct svc_rqst
 }
 
 int
-nfs3svc_decode_diropargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_diropargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -314,7 +314,7 @@ nfs3svc_decode_diropargs(struct svc_rqst
 }
 
 int
-nfs3svc_decode_accessargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_accessargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
@@ -325,7 +325,7 @@ nfs3svc_decode_accessargs(struct svc_rqs
 }
 
 int
-nfs3svc_decode_readargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readargs *args)
 {
 	unsigned int len;
@@ -355,7 +355,7 @@ nfs3svc_decode_readargs(struct svc_rqst 
 }
 
 int
-nfs3svc_decode_writeargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_writeargs *args)
 {
 	unsigned int len, v, hdr;
@@ -393,7 +393,7 @@ nfs3svc_decode_writeargs(struct svc_rqst
 }
 
 int
-nfs3svc_decode_createargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_createargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_createargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -417,7 +417,7 @@ nfs3svc_decode_createargs(struct svc_rqs
 	return xdr_argsize_check(rqstp, p);
 }
 int
-nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_createargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -429,7 +429,7 @@ nfs3svc_decode_mkdirargs(struct svc_rqst
 }
 
 int
-nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_symlinkargs *args)
 {
 	unsigned int len;
@@ -481,7 +481,7 @@ nfs3svc_decode_symlinkargs(struct svc_rq
 }
 
 int
-nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_mknodargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_mknodargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -505,7 +505,7 @@ nfs3svc_decode_mknodargs(struct svc_rqst
 }
 
 int
-nfs3svc_decode_renameargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_renameargs *args)
 {
 	if (!(p = decode_fh(p, &args->ffh))
@@ -518,7 +518,7 @@ nfs3svc_decode_renameargs(struct svc_rqs
 }
 
 int
-nfs3svc_decode_readlinkargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_readlinkargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readlinkargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
@@ -530,7 +530,7 @@ nfs3svc_decode_readlinkargs(struct svc_r
 }
 
 int
-nfs3svc_decode_linkargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_linkargs *args)
 {
 	if (!(p = decode_fh(p, &args->ffh))
@@ -542,7 +542,7 @@ nfs3svc_decode_linkargs(struct svc_rqst 
 }
 
 int
-nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readdirargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
@@ -562,7 +562,7 @@ nfs3svc_decode_readdirargs(struct svc_rq
 }
 
 int
-nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readdirargs *args)
 {
 	int len, pn;
@@ -590,7 +590,7 @@ nfs3svc_decode_readdirplusargs(struct sv
 }
 
 int
-nfs3svc_decode_commitargs(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_commitargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
@@ -609,14 +609,14 @@ nfs3svc_decode_commitargs(struct svc_rqs
  * will work properly.
  */
 int
-nfs3svc_encode_voidres(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nfs3svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
 
 /* GETATTR */
 int
-nfs3svc_encode_attrstat(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_attrstat *resp)
 {
 	if (resp->status == 0)
@@ -626,7 +626,7 @@ nfs3svc_encode_attrstat(struct svc_rqst 
 
 /* SETATTR, REMOVE, RMDIR */
 int
-nfs3svc_encode_wccstat(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_attrstat *resp)
 {
 	p = encode_wcc_data(rqstp, p, &resp->fh);
@@ -635,7 +635,7 @@ nfs3svc_encode_wccstat(struct svc_rqst *
 
 /* LOOKUP */
 int
-nfs3svc_encode_diropres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_diropres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_diropres *resp)
 {
 	if (resp->status == 0) {
@@ -648,7 +648,7 @@ nfs3svc_encode_diropres(struct svc_rqst 
 
 /* ACCESS */
 int
-nfs3svc_encode_accessres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_accessres *resp)
 {
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -659,7 +659,7 @@ nfs3svc_encode_accessres(struct svc_rqst
 
 /* READLINK */
 int
-nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readlinkres *resp)
 {
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -680,7 +680,7 @@ nfs3svc_encode_readlinkres(struct svc_rq
 
 /* READ */
 int
-nfs3svc_encode_readres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readres *resp)
 {
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -704,7 +704,7 @@ nfs3svc_encode_readres(struct svc_rqst *
 
 /* WRITE */
 int
-nfs3svc_encode_writeres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_writeres *resp)
 {
 	p = encode_wcc_data(rqstp, p, &resp->fh);
@@ -719,7 +719,7 @@ nfs3svc_encode_writeres(struct svc_rqst 
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */
 int
-nfs3svc_encode_createres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_diropres *resp)
 {
 	if (resp->status == 0) {
@@ -733,7 +733,7 @@ nfs3svc_encode_createres(struct svc_rqst
 
 /* RENAME */
 int
-nfs3svc_encode_renameres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_renameres *resp)
 {
 	p = encode_wcc_data(rqstp, p, &resp->ffh);
@@ -743,7 +743,7 @@ nfs3svc_encode_renameres(struct svc_rqst
 
 /* LINK */
 int
-nfs3svc_encode_linkres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_linkres *resp)
 {
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -753,7 +753,7 @@ nfs3svc_encode_linkres(struct svc_rqst *
 
 /* READDIR */
 int
-nfs3svc_encode_readdirres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_readdirres *resp)
 {
 	p = encode_post_op_attr(rqstp, p, &resp->fh);
@@ -776,8 +776,8 @@ nfs3svc_encode_readdirres(struct svc_rqs
 		return xdr_ressize_check(rqstp, p);
 }
 
-static inline u32 *
-encode_entry_baggage(struct nfsd3_readdirres *cd, u32 *p, const char *name,
+static inline __be32 *
+encode_entry_baggage(struct nfsd3_readdirres *cd, __be32 *p, const char *name,
 	     int namlen, ino_t ino)
 {
 	*p++ = xdr_one;				 /* mark entry present */
@@ -790,8 +790,8 @@ encode_entry_baggage(struct nfsd3_readdi
 	return p;
 }
 
-static inline u32 *
-encode_entryplus_baggage(struct nfsd3_readdirres *cd, u32 *p,
+static inline __be32 *
+encode_entryplus_baggage(struct nfsd3_readdirres *cd, __be32 *p,
 		struct svc_fh *fhp)
 {
 		p = encode_post_op_attr(cd->rqstp, p, fhp);
@@ -853,7 +853,7 @@ encode_entry(struct readdir_cd *ccd, con
 {
 	struct nfsd3_readdirres *cd = container_of(ccd, struct nfsd3_readdirres,
 		       					common);
-	u32		*p = cd->buffer;
+	__be32		*p = cd->buffer;
 	caddr_t		curr_page_addr = NULL;
 	int		pn;		/* current page number */
 	int		slen;		/* string (name) length */
@@ -919,7 +919,7 @@ encode_entry(struct readdir_cd *ccd, con
 	} else if (cd->rqstp->rq_respages[pn+1] != NULL) {
 		/* temporarily encode entry into next page, then move back to
 		 * current and next page in rq_respages[] */
-		u32 *p1, *tmp;
+		__be32 *p1, *tmp;
 		int len1, len2;
 
 		/* grab next page for temporary storage of entry */
@@ -1009,7 +1009,7 @@ nfs3svc_encode_entry_plus(struct readdir
 
 /* FSSTAT */
 int
-nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_fsstatres *resp)
 {
 	struct kstatfs	*s = &resp->stats;
@@ -1031,7 +1031,7 @@ nfs3svc_encode_fsstatres(struct svc_rqst
 
 /* FSINFO */
 int
-nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_fsinfores *resp)
 {
 	*p++ = xdr_zero;	/* no post_op_attr */
@@ -1055,7 +1055,7 @@ nfs3svc_encode_fsinfores(struct svc_rqst
 
 /* PATHCONF */
 int
-nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_pathconfres *resp)
 {
 	*p++ = xdr_zero;	/* no post_op_attr */
@@ -1074,7 +1074,7 @@ nfs3svc_encode_pathconfres(struct svc_rq
 
 /* COMMIT */
 int
-nfs3svc_encode_commitres(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_commitres *resp)
 {
 	p = encode_wcc_data(rqstp, p, &resp->fh);
@@ -1090,7 +1090,7 @@ nfs3svc_encode_commitres(struct svc_rqst
  * XDR release functions
  */
 int
-nfs3svc_release_fhandle(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_release_fhandle(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_attrstat *resp)
 {
 	fh_put(&resp->fh);
@@ -1098,7 +1098,7 @@ nfs3svc_release_fhandle(struct svc_rqst 
 }
 
 int
-nfs3svc_release_fhandle2(struct svc_rqst *rqstp, u32 *p,
+nfs3svc_release_fhandle2(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd3_fhandle_pair *resp)
 {
 	fh_put(&resp->fh1);
diff --git a/include/linux/nfsd/xdr3.h b/include/linux/nfsd/xdr3.h
index 474d882..7996386 100644
--- a/include/linux/nfsd/xdr3.h
+++ b/include/linux/nfsd/xdr3.h
@@ -51,7 +51,7 @@ struct nfsd3_createargs {
 	int			len;
 	int			createmode;
 	struct iattr		attrs;
-	__u32 *			verf;
+	__be32 *		verf;
 };
 
 struct nfsd3_mknodargs {
@@ -98,8 +98,8 @@ struct nfsd3_readdirargs {
 	__u64			cookie;
 	__u32			dircount;
 	__u32			count;
-	__u32 *			verf;
-	u32 *			buffer;
+	__be32 *		verf;
+	__be32 *		buffer;
 };
 
 struct nfsd3_commitargs {
@@ -122,79 +122,79 @@ struct nfsd3_setaclargs {
 };
 
 struct nfsd3_attrstat {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	struct kstat            stat;
 };
 
 /* LOOKUP, CREATE, MKDIR, SYMLINK, MKNOD */
 struct nfsd3_diropres  {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		dirfh;
 	struct svc_fh		fh;
 };
 
 struct nfsd3_accessres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	__u32			access;
 };
 
 struct nfsd3_readlinkres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	__u32			len;
 };
 
 struct nfsd3_readres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
 	int			eof;
 };
 
 struct nfsd3_writeres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
 	int			committed;
 };
 
 struct nfsd3_renameres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		ffh;
 	struct svc_fh		tfh;
 };
 
 struct nfsd3_linkres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		tfh;
 	struct svc_fh		fh;
 };
 
 struct nfsd3_readdirres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	int			count;
-	__u32			verf[2];
+	__be32			verf[2];
 
 	struct readdir_cd	common;
-	u32 *			buffer;
+	__be32 *		buffer;
 	int			buflen;
-	u32 *			offset;
-	u32 *			offset1;
+	__be32 *		offset;
+	__be32 *		offset1;
 	struct svc_rqst *	rqstp;
 
 };
 
 struct nfsd3_fsstatres {
-	__u32			status;
+	__be32			status;
 	struct kstatfs		stats;
 	__u32			invarsec;
 };
 
 struct nfsd3_fsinfores {
-	__u32			status;
+	__be32			status;
 	__u32			f_rtmax;
 	__u32			f_rtpref;
 	__u32			f_rtmult;
@@ -207,7 +207,7 @@ struct nfsd3_fsinfores {
 };
 
 struct nfsd3_pathconfres {
-	__u32			status;
+	__be32			status;
 	__u32			p_link_max;
 	__u32			p_name_max;
 	__u32			p_no_trunc;
@@ -217,12 +217,12 @@ struct nfsd3_pathconfres {
 };
 
 struct nfsd3_commitres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 };
 
 struct nfsd3_getaclres {
-	__u32			status;
+	__be32			status;
 	struct svc_fh		fh;
 	int			mask;
 	struct posix_acl	*acl_access;
@@ -266,70 +266,70 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
-int nfs3svc_decode_sattrargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *, struct nfsd_fhandle *);
+int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_sattrargs *);
-int nfs3svc_decode_diropargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_diropargs *);
-int nfs3svc_decode_accessargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_accessargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_accessargs *);
-int nfs3svc_decode_readargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_readargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_readargs *);
-int nfs3svc_decode_writeargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_writeargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_writeargs *);
-int nfs3svc_decode_createargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_createargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_createargs *);
-int nfs3svc_decode_mkdirargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_mkdirargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_createargs *);
-int nfs3svc_decode_mknodargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_mknodargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_mknodargs *);
-int nfs3svc_decode_renameargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_renameargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_renameargs *);
-int nfs3svc_decode_readlinkargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_readlinkargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_readlinkargs *);
-int nfs3svc_decode_linkargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_linkargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_linkargs *);
-int nfs3svc_decode_symlinkargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_symlinkargs *);
-int nfs3svc_decode_readdirargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_readdirargs *);
-int nfs3svc_decode_readdirplusargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_readdirargs *);
-int nfs3svc_decode_commitargs(struct svc_rqst *, u32 *,
+int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *,
 				struct nfsd3_commitargs *);
-int nfs3svc_encode_voidres(struct svc_rqst *, u32 *, void *);
-int nfs3svc_encode_attrstat(struct svc_rqst *, u32 *,
+int nfs3svc_encode_voidres(struct svc_rqst *, __be32 *, void *);
+int nfs3svc_encode_attrstat(struct svc_rqst *, __be32 *,
 				struct nfsd3_attrstat *);
-int nfs3svc_encode_wccstat(struct svc_rqst *, u32 *,
+int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *,
 				struct nfsd3_attrstat *);
-int nfs3svc_encode_diropres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_diropres(struct svc_rqst *, __be32 *,
 				struct nfsd3_diropres *);
-int nfs3svc_encode_accessres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_accessres(struct svc_rqst *, __be32 *,
 				struct nfsd3_accessres *);
-int nfs3svc_encode_readlinkres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_readlinkres(struct svc_rqst *, __be32 *,
 				struct nfsd3_readlinkres *);
-int nfs3svc_encode_readres(struct svc_rqst *, u32 *, struct nfsd3_readres *);
-int nfs3svc_encode_writeres(struct svc_rqst *, u32 *, struct nfsd3_writeres *);
-int nfs3svc_encode_createres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_readres(struct svc_rqst *, __be32 *, struct nfsd3_readres *);
+int nfs3svc_encode_writeres(struct svc_rqst *, __be32 *, struct nfsd3_writeres *);
+int nfs3svc_encode_createres(struct svc_rqst *, __be32 *,
 				struct nfsd3_diropres *);
-int nfs3svc_encode_renameres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_renameres(struct svc_rqst *, __be32 *,
 				struct nfsd3_renameres *);
-int nfs3svc_encode_linkres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_linkres(struct svc_rqst *, __be32 *,
 				struct nfsd3_linkres *);
-int nfs3svc_encode_readdirres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_readdirres(struct svc_rqst *, __be32 *,
 				struct nfsd3_readdirres *);
-int nfs3svc_encode_fsstatres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_fsstatres(struct svc_rqst *, __be32 *,
 				struct nfsd3_fsstatres *);
-int nfs3svc_encode_fsinfores(struct svc_rqst *, u32 *,
+int nfs3svc_encode_fsinfores(struct svc_rqst *, __be32 *,
 				struct nfsd3_fsinfores *);
-int nfs3svc_encode_pathconfres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_pathconfres(struct svc_rqst *, __be32 *,
 				struct nfsd3_pathconfres *);
-int nfs3svc_encode_commitres(struct svc_rqst *, u32 *,
+int nfs3svc_encode_commitres(struct svc_rqst *, __be32 *,
 				struct nfsd3_commitres *);
 
-int nfs3svc_release_fhandle(struct svc_rqst *, u32 *,
+int nfs3svc_release_fhandle(struct svc_rqst *, __be32 *,
 				struct nfsd3_attrstat *);
-int nfs3svc_release_fhandle2(struct svc_rqst *, u32 *,
+int nfs3svc_release_fhandle2(struct svc_rqst *, __be32 *,
 				struct nfsd3_fhandle_pair *);
 int nfs3svc_encode_entry(struct readdir_cd *, const char *name,
 				int namlen, loff_t offset, ino_t ino,
@@ -338,9 +338,9 @@ int nfs3svc_encode_entry_plus(struct rea
 				int namlen, loff_t offset, ino_t ino,
 				unsigned int);
 /* Helper functions for NFSv3 ACL code */
-u32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, u32 *p,
+__be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
-u32 *nfs3svc_decode_fh(u32 *p, struct svc_fh *fhp);
+__be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 
 
 #endif /* _LINUX_NFSD_XDR3_H */
-- 
1.4.2.GIT


