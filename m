Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933892AbWKTC0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933892AbWKTC0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933887AbWKTCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933889AbWKTCY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:29 -0500
Date: Mon, 20 Nov 2006 03:24:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make ocfs2_create_new_lock() static
Message-ID: <20061120022428.GS31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global ocfs2_create_new_lock() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/dlmglue.c |    8 ++++----
 fs/ocfs2/dlmglue.h |    2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.19-rc5-mm2/fs/ocfs2/dlmglue.h.old	2006-11-20 02:04:48.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/ocfs2/dlmglue.h	2006-11-20 02:04:55.000000000 +0100
@@ -68,8 +68,6 @@
 				u64 parent, struct inode *inode);
 void ocfs2_lock_res_free(struct ocfs2_lock_res *res);
 int ocfs2_create_new_inode_locks(struct inode *inode);
-int ocfs2_create_new_lock(struct ocfs2_super *osb,
-			  struct ocfs2_lock_res *lockres, int ex, int local);
 int ocfs2_drop_inode_locks(struct inode *inode);
 int ocfs2_data_lock_full(struct inode *inode,
 			 int write,
--- linux-2.6.19-rc5-mm2/fs/ocfs2/dlmglue.c.old	2006-11-20 02:05:01.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/ocfs2/dlmglue.c	2006-11-20 02:05:10.000000000 +0100
@@ -1063,10 +1063,10 @@
 	mlog_exit_void();
 }
 
-int ocfs2_create_new_lock(struct ocfs2_super *osb,
-			  struct ocfs2_lock_res *lockres,
-			  int ex,
-			  int local)
+static int ocfs2_create_new_lock(struct ocfs2_super *osb,
+				 struct ocfs2_lock_res *lockres,
+				 int ex,
+				 int local)
 {
 	int level =  ex ? LKM_EXMODE : LKM_PRMODE;
 	unsigned long flags;

