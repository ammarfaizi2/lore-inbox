Return-Path: <linux-kernel-owner+w=401wt.eu-S964833AbXADSMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbXADSMF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbXADSMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:12:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:34215 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964833AbXADSL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:11:58 -0500
Date: Thu, 4 Jan 2007 12:11:54 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 4/8] user ns: hook permission
Message-ID: <20070104181154.GE11377@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104180635.GA11377@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH -mm 4/8] user ns: hook permission

Hook permission to check vfsmnt->user_ns against current.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 fs/namei.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e4f108f..d6687af 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -246,6 +246,8 @@ int permission(struct inode *inode, int 
 			return -EACCES;
 	}
 
+	if (nd && !task_mnt_same_uidns(current, nd->mnt))
+		return -EACCES;
 
 	/*
 	 * MAY_EXEC on regular files requires special handling: We override
@@ -433,6 +435,8 @@ static int exec_permission_lite(struct i
 {
 	umode_t	mode = inode->i_mode;
 
+	if (!task_mnt_same_uidns(current, nd->mnt))
+		return -EACCES;
 	if (inode->i_op && inode->i_op->permission)
 		return -EAGAIN;
 
-- 
1.4.1

