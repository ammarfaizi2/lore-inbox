Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWJJDNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWJJDNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWJJDNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24493 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964899AbWJJDMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:51 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] nfsfh simple endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX831-0004Er-6C@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsfh.c            |   10 +++++-----
 include/linux/nfsd/nfsfh.h |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 501d838..727ab3b 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -76,7 +76,7 @@ static int nfsd_acceptable(void *expv, s
  * comment in the NFSv3 spec says this is incorrect (implementation notes for
  * the write call).
  */
-static inline int
+static inline __be32
 nfsd_mode_check(struct svc_rqst *rqstp, umode_t mode, int type)
 {
 	/* Type can be negative when creating hardlinks - not to a dir */
@@ -110,13 +110,13 @@ nfsd_mode_check(struct svc_rqst *rqstp, 
  * This is only called at the start of an nfsproc call, so fhp points to
  * a svc_fh which is all 0 except for the over-the-wire file handle.
  */
-u32
+__be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, int type, int access)
 {
 	struct knfsd_fh	*fh = &fhp->fh_handle;
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
-	u32		error = 0;
+	__be32		error = 0;
 
 	dprintk("nfsd: fh_verify(%s)\n", SVCFH_fmt(fhp));
 
@@ -315,7 +315,7 @@ static inline void _fh_update_old(struct
 		fh->ofh_dirino = 0;
 }
 
-int
+__be32
 fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry, struct svc_fh *ref_fh)
 {
 	/* ref_fh is a reference file handle.
@@ -451,7 +451,7 @@ fh_compose(struct svc_fh *fhp, struct sv
  * Update file handle information after changing a dentry.
  * This is only called by nfsd_create, nfsd_create_v3 and nfsd_proc_create
  */
-int
+__be32
 fh_update(struct svc_fh *fhp)
 {
 	struct dentry *dentry;
diff --git a/include/linux/nfsd/nfsfh.h b/include/linux/nfsd/nfsfh.h
index 069257e..749bad1 100644
--- a/include/linux/nfsd/nfsfh.h
+++ b/include/linux/nfsd/nfsfh.h
@@ -209,9 +209,9 @@ extern char * SVCFH_fmt(struct svc_fh *f
 /*
  * Function prototypes
  */
-u32	fh_verify(struct svc_rqst *, struct svc_fh *, int, int);
-int	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
-int	fh_update(struct svc_fh *);
+__be32	fh_verify(struct svc_rqst *, struct svc_fh *, int, int);
+__be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
+__be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
 
 static __inline__ struct svc_fh *
-- 
1.4.2.GIT


