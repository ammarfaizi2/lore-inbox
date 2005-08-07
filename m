Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752521AbVHGXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbVHGXNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbVHGXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:13:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51463 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752521AbVHGXNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:13:21 -0400
Date: Mon, 8 Aug 2005 01:13:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] jffs/jffs2: remove wrong function prototypes
Message-ID: <20050807231319.GE4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes prototypes for the generic_file_open and 
generic_file_llseek functions.

Besides being superfluous because they are already present in fs.h, they 
were also wrong because the actual functions aren't weak functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Jul 2005

 fs/jffs/inode-v23.c |    3 ---
 fs/jffs2/file.c     |    3 ---
 2 files changed, 6 deletions(-)

--- linux-2.6.13-rc4-mm1-full/fs/jffs/inode-v23.c.old	2005-07-31 18:43:46.000000000 +0200
+++ linux-2.6.13-rc4-mm1-full/fs/jffs/inode-v23.c	2005-07-31 18:44:15.000000000 +0200
@@ -1629,9 +1629,6 @@
 }
 
 
-extern int generic_file_open(struct inode *, struct file *) __attribute__((weak));
-extern loff_t generic_file_llseek(struct file *, loff_t, int) __attribute__((weak));
-
 static struct file_operations jffs_file_operations =
 {
 	.open		= generic_file_open,
--- linux-2.6.13-rc4-mm1-full/fs/jffs2/file.c.old	2005-07-31 18:44:31.000000000 +0200
+++ linux-2.6.13-rc4-mm1-full/fs/jffs2/file.c	2005-07-31 18:44:40.000000000 +0200
@@ -21,9 +21,6 @@
 #include <linux/jffs2.h>
 #include "nodelist.h"
 
-extern int generic_file_open(struct inode *, struct file *) __attribute__((weak));
-extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin) __attribute__((weak));
-
 static int jffs2_commit_write (struct file *filp, struct page *pg,
 			       unsigned start, unsigned end);
 static int jffs2_prepare_write (struct file *filp, struct page *pg,

