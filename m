Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWJSN1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWJSN1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWJSN1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:27:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751607AbWJSN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:27:10 -0400
Date: Thu, 19 Oct 2006 15:27:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: swhiteho@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.6 patch] fs/gfs2/ops_fstype.c:fill_super_meta(): fix NULL dereference
Message-ID: <20061019132659.GO3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't dereference new->s_root when we do know it's NULL.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/gfs2/ops_fstype.c.old	2006-10-19 15:24:23.000000000 +0200
+++ linux-2.6/fs/gfs2/ops_fstype.c	2006-10-19 15:24:32.000000000 +0200
@@ -793,10 +793,10 @@ static int fill_super_meta(struct super_
 	if (!new->s_root) {
 		fs_err(sdp, "can't get root dentry\n");
 		error = -ENOMEM;
 		iput(inode);
-	}
-	new->s_root->d_op = &gfs2_dops;
+	} else
+		new->s_root->d_op = &gfs2_dops;
 
 	return error;
 }
 

