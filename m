Return-Path: <linux-kernel-owner+w=401wt.eu-S933044AbWLSXB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933044AbWLSXB6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933056AbWLSXB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:01:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:40336 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932950AbWLSXAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:00:52 -0500
Date: Tue, 19 Dec 2006 17:00:51 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, containers@lists.osdl.org
Subject: [PATCH 4/8] user ns: hook permission
Message-ID: <20061219230051.GE25904@sergelap.austin.ibm.com>
References: <20061219225902.GA25904@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219225902.GA25904@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 4/8] user ns: hook permission

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

