Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbULNBLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbULNBLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbULNBLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:11:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52240 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261367AbULNBKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:10:14 -0500
Date: Tue, 14 Dec 2004 02:10:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small partitions/msdos cleanups (fwd) (fwd)
Message-ID: <20041214011011.GR23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (already ACK'ed by Andries Brouwer) still
applies and compiles against 2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Tue, 7 Dec 2004 20:35:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small partitions/msdos cleanups (fwd)

The patch forwarded below (already ACK'ed by Andries Brouwer) still 
applies and compiles against 2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 19:59:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small partitions/msdos cleanups

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

