Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVKJA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVKJA2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKJA2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:28:03 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:44440 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751114AbVKJA2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:28:01 -0500
Message-ID: <43729405.6080601@namesys.com>
Date: Wed, 09 Nov 2005 16:27:49 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: [Fwd: [PATCH 2/2] reiser4-fix-kbuild.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040601050607020605010706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601050607020605010706
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

tomorrow we will send ~3 minor fixes that were complained about, and
then we will be ready for the next round of complaints.

To the users, the first of these two patches is very necessary, as it
has several important bug fixes (things got unsettled after the last
round of changes, apologies to users.....).

zam is working on a livelock bug fix.

Hans


--------------040601050607020605010706
Content-Type: message/rfc822;
 name="[PATCH 2/2] reiser4-fix-kbuild.patch.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 2/2] reiser4-fix-kbuild.patch.eml"

Return-Path: <vs@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 2955 invoked from network); 8 Nov 2005 16:43:56 -0000
Received: from ppp83-237-26-120.pppoe.mtu-net.ru (HELO ?192.168.1.10?) (83.237.26.120)
  by thebsh.namesys.com with SMTP; 8 Nov 2005 16:43:56 -0000
Message-ID: <4370D5C5.2010008@namesys.com>
Date: Tue, 08 Nov 2005 19:43:49 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Subject: [PATCH 2/2] reiser4-fix-kbuild.patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070406080508060804010302"

This is a multi-part message in MIME format.
--------------070406080508060804010302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070406080508060804010302
Content-Type: text/plain;
 name="reiser4-fix-kbuild.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser4-fix-kbuild.patch"


From: Hans Reiser <reiser@namesys.com>

This patch adds Makefile to each of reiser/ subdirectories.
This is to allow compiling of a single file.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/Makefile                    |  139 ++++++++++-----------------------
 fs/reiser4/plugin/Makefile             |   26 ++++++
 fs/reiser4/plugin/compress/Makefile    |    6 +
 fs/reiser4/plugin/dir/Makefile         |    5 +
 fs/reiser4/plugin/disk_format/Makefile |    5 +
 fs/reiser4/plugin/file/Makefile        |    7 +
 fs/reiser4/plugin/item/Makefile        |   18 ++++
 fs/reiser4/plugin/node/Makefile        |    5 +
 fs/reiser4/plugin/security/Makefile    |    4 
 fs/reiser4/plugin/space/Makefile       |    4 
 10 files changed, 126 insertions(+), 93 deletions(-)

diff -puN fs/reiser4/Makefile~reiser4-fix-kbuild fs/reiser4/Makefile
--- linux-2.6.14-rc5-mm1/fs/reiser4/Makefile~reiser4-fix-kbuild	2005-11-08 19:34:21.057312853 +0300
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/Makefile	2005-11-08 19:34:21.089322803 +0300
@@ -4,97 +4,50 @@
 
 obj-$(CONFIG_REISER4_FS) += reiser4.o
 
-reiser4-y := \
-		   debug.o \
-		   jnode.o \
-		   znode.o \
-		   key.o \
-		   pool.o \
-		   tree_mod.o \
-		   estimate.o \
-		   carry.o \
-		   carry_ops.o \
-		   lock.o \
-		   tree.o \
-		   context.o \
-		   tap.o \
-		   coord.o \
-		   block_alloc.o \
-		   txnmgr.o \
-		   kassign.o \
-		   flush.o \
-		   wander.o \
-		   eottl.o \
-		   search.o \
-		   page_cache.o \
-		   seal.o \
-		   dscale.o \
-		   flush_queue.o \
-		   ktxnmgrd.o \
-		   blocknrset.o \
-		   super.o \
-		   super_ops.o \
-		   fsdata.o \
-		   export_ops.o \
-		   oid.o \
-		   tree_walk.o \
-		   inode.o \
-		   vfs_ops.o \
-		   as_ops.o \
-		   emergency_flush.o \
-		   entd.o\
-		   readahead.o \
-		   cluster.o \
-		   crypt.o \
-		   status_flags.o \
-		   init_super.o \
-		   safe_link.o \
-           \
-		   plugin/plugin.o \
-		   plugin/plugin_set.o \
-		   plugin/node/node.o \
-		   plugin/object.o \
-		   plugin/inode_ops.o \
-		   plugin/inode_ops_rename.o \
-		   plugin/file_ops.o \
-		   plugin/file_ops_readdir.o \
-		   plugin/file_plugin_common.o \
-		   plugin/file/file.o \
-		   plugin/file/tail_conversion.o \
-		   plugin/file/symlink.o \
-		   plugin/file/cryptcompress.o \
-		   plugin/dir_plugin_common.o \
-		   plugin/dir/hashed_dir.o \
-		   plugin/dir/seekable_dir.o \
-		   plugin/digest.o \
-		   plugin/node/node40.o \
-           \
-		   plugin/compress/minilzo.o \
-		   plugin/compress/compress.o \
-		   plugin/compress/compress_mode.o \
-           \
-		   plugin/item/static_stat.o \
-		   plugin/item/sde.o \
-		   plugin/item/cde.o \
-		   plugin/item/blackbox.o \
-		   plugin/item/internal.o \
-		   plugin/item/tail.o \
-		   plugin/item/ctail.o \
-		   plugin/item/extent.o \
-		   plugin/item/extent_item_ops.o \
-		   plugin/item/extent_file_ops.o \
-		   plugin/item/extent_flush_ops.o \
-           \
-		   plugin/hash.o \
-		   plugin/fibration.o \
-		   plugin/tail_policy.o \
-		   plugin/item/item.o \
-           \
-		   plugin/security/perm.o \
-		   plugin/space/bitmap.o \
-           \
-		   plugin/disk_format/disk_format40.o \
-		   plugin/disk_format/disk_format.o \
-	   \
-		   plugin/regular.o
+reiser4-objs := 		\
+	debug.o			\
+	jnode.o			\
+	znode.o			\
+	key.o			\
+	pool.o			\
+	tree_mod.o		\
+	estimate.o		\
+	carry.o			\
+	carry_ops.o		\
+	lock.o			\
+	tree.o			\
+	context.o		\
+	tap.o			\
+	coord.o			\
+	block_alloc.o		\
+	txnmgr.o		\
+	kassign.o		\
+	flush.o			\
+	wander.o		\
+	eottl.o			\
+	search.o		\
+	page_cache.o		\
+	seal.o			\
+	dscale.o		\
+	flush_queue.o		\
+	ktxnmgrd.o		\
+	blocknrset.o		\
+	super.o			\
+	super_ops.o		\
+	fsdata.o		\
+	export_ops.o		\
+	oid.o			\
+	tree_walk.o		\
+	inode.o			\
+	vfs_ops.o		\
+	as_ops.o		\
+	emergency_flush.o	\
+	entd.o			\
+	readahead.o		\
+	cluster.o		\
+	crypt.o			\
+	status_flags.o		\
+	init_super.o		\
+	safe_link.o
 
