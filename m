Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWDJVgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDJVgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWDJVgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:36:10 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:30213 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751210AbWDJVgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:36:09 -0400
Date: Mon, 10 Apr 2006 23:36:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] FS: Fix OCFS2 warning when DEBUG_FS is not enabled
Message-Id: <20060410233603.f6e35218.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning which happens when OCFS2_FS is enabled but
DEBUG_FS isn't:

fs/ocfs2/dlmglue.c: In function `ocfs2_dlm_init_debug':
fs/ocfs2/dlmglue.c:2036: warning: passing arg 5 of `debugfs_create_file' discards qualifiers from pointer target type

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Arjan van de Ven <arjan@infradead.org>
---
 include/linux/debugfs.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Warning introduced by commit 4b6f5d20b04dcbc3d888555522b90ba6d36c4106,
should have been fixed (but wasn't) by commit
99ac48f54a91d02140c497edc31dc57d4bc5c85d.

--- linux-2.6.17-rc1.orig/include/linux/debugfs.h	2006-04-03 20:13:29.000000000 +0200
+++ linux-2.6.17-rc1/include/linux/debugfs.h	2006-04-10 23:09:59.000000000 +0200
@@ -58,9 +58,8 @@
  */
 
 static inline struct dentry *debugfs_create_file(const char *name, mode_t mode,
-						 struct dentry *parent,
-						 void *data,
-						 struct file_operations *fops)
+					struct dentry *parent, void *data,
+					const struct file_operations *fops)
 {
 	return ERR_PTR(-ENODEV);
 }


-- 
Jean Delvare
