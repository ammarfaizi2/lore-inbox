Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUHEAIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUHEAIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUHEAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:08:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21124 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S267523AbUHEAIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:08:06 -0400
Date: Wed, 4 Aug 2004 16:30:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dan Zink <dan.zink@hp.com>
Subject: [PATCH] ppc32: Fix 'mktree' on 64bit hosts
Message-ID: <20040804233035.GS9235@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch changes some 'unsigned long's into 'uint32_t's in
mktree (a program that runs on the host to frob the kernel image for
some firmwares).  Without it, the program is not correct when run
on/compiled on a 64bit host.

Signed-off-by: Dan Zink <dan.zink@hp.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- arch/ppc/boot/utils/mktree.c.old	2004-08-03 16:31:09.568992888 -0500
+++ arch/ppc/boot/utils/mktree.c	2004-08-04 11:06:39.799051328 -0500
@@ -15,19 +15,20 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <netinet/in.h>
+#include <stdint.h>
 
 /* This gets tacked on the front of the image.  There are also a few
  * bytes allocated after the _start label used by the boot rom (see
  * head.S for details).
  */
 typedef struct boot_block {
-	unsigned long bb_magic;		/* 0x0052504F */
-	unsigned long bb_dest;		/* Target address of the image */
-	unsigned long bb_num_512blocks;	/* Size, rounded-up, in 512 byte blks */
-	unsigned long bb_debug_flag;	/* Run debugger or image after load */
-	unsigned long bb_entry_point;	/* The image address to start */
-	unsigned long bb_checksum;	/* 32 bit checksum including header */
-	unsigned long reserved[2];
+	uint32_t bb_magic;		/* 0x0052504F */
+	uint32_t bb_dest;		/* Target address of the image */
+	uint32_t bb_num_512blocks;	/* Size, rounded-up, in 512 byte blks */
+	uint32_t bb_debug_flag;	/* Run debugger or image after load */
+	uint32_t bb_entry_point;	/* The image address to start */
+	uint32_t bb_checksum;	/* 32 bit checksum including header */
+	uint32_t reserved[2];
 } boot_block_t;
 
 #define IMGBLK	512

-- 
Tom Rini
http://gate.crashing.org/~trini/
