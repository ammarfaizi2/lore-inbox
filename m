Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUHCWBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUHCWBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUHCWBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:01:17 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:12048 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266890AbUHCWBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:01:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile environment
Date: Tue, 3 Aug 2004 17:01:05 -0500
Message-ID: <8C91B010B3B7994C88A266E1A72184D306BEFD8F@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile environment
Thread-Index: AcR5pV+DhF1D8gnsSSGYYyJGgdOQcQ==
From: "Zink, Dan" <dan.zink@hp.com>
To: <akpm@osdl.org>, <linuxppc-dev@lists.linuxppc.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Aug 2004 22:01:06.0943 (UTC) FILETIME=[6089E0F0:01C479A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mktree utility is using "unsigned long" in the definition of a boot
block structure.  This is bad when cross compiling from a 64-bit
architecture...

Thanks,
Dan


--- arch/ppc/boot/utils/mktree.c.old	2004-08-03 16:31:09.568992888
-0500
+++ arch/ppc/boot/utils/mktree.c	2004-08-03 16:32:26.773256056
-0500
@@ -15,19 +15,20 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <netinet/in.h>
+#include <asm/types.h>
 
 /* This gets tacked on the front of the image.  There are also a few
  * bytes allocated after the _start label used by the boot rom (see
  * head.S for details).
  */
 typedef struct boot_block {
-	unsigned long bb_magic;		/* 0x0052504F */
-	unsigned long bb_dest;		/* Target address of the image
*/
-	unsigned long bb_num_512blocks;	/* Size, rounded-up, in 512 byte
blks */
-	unsigned long bb_debug_flag;	/* Run debugger or image after
load */
-	unsigned long bb_entry_point;	/* The image address to start */
-	unsigned long bb_checksum;	/* 32 bit checksum including
header */
-	unsigned long reserved[2];
+	__u32 bb_magic;		/* 0x0052504F */
+	__u32 bb_dest;		/* Target address of the image */
+	__u32 bb_num_512blocks;	/* Size, rounded-up, in 512 byte blks */
+	__u32 bb_debug_flag;	/* Run debugger or image after load */
+	__u32 bb_entry_point;	/* The image address to start */
+	__u32 bb_checksum;	/* 32 bit checksum including header */
+	__u32 reserved[2];
 } boot_block_t;
 
 #define IMGBLK	512
