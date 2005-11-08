Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVKHQ4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVKHQ4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVKHQ4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:56:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030252AbVKHQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:56:00 -0500
Date: Tue, 8 Nov 2005 17:55:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: please pull from the trivial tree
Message-ID: <20051108165559.GZ3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following changes:


 Documentation/early-userspace/README       |    2 
 MAINTAINERS                                |    1 
 drivers/block/floppy.c                     |    8 -
 drivers/char/ftape/lowlevel/ftape-buffer.c |    1 
 fs/afs/callback.c                          |    1 
 fs/befs/attribute.c                        |  117 ---------------------
 fs/freevxfs/vxfs_bmap.c                    |    1 
 fs/freevxfs/vxfs_olt.c                     |    1 
 fs/ioprio.c                                |    1 
 fs/jffs/jffs_fm.c                          |    1 
 fs/partitions/ultrix.c                     |    1 
 fs/reiserfs/hashes.c                       |    1 
 include/linux/idr.h                        |    6 +
 mm/slab.c                                  |    2 
 14 files changed, 20 insertions(+), 124 deletions(-)


Adrian Bunk:
  mm/slab.c: fix a comment typo
  MAINTAINERS: PKTCDVD DRIVER: remove entry for a subscribers-only list
  fs/freevxfs/: add #include's
  jffs_fm.c should #include "intrep.h"
  fs/partitions/ultrix.c should #include "ultrix.h"
  fs/reiserfs/hashes.c should #include <linux/reiserfs_fs.h>
  drivers/char/ftape/lowlevel/ftape-buffer.c should #include "../lowlevel/ftape-buffer.h"
  fs/afs/callback.c should #include "cmservice.h"
  fs/ioprio.c should #include <linux/syscalls.h>

James Nelson:
  floppy: relocate devfs comment

Jim Cromie:
  earlyuserspace/README: fix homonym err

Luben Tuikov:
  include/linux: enclose idr.h in #ifndef

Will Dyson:
  remove unused fs/befs/attribute.c


diff --git a/Documentation/early-userspace/README b/Documentation/early-userspace/README
index 270a88e..cddbac4 100644
--- a/Documentation/early-userspace/README
+++ b/Documentation/early-userspace/README
@@ -28,7 +28,7 @@ the image from specifications.
 CPIO ARCHIVE method
 
 You can create a cpio archive that contains the early userspace image.
-Youre cpio archive should be specified in CONFIG_INITRAMFS_SOURCE and it
+Your cpio archive should be specified in CONFIG_INITRAMFS_SOURCE and it
 will be used directly.  Only a single cpio file may be specified in
 CONFIG_INITRAMFS_SOURCE and directory and file names are not allowed in
 combination with a cpio archive.
diff --git a/MAINTAINERS b/MAINTAINERS
index 995bfd8..3028d4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1970,7 +1970,6 @@ PKTCDVD DRIVER
 P:	Peter Osterlund
 M:	petero2@telia.com
 L:	linux-kernel@vger.kernel.org
-L:	packet-writing@suse.com
 S:	Maintained
 
 POSIX CLOCKS and TIMERS
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 5eadbb9..77cfd69 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -98,6 +98,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -158,10 +162,6 @@ static int print_unex = 1;
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 
diff --git a/drivers/char/ftape/lowlevel/ftape-buffer.c b/drivers/char/ftape/lowlevel/ftape-buffer.c
index 54af20c..c706ff1 100644
--- a/drivers/char/ftape/lowlevel/ftape-buffer.c
+++ b/drivers/char/ftape/lowlevel/ftape-buffer.c
@@ -33,6 +33,7 @@
 #include "../lowlevel/ftape-rw.h"
 #include "../lowlevel/ftape-read.h"
 #include "../lowlevel/ftape-tracing.h"
+#include "../lowlevel/ftape-buffer.h"
 
 /*  DMA'able memory allocation stuff.
  */
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 2fd62f8..9cb206e 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -19,6 +19,7 @@
 #include "server.h"
 #include "vnode.h"
 #include "internal.h"