+obj-$(CONFIG_REISER4_FS) += plugin/
diff -puN /dev/null fs/reiser4/plugin/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/Makefile	2005-11-08 19:34:21.089322803 +0300
@@ -0,0 +1,26 @@
+obj-$(CONFIG_REISER4_FS) += plugins.o
+
+plugins-objs :=			\
+	plugin.o		\
+	plugin_set.o		\
+	object.o		\
+	inode_ops.o		\
+	inode_ops_rename.o	\
+	file_ops.o		\
+	file_ops_readdir.o	\
+	file_plugin_common.o	\
+	dir_plugin_common.o	\
+	digest.o		\
+	hash.o			\
+	fibration.o		\
+	tail_policy.o		\
+	regular.o
+
+obj-$(CONFIG_REISER4_FS) += item/
+obj-$(CONFIG_REISER4_FS) += file/
+obj-$(CONFIG_REISER4_FS) += dir/
+obj-$(CONFIG_REISER4_FS) += node/
+obj-$(CONFIG_REISER4_FS) += compress/
+obj-$(CONFIG_REISER4_FS) += space/
+obj-$(CONFIG_REISER4_FS) += disk_format/
+obj-$(CONFIG_REISER4_FS) += security/
diff -puN /dev/null fs/reiser4/plugin/compress/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/compress/Makefile	2005-11-08 19:34:21.093324047 +0300
@@ -0,0 +1,6 @@
+obj-$(CONFIG_REISER4_FS) += compress_plugins.o
+
+compress_plugins-objs :=	\
+	compress.o		\
+	minilzo.o		\
+	compress_mode.o
diff -puN /dev/null fs/reiser4/plugin/dir/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/dir/Makefile	2005-11-08 19:34:21.089322803 +0300
@@ -0,0 +1,5 @@
+obj-$(CONFIG_REISER4_FS) += dir_plugins.o
+
+dir_plugins-objs :=	\
+	hashed_dir.o	\
+	seekable_dir.o
diff -puN /dev/null fs/reiser4/plugin/disk_format/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/disk_format/Makefile	2005-11-08 19:34:21.097325291 +0300
@@ -0,0 +1,5 @@
+obj-$(CONFIG_REISER4_FS) += df_plugins.o
+
+df_plugins-objs :=	\
+	disk_format40.o	\
+	disk_format.o
diff -puN /dev/null fs/reiser4/plugin/file/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/file/Makefile	2005-11-08 19:34:21.089322803 +0300
@@ -0,0 +1,7 @@
+obj-$(CONFIG_REISER4_FS) += file_plugins.o
+
+file_plugins-objs :=		\
+	file.o			\
+	tail_conversion.o	\
+	symlink.o		\
+	cryptcompress.o
diff -puN /dev/null fs/reiser4/plugin/item/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/item/Makefile	2005-11-08 19:34:21.089322803 +0300
@@ -0,0 +1,18 @@
+obj-$(CONFIG_REISER4_FS) += item_plugins.o
+
+item_plugins-objs :=		\
+	item.o			\
+	static_stat.o		\
+	sde.o			\
+	cde.o			\
+	blackbox.o		\
+	internal.o		\
+	tail.o			\
+	ctail.o			\
+	extent.o		\
+	extent_item_ops.o	\
+	extent_file_ops.o	\
+	extent_flush_ops.o
+
+
+
diff -puN /dev/null fs/reiser4/plugin/node/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/node/Makefile	2005-11-08 19:34:21.093324047 +0300
@@ -0,0 +1,5 @@
+obj-$(CONFIG_REISER4_FS) += node_plugins.o
+
+node_plugins-objs :=	\
+	node.o		\
+	node40.o
diff -puN /dev/null fs/reiser4/plugin/security/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/security/Makefile	2005-11-08 19:34:21.097325291 +0300
@@ -0,0 +1,4 @@
+obj-$(CONFIG_REISER4_FS) += security_plugins.o
+
+security_plugins-objs :=	\
+	perm.o
diff -puN /dev/null fs/reiser4/plugin/space/Makefile
--- /dev/null	2003-09-23 21:59:22.000000000 +0400
+++ linux-2.6.14-rc5-mm1-vs/fs/reiser4/plugin/space/Makefile	2005-11-08 19:34:21.093324047 +0300
@@ -0,0 +1,4 @@
+obj-$(CONFIG_REISER4_FS) += space_plugins.o
+
+space_plugins-objs := \
+	bitmap.o

_

--------------070406080508060804010302--




--------------040601050607020605010706--
