Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVANMrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVANMrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVANMpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:45:17 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:19341 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261975AbVANMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:43:30 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - fix variable with confusing name
Message-Id: <E1CpQnL-0000MU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 13:43:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch fixes a variable name that looks like it's shadowing a
function (spotted by Michael Waychison).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -rup linux-2.6.11-rc1-mm1/fs/fuse/dev.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/dev.c
--- linux-2.6.11-rc1-mm1/fs/fuse/dev.c	2005-01-14 12:30:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/dev.c	2005-01-14 12:44:36.000000000 +0100
@@ -53,10 +53,10 @@ void fuse_request_free(struct fuse_req *
 
 static inline void block_sigs(sigset_t *oldset)
 {
-	sigset_t sigmask;
+	sigset_t mask;
 
-	siginitsetinv(&sigmask, sigmask(SIGKILL));
-	sigprocmask(SIG_BLOCK, &sigmask, oldset);
+	siginitsetinv(&mask, sigmask(SIGKILL));
+	sigprocmask(SIG_BLOCK, &mask, oldset);
 }
 
 static inline void restore_sigs(sigset_t *oldset)

