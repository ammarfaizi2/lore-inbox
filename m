Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVLYGoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVLYGoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 01:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLYGoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 01:44:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6054 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750788AbVLYGoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 01:44:03 -0500
Date: Sun, 25 Dec 2005 06:44:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] nfsd4_truncate() bogus return value
Message-ID: <20051225064402.GX27946@ftp.linux.org.uk>
References: <20051225062937.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225062937.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135492779 -0500

-EINVAL (in host order, no less) is not a good thing to return to client.
nfsd4_truncate() returns it in one case and its callers expect nfs_....
from it.  AFAICS, it should be nfserr_inval

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/nfsd/nfs4state.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

af894f171cc6fb5612ff74a3d32c62492c7a5a98
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6bbefd0..7fec0ac 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1648,7 +1648,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, s
 	if (!open->op_truncate)
 		return 0;
 	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
-		return -EINVAL;
+		return nfserr_inval;
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time_t)0);
 }
 
-- 
0.99.9.GIT

