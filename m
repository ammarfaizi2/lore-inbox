Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVKAPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVKAPXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVKAPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:23:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750865AbVKAPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:23:42 -0500
Date: Tue, 1 Nov 2005 14:23:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jack@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] quota: small cleanups
Message-ID: <20051101132338.GN8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- "extern inline" -> "static inline"
- every file should #include the headers containing the prototypes for
  it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/dquot.c               |    1 +
 fs/quota.c               |    1 +
 include/linux/quotaops.h |   12 ++++++------
 3 files changed, 8 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---


--- linux-2.6.13-rc6-mm1/include/linux/quotaops.h.old	2005-08-20 14:40:53.000000000 +0200
+++ linux-2.6.13-rc6-mm1/include/linux/quotaops.h	2005-08-20 14:41:30.000000000 +0200
@@ -198,38 +198,38 @@
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_add_bytes(inode, nr);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	inode_sub_bytes(inode, nr);
 }
 
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);

--- linux-2.6.14-rc5-mm1-full/fs/dquot.c.old	2005-10-31 17:35:56.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/dquot.c	2005-10-31 17:36:15.000000000 +0100
@@ -77,6 +77,7 @@
 #include <linux/kmod.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>
+#include <linux/quotaops.h>
 
 #include <asm/uaccess.h>
 
--- linux-2.6.14-rc5-mm1-full/fs/quota.c.old	2005-10-31 17:36:42.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/quota.c	2005-10-31 17:36:58.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/buffer_head.h>
+#include <linux/quotaops.h>
 
 /* Check validity of generic quotactl commands */
 static int generic_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)