+#include "cmservice.h"
 
 /*****************************************************************************/
 /*
diff --git a/fs/befs/attribute.c b/fs/befs/attribute.c
deleted file mode 100644
index e329d72..0000000
--- a/fs/befs/attribute.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * linux/fs/befs/attribute.c
- *
- * Copyright (C) 2002 Will Dyson <will_dyson@pobox.com>
- *
- * Many thanks to Dominic Giampaolo, author of "Practical File System
- * Design with the Be File System", for such a helpful book.
- *
- */
-
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include "befs.h"
-#include "endian.h"
-
-#define SD_DATA(sd)\
-	(void*)((char*)sd + sizeof(*sd) + (sd->name_size - sizeof(sd->name)))
-
-#define SD_NEXT(sd)\
-	(befs_small_data*)((char*)sd + sizeof(*sd) + (sd->name_size - \
-	sizeof(sd->name) + sd->data_size))
-
-int
-list_small_data(struct super_block *sb, befs_inode * inode, filldir_t filldir);
-
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode,
-				 const char *name);
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-		 befs_small_data * sdata, void *buf, size_t bufsize);
-
-/**
- *
- *
- *
- *
- *
- */
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode, const char *name)
-{
-	befs_small_data *sdata = inode->small_data;
-
-	while (sdata->type != 0) {
-		if (strcmp(name, sdata->name) != 0) {
-			return sdata;
-		}
-		sdata = SD_NEXT(sdata);
-	}
-	return NULL;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-		const char *name, void *buf, size_t bufsize)
-{
-	befs_small_data *sdata;
-
-	sdata = find_small_data(sb, inode, name);
-	if (sdata == NULL)
-		return BEFS_ERR;
-	else if (sdata->data_size > bufsize)
-		return BEFS_ERR;
-
-	memcpy(buf, SD_DATA(sdata), sdata->data_size);
-
-	return BEFS_OK;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_small_data(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}
diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index d3f6b28..2d71128 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -36,6 +36,7 @@
 
 #include "vxfs.h"
 #include "vxfs_inode.h"
+#include "vxfs_extern.h"
 
 
 #ifdef DIAGNOSTIC
diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 1334762..76a0708 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -36,6 +36,7 @@
 
 #include "vxfs.h"
 #include "vxfs_olt.h"
+#include "vxfs_extern.h"
 
 
 static inline void
diff --git a/fs/ioprio.c b/fs/ioprio.c
index d1c1f2b..4bf1c63 100644
--- a/fs/ioprio.c
+++ b/fs/ioprio.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/ioprio.h>
 #include <linux/blkdev.h>
+#include <linux/syscalls.h>
 
 static int set_task_ioprio(struct task_struct *task, int ioprio)
 {
diff --git a/fs/jffs/jffs_fm.c b/fs/jffs/jffs_fm.c
index 053e3a9..6da13b3 100644
--- a/fs/jffs/jffs_fm.c
+++ b/fs/jffs/jffs_fm.c
@@ -20,6 +20,7 @@
 #include <linux/blkdev.h>
 #include <linux/jffs.h>
 #include "jffs_fm.h"
+#include "intrep.h"
 
 #if defined(JFFS_MARK_OBSOLETE) && JFFS_MARK_OBSOLETE
 static int jffs_mark_obsolete(struct jffs_fmcontrol *fmc, __u32 fm_offset);
diff --git a/fs/partitions/ultrix.c b/fs/partitions/ultrix.c
index 8a8d4d9..ec852c1 100644
--- a/fs/partitions/ultrix.c
+++ b/fs/partitions/ultrix.c
@@ -7,6 +7,7 @@
  */
 
 #include "check.h"
+#include "ultrix.h"
 
 int ultrix_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
diff --git a/fs/reiserfs/hashes.c b/fs/reiserfs/hashes.c
index 37c1306..a3ec238 100644
--- a/fs/reiserfs/hashes.c
+++ b/fs/reiserfs/hashes.c
@@ -19,6 +19,7 @@
 //
 
 #include <linux/kernel.h>
+#include <linux/reiserfs_fs.h>
 #include <asm/types.h>
 #include <asm/bug.h>
 
diff --git a/include/linux/idr.h b/include/linux/idr.h
index 7fb3ff9..d37c8d8 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -8,6 +8,10 @@
  * Small id to pointer translation service avoiding fixed sized
  * tables.
  */
+
+#ifndef __IDR_H__
+#define __IDR_H__
+
 #include <linux/types.h>
 #include <linux/bitops.h>
 
@@ -77,3 +81,5 @@ int idr_get_new_above(struct idr *idp, v
 void idr_remove(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
+
+#endif /* __IDR_H__ */
diff --git a/mm/slab.c b/mm/slab.c
index e291f5e..8a73dcf 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -434,7 +434,7 @@ struct kmem_cache {
 /* Optimization question: fewer reaps means less 
  * probability for unnessary cpucache drain/refill cycles.
  *
- * OTHO the cpuarrays can contain lots of objects,
+ * OTOH the cpuarrays can contain lots of objects,
  * which could lock up otherwise freeable slabs.
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
