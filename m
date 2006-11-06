Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753338AbWKFQXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbWKFQXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKFQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:23:49 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35550 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1753338AbWKFQXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:23:48 -0500
Date: Mon, 6 Nov 2006 11:23:45 -0500
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: nfsv4@linux-nfs.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Neil Brown <neilb@suse.de>
Subject: [PATCH 0/1] nfsd4: reindent do_open_lookup()
Message-ID: <20061106162345.GB12372@fieldses.org>
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com> <20061106161747.GA12372@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106161747.GA12372@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor rearrangement, cleanup of do_open_lookup().  No change in behavior.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 fs/nfsd/nfs4proc.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0a7bbdc..4a73f5b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -106,27 +106,25 @@ do_open_lookup(struct svc_rqst *rqstp, s
 					open->op_fname.len, &open->op_iattr,
 					&resfh, open->op_createmode,
 					(u32 *)open->op_verf.data, &open->op_truncate);
-	}
-	else {
+	} else {
 		status = nfsd_lookup(rqstp, current_fh,
 				     open->op_fname.data, open->op_fname.len, &resfh);
 		fh_unlock(current_fh);
 	}
+	if (status)
+		goto out;
 
-	if (!status) {
-		set_change_info(&open->op_cinfo, current_fh);
+	set_change_info(&open->op_cinfo, current_fh);
 
-		/* set reply cache */
-		fh_dup2(current_fh, &resfh);
-		open->op_stateowner->so_replay.rp_openfh_len =
-			resfh.fh_handle.fh_size;
-		memcpy(open->op_stateowner->so_replay.rp_openfh,
-				&resfh.fh_handle.fh_base,
-				resfh.fh_handle.fh_size);
+	/* set reply cache */
+	fh_dup2(current_fh, &resfh);
+	open->op_stateowner->so_replay.rp_openfh_len = resfh.fh_handle.fh_size;
+	memcpy(open->op_stateowner->so_replay.rp_openfh,
+			&resfh.fh_handle.fh_base, resfh.fh_handle.fh_size);
 
-		status = do_open_permission(rqstp, current_fh, open, MAY_NOP);
-	}
+	status = do_open_permission(rqstp, current_fh, open, MAY_NOP);
 
+out:
 	fh_put(&resfh);
 	return status;
 }
-- 
1.4.3.3.g01929

