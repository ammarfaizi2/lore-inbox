Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTDVSQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTDVSQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:16:26 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:40712 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263338AbTDVSOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:37 -0400
Date: Tue, 22 Apr 2003 10:56:53 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, Simon Evans <spse@secret.org.uk>,
       Abraham vd Merwe <abraham@2d3d.co.za>, mtd@infradead.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/mtd/devices
Message-ID: <20030422155653.GB7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are two trivial patches adding C99 initializers to the files. The
patches are against the current BK.

Art Haas

===== drivers/mtd/devices/blkmtd.c 1.29 vs edited =====
--- 1.29/drivers/mtd/devices/blkmtd.c	Sun Mar 23 00:14:13 2003
+++ edited/drivers/mtd/devices/blkmtd.c	Mon Mar 24 11:44:57 2003
@@ -287,12 +287,9 @@
   return 0;
 }
 
-                    
 static struct address_space_operations blkmtd_aops = {
-  writepage:     blkmtd_writepage,
-  readpage:      NULL,
+	.writepage	= blkmtd_writepage,
 }; 
-
 
 /* This is the kernel thread that empties the write queue to disk */
 static int write_queue_task(void *data)
===== drivers/mtd/devices/lart.c 1.1 vs edited =====
--- 1.1/drivers/mtd/devices/lart.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/devices/lart.c	Mon Mar  3 12:21:44 2003
@@ -584,46 +584,41 @@
 
 static struct mtd_info mtd;
 
-static struct mtd_erase_region_info erase_regions[] =
-{
-   /* parameter blocks */
-   {
-	     offset: 0x00000000,
-	  erasesize: FLASH_BLOCKSIZE_PARAM,
-	  numblocks: FLASH_NUMBLOCKS_16m_PARAM
-   },
-   /* main blocks */
-   {
-	     offset: FLASH_BLOCKSIZE_PARAM * FLASH_NUMBLOCKS_16m_PARAM,
-	  erasesize: FLASH_BLOCKSIZE_MAIN,
-	  numblocks: FLASH_NUMBLOCKS_16m_MAIN
-   }
+static struct mtd_erase_region_info erase_regions[] = {
+	/* parameter blocks */
+	{
+		.offset		= 0x00000000,
+		.erasesize	= FLASH_BLOCKSIZE_PARAM,
+		.numblocks	= FLASH_NUMBLOCKS_16m_PARAM,
+	},
+	/* main blocks */
+	{
+		.offset	 = FLASH_BLOCKSIZE_PARAM * FLASH_NUMBLOCKS_16m_PARAM,
+		.erasesize	= FLASH_BLOCKSIZE_MAIN,
+		.numblocks	= FLASH_NUMBLOCKS_16m_MAIN,
+	}
 };
 
 #ifdef HAVE_PARTITIONS
-static struct mtd_partition lart_partitions[] =
-{
-   /* blob */
-   {
-	       name: "blob",
-	     offset: BLOB_START,
-	       size: BLOB_LEN,
-	 mask_flags: 0
-   },
-   /* kernel */
-   {
-	       name: "kernel",
-	     offset: KERNEL_START,			/* MTDPART_OFS_APPEND */
-	       size: KERNEL_LEN,
-	 mask_flags: 0
-   },
-   /* initial ramdisk / file system */
-   {
-	       name: "file system",
-	     offset: INITRD_START,			/* MTDPART_OFS_APPEND */
-	       size: INITRD_LEN,			/* MTDPART_SIZ_FULL */
-	 mask_flags: 0
-   }
+static struct mtd_partition lart_partitions[] = {
+	/* blob */
+	{
+		.name	= "blob",
+		.offset	= BLOB_START,
+		.size	= BLOB_LEN,
+	},
+	/* kernel */
+	{
+		.name	= "kernel",
+		.offset	= KERNEL_START,		/* MTDPART_OFS_APPEND */
+		.size	= KERNEL_LEN,
+	},
+	/* initial ramdisk / file system */
+	{
+		.name	= "file system",
+		.offset	= INITRD_START,		/* MTDPART_OFS_APPEND */
+		.size	= INITRD_LEN,		/* MTDPART_SIZ_FULL */
+	}
 };
 #endif
 
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
