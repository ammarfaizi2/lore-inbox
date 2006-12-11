Return-Path: <linux-kernel-owner+w=401wt.eu-S1762650AbWLKIdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762650AbWLKIdP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762652AbWLKIdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:33:15 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:54237 "EHLO
	liaag1ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762650AbWLKIdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:33:14 -0500
Date: Mon, 11 Dec 2006 03:27:37 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] pipe: Don't oops when pipe filesystem isn't mounted
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent oops when an app tries to create a pipe while pipefs
is not mounted.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19.1-pre1-32.orig/fs/pipe.c
+++ 2.6.19.1-pre1-32/fs/pipe.c
@@ -839,9 +839,11 @@ static struct dentry_operations pipefs_d
 
 static struct inode * get_pipe_inode(void)
 {
-	struct inode *inode = new_inode(pipe_mnt->mnt_sb);
+	struct inode *inode = NULL;
 	struct pipe_inode_info *pipe;
 
+	if (pipe_mnt)
+		inode = new_inode(pipe_mnt->mnt_sb);
 	if (!inode)
 		goto fail_inode;
 
-- 
Chuck
