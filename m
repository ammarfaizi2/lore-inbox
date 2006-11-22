Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967085AbWKVERI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967085AbWKVERI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967086AbWKVERI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:17:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14605 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967085AbWKVERH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:07 -0500
Date: Wed, 22 Nov 2006 05:17:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove NFSD_OPTIMIZE_SPACE
Message-ID: <20061122041706.GW5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused NFSD_OPTIMIZE_SPACE.

Additionally, it does differently what NFSD_OPTIMIZE_SPACE was supposed 
to do:

Nowadays, gcc knows best when to inline code, and 
CONFIG_CC_OPTIMIZE_FOR_SIZE even tells gcc globally whether to optimize 
for size or for speed. Therefore, this patch also removes all inline's 
from these files.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfsd/nfs3xdr.c |   24 ++++++++++--------------
 fs/nfsd/nfsxdr.c  |   13 ++++---------
 2 files changed, 14 insertions(+), 23 deletions(-)

--- linux-2.6.19-rc5-mm2/fs/nfsd/nfs3xdr.c.old	2006-11-22 01:59:19.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/nfsd/nfs3xdr.c	2006-11-22 02:00:17.000000000 +0100
@@ -24,10 +24,6 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
-#ifdef NFSD_OPTIMIZE_SPACE
-# define inline
-#endif
-
 
 /*
  * Mapping of S_IF* types to NFS file types
@@ -42,14 +38,14 @@ static u32	nfs3_ftypes[] = {
 /*
  * XDR functions for basic NFS types
  */
-static inline __be32 *
+static __be32 *
 encode_time3(__be32 *p, struct timespec *time)
 {
 	*p++ = htonl((u32) time->tv_sec); *p++ = htonl(time->tv_nsec);
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 decode_time3(__be32 *p, struct timespec *time)
 {
 	time->tv_sec = ntohl(*p++);
@@ -57,7 +53,7 @@ decode_time3(__be32 *p, struct timespec 
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 decode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	unsigned int size;
@@ -77,7 +73,7 @@ __be32 *nfs3svc_decode_fh(__be32 *p, str
 	return decode_fh(p, fhp);
 }
 
-static inline __be32 *
+static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	unsigned int size = fhp->fh_handle.fh_size;
@@ -91,7 +87,7 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
  * Decode a file name and make sure that the path contains
  * no slashes or null bytes.
  */
-static inline __be32 *
+static __be32 *
 decode_filename(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
@@ -107,7 +103,7 @@ decode_filename(__be32 *p, char **namp, 
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 decode_sattr3(__be32 *p, struct iattr *iap)
 {
 	u32	tmp;
@@ -153,7 +149,7 @@ decode_sattr3(__be32 *p, struct iattr *i
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	      struct kstat *stat)
 {
@@ -186,7 +182,7 @@ encode_fattr3(struct svc_rqst *rqstp, __
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 encode_saved_post_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct inode	*inode = fhp->fh_dentry->d_inode;
@@ -776,7 +772,7 @@ nfs3svc_encode_readdirres(struct svc_rqs
 		return xdr_ressize_check(rqstp, p);
 }
 
-static inline __be32 *
+static __be32 *
 encode_entry_baggage(struct nfsd3_readdirres *cd, __be32 *p, const char *name,
 	     int namlen, ino_t ino)
 {
@@ -790,7 +786,7 @@ encode_entry_baggage(struct nfsd3_readdi
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 encode_entryplus_baggage(struct nfsd3_readdirres *cd, __be32 *p,
 		struct svc_fh *fhp)
 {
--- linux-2.6.19-rc5-mm2/fs/nfsd/nfsxdr.c.old	2006-11-22 02:00:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/nfsd/nfsxdr.c	2006-11-22 02:00:35.000000000 +0100
@@ -18,11 +18,6 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
-
-#ifdef NFSD_OPTIMIZE_SPACE
-# define inline
-#endif
-
 /*
  * Mapping of S_IF* types to NFS file types
  */
@@ -55,7 +50,7 @@ __be32 *nfs2svc_decode_fh(__be32 *p, str
 	return decode_fh(p, fhp);
 }
 
-static inline __be32 *
+static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	memcpy(p, &fhp->fh_handle.fh_base, NFS_FHSIZE);
@@ -66,7 +61,7 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
  * Decode a file name and make sure that the path contains
  * no slashes or null bytes.
  */
-static inline __be32 *
+static __be32 *
 decode_filename(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
@@ -82,7 +77,7 @@ decode_filename(__be32 *p, char **namp, 
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 decode_pathname(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
@@ -98,7 +93,7 @@ decode_pathname(__be32 *p, char **namp, 
 	return p;
 }
 
-static inline __be32 *
+static __be32 *
 decode_sattr(__be32 *p, struct iattr *iap)
 {
 	u32	tmp, tmp1;

