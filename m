Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFDALm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFDALm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:11:42 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:27666 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261989AbTFDALX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:11:23 -0400
Date: Tue, 3 Jun 2003 19:18:30 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 patches for fs/
Message-ID: <20030604001830.GR663@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small set of three patches that add C99 initializers to
fs/bio.c and fs/dquot.c. File fs/libfs.c has an obsolete GCC style
initialzers that is converted to C99 style. The patches are against the
current BK.

Art Haas

===== fs/bio.c 1.46 vs edited =====
--- 1.46/fs/bio.c	Fri May 30 09:32:56 2003
+++ edited/fs/bio.c	Mon Jun  2 10:32:03 2003
@@ -53,7 +53,7 @@
  * unsigned short
  */
 
-#define BV(x) { x, "biovec-" #x }
+#define BV(x) { .nr_vecs = x, .name = "biovec-" #x }
 static struct biovec_pool bvec_array[BIOVEC_NR_POOLS] = {
 	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
===== fs/dquot.c 1.62 vs edited =====
--- 1.62/fs/dquot.c	Sun May 25 16:07:56 2003
+++ edited/fs/dquot.c	Mon May 26 15:56:05 2003
@@ -1348,25 +1348,91 @@
 };
 
 static ctl_table fs_dqstats_table[] = {
-	{FS_DQ_LOOKUPS, "lookups", &dqstats.lookups, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_DROPS, "drops", &dqstats.drops, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_READS, "reads", &dqstats.reads, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_WRITES, "writes", &dqstats.writes, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_CACHE_HITS, "cache_hits", &dqstats.cache_hits, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_ALLOCATED, "allocated_dquots", &dqstats.allocated_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_FREE, "free_dquots", &dqstats.free_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_SYNCS, "syncs", &dqstats.syncs, sizeof(int), 0444, NULL, &proc_dointvec},
-	{},
+	{
+		.ctl_name	= FS_DQ_LOOKUPS,
+		.procname	= "lookups",
+		.data		= &dqstats.lookups,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_DROPS,
+		.procname	= "drops",
+		.data		= &dqstats.drops,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_READS,
+		.procname	= "reads",
+		.data		= &dqstats.reads,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_WRITES,
+		.procname	= "writes",
+		.data		= &dqstats.writes,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_CACHE_HITS,
+		.procname	= "cache_hits",
+		.data		= &dqstats.cache_hits,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_ALLOCATED,
+		.procname	= "allocated_dquots",
+		.data		= &dqstats.allocated_dquots,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_FREE,
+		.procname	= "free_dquots",
+		.data		= &dqstats.free_dquots,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DQ_SYNCS,
+		.procname	= "syncs",
+		.data		= &dqstats.syncs,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 },
 };
 
 static ctl_table fs_table[] = {
-	{FS_DQSTATS, "quota", NULL, 0, 0555, fs_dqstats_table},
-	{},
+	{
+		.ctl_name	= FS_DQSTATS,
+		.procname	= "quota",
+		.mode		= 0555,
+		.child		= fs_dqstats_table,
+	},
+	{ .ctl_name = 0 },
 };
 
 static ctl_table sys_table[] = {
-	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
-	{},
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= fs_table,
+	},
+	{ .ctl_name = 0 },
 };
 
 /* SLAB cache for dquot structures */
===== fs/libfs.c 1.19 vs edited =====
--- 1.19/fs/libfs.c	Sun May 25 19:52:41 2003
+++ edited/fs/libfs.c	Mon May 26 15:55:53 2003
@@ -336,7 +336,7 @@
 
 int simple_fill_super(struct super_block *s, int magic, struct tree_descr *files)
 {
-	static struct super_operations s_ops = {statfs:simple_statfs};
+	static struct super_operations s_ops = {.statfs = simple_statfs};
 	struct inode *inode;
 	struct dentry *root;
 	struct dentry *dentry;
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
