Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbTBOT5q>; Sat, 15 Feb 2003 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbTBOT5q>; Sat, 15 Feb 2003 14:57:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6052 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264969AbTBOT5p>;
	Sat, 15 Feb 2003 14:57:45 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 15 Feb 2003 21:07:23 +0100 (MET)
Message-Id: <UTC200302152007.h1FK7NC20192.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] remove BSD_PARTITION
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have both BSD_PARTITION and FREEBSD_PARTITION
denoting the same partition type.

diff -u --recursive --new-file -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	Fri Nov 22 22:40:49 2002
+++ b/fs/partitions/msdos.c	Thu Feb 13 18:15:06 2003
@@ -377,7 +377,7 @@
 	void (*parse)(struct parsed_partitions *, struct block_device *,
 			u32, u32, int);
 } subtypes[] = {
-	{BSD_PARTITION, parse_freebsd},
+	{FREEBSD_PARTITION, parse_freebsd},
 	{NETBSD_PARTITION, parse_netbsd},
 	{OPENBSD_PARTITION, parse_openbsd},
 	{MINIX_PARTITION, parse_minix},
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/genhd.h b/include/linux/genhd.h
--- a/include/linux/genhd.h	Thu Jan  9 18:07:18 2003
+++ b/include/linux/genhd.h	Thu Feb 13 18:14:34 2003
@@ -15,7 +15,7 @@
 #include <linux/device.h>
 
 enum {
-/* These three have identical behaviour; use the second one if DOS fdisk gets
+/* These three have identical behaviour; use the second one if DOS FDISK gets
    confused about extended/logical partitions starting past cylinder 1023. */
 	DOS_EXTENDED_PARTITION = 5,
 	LINUX_EXTENDED_PARTITION = 0x85,
@@ -26,20 +26,17 @@
 
 	SOLARIS_X86_PARTITION =	LINUX_SWAP_PARTITION,
 
-	DM6_PARTITION =	0x54,	/* has DDO: use xlated geom & offset */
-	EZD_PARTITION =	0x55,	/* EZ-DRIVE */
 	DM6_AUX1PARTITION = 0x51,	/* no DDO:  use xlated geom */
 	DM6_AUX3PARTITION = 0x53,	/* no DDO:  use xlated geom */
+	DM6_PARTITION =	0x54,		/* has DDO: use xlated geom & offset */
+	EZD_PARTITION =	0x55,		/* EZ-DRIVE */
 
-	FREEBSD_PARTITION = 0xa5,    /* FreeBSD Partition ID */
-	OPENBSD_PARTITION = 0xa6,    /* OpenBSD Partition ID */
-	NETBSD_PARTITION = 0xa9,   /* NetBSD Partition ID */
-	BSDI_PARTITION = 0xb7,    /* BSDI Partition ID */
-/* Ours is not to wonder why.. */
-	BSD_PARTITION =	FREEBSD_PARTITION,
-	MINIX_PARTITION = 0x81,  /* Minix Partition ID */
-	UNIXWARE_PARTITION = 0x63,		/* Partition ID, same as */
-						/* GNU_HURD and SCO Unix */
+	FREEBSD_PARTITION = 0xa5,	/* FreeBSD Partition ID */
+	OPENBSD_PARTITION = 0xa6,	/* OpenBSD Partition ID */
+	NETBSD_PARTITION = 0xa9,	/* NetBSD Partition ID */
+	BSDI_PARTITION = 0xb7,		/* BSDI Partition ID */
+	MINIX_PARTITION = 0x81,		/* Minix Partition ID */
+	UNIXWARE_PARTITION = 0x63,	/* Same as GNU_HURD and SCO Unix */
 };
 
 struct partition {
