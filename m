Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVAHWV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVAHWV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAHWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:18:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261937AbVAHWGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:06:07 -0500
Date: Sat, 8 Jan 2005 23:05:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mvw@planets.elm.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] quota: make some code static
Message-ID: <20050108220558.GF14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.

The most interesting part is that dquot_cachep can become static, since 
it isn't used outside of dquot.c .


diffstat output:
 fs/dquot.c           |    8 ++++----
 fs/quota.c           |    2 +-
 include/linux/slab.h |    1 -
 3 files changed, 5 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/include/linux/slab.h.old	2005-01-08 17:18:39.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/slab.h	2005-01-08 17:18:45.000000000 +0100
@@ -118,7 +118,6 @@
 extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
-extern kmem_cache_t	*dquot_cachep;
 extern kmem_cache_t	*fs_cachep;
 extern kmem_cache_t	*signal_cachep;
 extern kmem_cache_t	*sighand_cachep;
--- linux-2.6.10-mm2-full/fs/dquot.c.old	2005-01-08 17:17:28.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/dquot.c	2005-01-08 17:18:29.000000000 +0100
@@ -128,6 +128,9 @@
 static struct quota_format_type *quota_formats;	/* List of registered formats */
 static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 
+/* SLAB cache for dquot structures */
+static kmem_cache_t *dquot_cachep;
+
 int register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -199,7 +202,7 @@
 
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
-unsigned int dq_hash_bits, dq_hash_mask;
+static unsigned int dq_hash_bits, dq_hash_mask;
 static struct hlist_head *dquot_hash;
 
 struct dqstats dqstats;
@@ -1781,9 +1784,6 @@
 	{ .ctl_name = 0 },
 };
 
-/* SLAB cache for dquot structures */
-kmem_cache_t *dquot_cachep;
-
 static int __init dquot_init(void)
 {
 	int i;
--- linux-2.6.10-mm2-full/fs/quota.c.old	2005-01-08 17:19:08.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/quota.c	2005-01-08 17:19:17.000000000 +0100
@@ -136,7 +136,7 @@
 	return NULL;
 }
 
-void quota_sync_sb(struct super_block *sb, int type)
+static void quota_sync_sb(struct super_block *sb, int type)
 {
 	int cnt;
 	struct inode *discard[MAXQUOTAS];

