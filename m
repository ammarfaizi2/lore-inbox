Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUJ3SAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUJ3SAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUJ3SAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:00:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261233AbUJ3SAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:00:11 -0400
Date: Sat, 30 Oct 2004 19:59:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small partitions/msdos cleanups
Message-ID: <20041030175937.GQ4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the following changes to the msdos partition code:
- remove CONFIG_NEC98_PARTITION leftovers
- make parse_bsd static


diffstat output:
 fs/partitions/Makefile |    1 -
 fs/partitions/check.c  |    3 ---
 fs/partitions/check.h  |    4 ----
 fs/partitions/msdos.c  |    4 ++--
 4 files changed, 2 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/partitions/Makefile.old	2004-10-30 14:42:03.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full//fs/partitions/Makefile	2004-10-30 14:42:13.000000000 +0200
@@ -17,4 +17,3 @@
 obj-$(CONFIG_ULTRIX_PARTITION) += ultrix.o
 obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
-obj-$(CONFIG_NEC98_PARTITION) += nec98.o msdos.o
--- linux-2.6.10-rc1-mm2-full/fs/partitions/check.h.old	2004-10-30 14:40:20.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full//fs/partitions/check.h	2004-10-30 14:40:41.000000000 +0200
@@ -30,7 +30,3 @@
 
 extern int warn_no_part;
 
-extern void parse_bsd(struct parsed_partitions *state,
-			struct block_device *bdev, u32 offset, u32 size,
-			int origin, char *flavour, int max_partitions);
-
--- linux-2.6.10-rc1-mm2-full/fs/partitions/check.c.old	2004-10-30 14:41:32.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full//fs/partitions/check.c	2004-10-30 14:41:43.000000000 +0200
@@ -76,9 +76,6 @@
 #ifdef CONFIG_LDM_PARTITION
 	ldm_partition,		/* this must come before msdos */
 #endif
-#ifdef CONFIG_NEC98_PARTITION
-	nec98_partition,	/* must be come before `msdos_partition' */
-#endif
 #ifdef CONFIG_MSDOS_PARTITION
 	msdos_partition,
 #endif
--- linux-2.6.10-rc1-mm2-full/fs/partitions/msdos.c.old	2004-10-30 14:38:38.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full//fs/partitions/msdos.c	2004-10-30 14:41:57.000000000 +0200
@@ -202,12 +202,12 @@
 #endif
 }
 
-#if defined(CONFIG_BSD_DISKLABEL) || defined(CONFIG_NEC98_PARTITION)
+#if defined(CONFIG_BSD_DISKLABEL)
 /* 
  * Create devices for BSD partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
  */
-void
+static void
 parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
 		u32 offset, u32 size, int origin, char *flavour,
 		int max_partitions)

