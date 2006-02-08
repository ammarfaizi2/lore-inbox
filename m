Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWBHDTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWBHDTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWBHDTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61312 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030477AbWBHDSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:47 -0500
To: torvalds@osdl.org
Subject: [PATCH 11/29] fix __user annotations in fs/select.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fqx-0006CZ-1f@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138789569 -0500

pselect patch had introduced rather weird annotations; fix them

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/select.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

e110ab94ebc714de57f75f0c7c576dde8cf80944
diff --git a/fs/select.c b/fs/select.c
index c0f02d3..bc60a3e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -510,9 +510,9 @@ asmlinkage long sys_pselect6(int n, fd_s
 
 	if (sig) {
 		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t * __user *)sig)
+		    || __get_user(up, (sigset_t __user * __user *)sig)
 		    || __get_user(sigsetsize,
-				(size_t * __user)(sig+sizeof(void *))))
+				(size_t __user *)(sig+sizeof(void *))))
 			return -EFAULT;
 	}
 
-- 
0.99.9.GIT

