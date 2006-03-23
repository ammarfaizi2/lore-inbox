Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWCWRyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWCWRyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWCWRyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:54:46 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:61676 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751476AbWCWRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:54:45 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] locks: don't panic
Message-Id: <E1FMU10-00064F-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Mar 2006 18:54:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't panic!  Just BUG_ON().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-22 16:09:10.000000000 +0100
+++ linux/fs/locks.c	2006-03-22 16:10:23.000000000 +0100
@@ -156,18 +156,9 @@ static struct file_lock *locks_alloc_loc
 /* Free a lock which is not in use. */
 static void locks_free_lock(struct file_lock *fl)
 {
-	if (fl == NULL) {
-		BUG();
-		return;
-	}
-	if (waitqueue_active(&fl->fl_wait))
-		panic("Attempting to free lock with active wait queue");
-
-	if (!list_empty(&fl->fl_block))
-		panic("Attempting to free lock with active block list");
-
-	if (!list_empty(&fl->fl_link))
-		panic("Attempting to free lock on active lock list");
+	BUG_ON(waitqueue_active(&fl->fl_wait));
+	BUG_ON(!list_empty(&fl->fl_block));
+	BUG_ON(!list_empty(&fl->fl_link));
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
