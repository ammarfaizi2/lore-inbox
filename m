Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWJJDNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWJJDNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWJJDNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22957 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964851AbWJJDMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:12:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] nfsd: nfserrno() endianness annotations
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX82r-0004EY-5D@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:12:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsproc.c           |    7 +++----
 include/linux/nfsd/export.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 09030af..03ab682 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -579,11 +579,11 @@ struct svc_version	nfsd_version2 = {
 /*
  * Map errnos to NFS errnos.
  */
-int
+__be32
 nfserrno (int errno)
 {
 	static struct {
-		int	nfserr;
+		__be32	nfserr;
 		int	syserr;
 	} nfs_errtbl[] = {
 		{ nfs_ok, 0 },
@@ -615,11 +615,10 @@ #endif
 		{ nfserr_badname, -ESRCH },
 		{ nfserr_io, -ETXTBSY },
 		{ nfserr_notsupp, -EOPNOTSUPP },
-		{ -1, -EIO }
 	};
 	int	i;
 
-	for (i = 0; nfs_errtbl[i].nfserr != -1; i++) {
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
 		if (nfs_errtbl[i].syserr == errno)
 			return nfs_errtbl[i].nfserr;
 	}
diff --git a/include/linux/nfsd/export.h b/include/linux/nfsd/export.h
index 6e78ea9..27666f5 100644
--- a/include/linux/nfsd/export.h
+++ b/include/linux/nfsd/export.h
@@ -118,7 +118,7 @@ struct svc_export *	exp_parent(struct au
 int			exp_rootfh(struct auth_domain *, 
 					char *path, struct knfsd_fh *, int maxsize);
 int			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
-int			nfserrno(int errno);
+__be32			nfserrno(int errno);
 
 extern struct cache_detail svc_export_cache;
 
-- 
1.4.2.GIT


