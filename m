Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVAaXxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVAaXxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVAaXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:53:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2310 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261458AbVAaXm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:27 -0500
Date: Tue, 1 Feb 2005 00:42:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small partitions/msdos cleanups
Message-ID: <20050131234220.GP21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following changes to the msdos partition code:
- remove CONFIG_NEC98_PARTITION leftovers
- make parse_bsd static

This patch was already ACK'ed by Andries Brouwer.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 fs/partitions/Makefile |    1 -
 fs/partitions/check.c  |    3 ---
 fs/partitions/check.h  |    4 ----
 fs/partitions/msdos.c  |    4 ++--
 4 files changed, 2 insertions(+), 10 deletions(-)

This patch was already sent on:
- 30 Oct 2004
- 7 Dec 2004
- 14 Dec 2004
- 7 Jan 2005

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

