Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWD0UVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWD0UVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWD0UUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:20:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:19863 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965077AbWD0UUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:20:20 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/5] Fix OCFS2 warning when DEBUG_FS is not enabled
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 27 Apr 2006 13:18:43 -0700
Message-Id: <1146169126913-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.1
In-Reply-To: <11461691262921-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Fix the following warning which happens when OCFS2_FS is enabled but
DEBUG_FS isn't:

fs/ocfs2/dlmglue.c: In function `ocfs2_dlm_init_debug':
fs/ocfs2/dlmglue.c:2036: warning: passing arg 5 of `debugfs_create_file' discards qualifiers from pointer target type

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Joel Becker <Joel.Becker@oracle.com>
Acked-by: Mark Fasheh <mark.fasheh@oracle.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/debugfs.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

bde11d794206ae8d72defd0e8a481181200f7dc4
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 176e2d3..047567d 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -58,9 +58,8 @@ #include <linux/err.h>
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
1.3.1

