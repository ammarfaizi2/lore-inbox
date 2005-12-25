Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVLYGsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLYGsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 01:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVLYGsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 01:48:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35032 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750798AbVLYGsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 01:48:50 -0500
Date: Sun, 25 Dec 2005 06:48:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH] NFSERR_SERVERFAULT returned host-endian
Message-ID: <20051225064849.GY27946@ftp.linux.org.uk>
References: <20051225062937.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225062937.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135492936 -0500

->rp_status is network-endian and nobody byteswaps it before sending to
client; putting NFSERR_SERVERFAULT instead of nfserr_serverfault in there
is not nice...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/nfsd/nfs4state.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

8b3750ba77fdb6939689cbeff336d6153531fe96
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7fec0ac..71689b0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1088,7 +1088,7 @@ alloc_init_open_stateowner(unsigned int 
 	sop->so_seqid = open->op_seqid;
 	sop->so_confirmed = 0;
 	rp = &sop->so_replay;
-	rp->rp_status = NFSERR_SERVERFAULT;
+	rp->rp_status = nfserr_serverfault;
 	rp->rp_buflen = 0;
 	rp->rp_buf = rp->rp_ibuf;
 	return sop;
@@ -2633,7 +2633,7 @@ alloc_init_lock_stateowner(unsigned int 
 	sop->so_seqid = lock->lk_new_lock_seqid + 1;
 	sop->so_confirmed = 1;
 	rp = &sop->so_replay;
-	rp->rp_status = NFSERR_SERVERFAULT;
+	rp->rp_status = nfserr_serverfault;
 	rp->rp_buflen = 0;
 	rp->rp_buf = rp->rp_ibuf;
 	return sop;
-- 
0.99.9.GIT

