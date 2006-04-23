Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWDWLtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWDWLtO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWDWLtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:49:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1804 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751382AbWDWLtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:49:13 -0400
Date: Sun, 23 Apr 2006 13:49:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-ID: <20060423114912.GM5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - journal_check_used_features()
- remove the following unused EXPORT_SYMBOL's:
  - journal_set_features
  - journal_update_superblock

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jbd/journal.c    |    9 ++++-----
 include/linux/jbd.h |    2 --
 2 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.17-rc1-mm3-full/include/linux/jbd.h.old	2006-04-23 13:29:20.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/include/linux/jbd.h	2006-04-23 13:29:35.000000000 +0200
@@ -908,8 +908,6 @@
 				int start, int len, int bsize);
 extern journal_t * journal_init_inode (struct inode *);
 extern int	   journal_update_format (journal_t *);
-extern int	   journal_check_used_features 
-		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   journal_check_available_features 
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   journal_set_features 
--- linux-2.6.17-rc1-mm3-full/fs/jbd/journal.c.old	2006-04-23 13:29:42.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/jbd/journal.c	2006-04-23 13:30:37.000000000 +0200
@@ -62,13 +62,10 @@
 EXPORT_SYMBOL(journal_init_dev);
 EXPORT_SYMBOL(journal_init_inode);
 EXPORT_SYMBOL(journal_update_format);
-EXPORT_SYMBOL(journal_check_used_features);
 EXPORT_SYMBOL(journal_check_available_features);
-EXPORT_SYMBOL(journal_set_features);
 EXPORT_SYMBOL(journal_create);
 EXPORT_SYMBOL(journal_load);
 EXPORT_SYMBOL(journal_destroy);
-EXPORT_SYMBOL(journal_update_superblock);
 EXPORT_SYMBOL(journal_abort);
 EXPORT_SYMBOL(journal_errno);
 EXPORT_SYMBOL(journal_ack_err);
@@ -1169,8 +1166,10 @@
  * features.  Return true (non-zero) if it does. 
  **/
 
-int journal_check_used_features (journal_t *journal, unsigned long compat,
-				 unsigned long ro, unsigned long incompat)
+static int journal_check_used_features(journal_t *journal,
+				       unsigned long compat,
+				       unsigned long ro,
+				       unsigned long incompat)
 {
 	journal_superblock_t *sb;
 

