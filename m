Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUJ3HZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUJ3HZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUJ3HZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 03:25:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263626AbUJ3HX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 03:23:58 -0400
Date: Sat, 30 Oct 2004 09:23:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: shaggy@austin.ibm.com
Cc: jfs-discussion@oss.software.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] JFS: make some symbols static
Message-ID: <20041030072327.GI4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some JFS symbols that are only used inside the 
file they are defined in static.


diffstat output:
 fs/jfs/jfs_logmgr.c   |    8 ++++----
 fs/jfs/jfs_metapage.c |    2 +-
 fs/jfs/jfs_txnmgr.c   |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_logmgr.c.old	2004-10-30 08:24:18.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_logmgr.c	2004-10-30 08:58:06.000000000 +0200
@@ -161,9 +161,9 @@
 /*
  * Global list of active external journals
  */
-LIST_HEAD(jfs_external_logs);
-struct jfs_log *dummy_log = NULL;
-DECLARE_MUTEX(jfs_log_sem);
+static LIST_HEAD(jfs_external_logs);
+static struct jfs_log *dummy_log = NULL;
+static DECLARE_MUTEX(jfs_log_sem);
 
 /*
  * external references
@@ -205,7 +205,7 @@
  *	statistics
  */
 #ifdef CONFIG_JFS_STATISTICS
-struct lmStat {
+static struct lmStat {
 	uint commit;		/* # of commit */
 	uint pagedone;		/* # of page written */
 	uint submitted;		/* # of pages submitted */
--- linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_metapage.c.old	2004-10-30 08:26:28.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_metapage.c	2004-10-30 08:26:46.000000000 +0200
@@ -31,7 +31,7 @@
 static spinlock_t meta_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_JFS_STATISTICS
-struct {
+static struct {
 	uint	pagealloc;	/* # of page allocations */
 	uint	pagefree;	/* # of page frees */
 	uint	lockwait;	/* # of sleeping lock_metapage() calls */
--- linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_txnmgr.c.old	2004-10-30 08:28:07.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/jfs/jfs_txnmgr.c	2004-10-30 08:27:24.000000000 +0200
@@ -80,7 +80,7 @@
 int jfs_tlocks_low;		/* Indicates low number of available tlocks */
 
 #ifdef CONFIG_JFS_STATISTICS
-struct {
+static struct {
 	uint txBegin;
 	uint txBegin_barrier;
 	uint txBegin_lockslow;
@@ -152,7 +152,7 @@
 /*
  *      statistics
  */
-struct {
+static struct {
 	tid_t maxtid;		/* 4: biggest tid ever used */
 	lid_t maxlid;		/* 4: biggest lid ever used */
 	int ntid;		/* 4: # of transactions performed */
