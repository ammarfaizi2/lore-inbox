Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbSLFHZO>; Fri, 6 Dec 2002 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbSLFHZO>; Fri, 6 Dec 2002 02:25:14 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:24255 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267679AbSLFHZN>; Fri, 6 Dec 2002 02:25:13 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15856.21342.982592.432584@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 6 Dec 2002 16:35:58 +0900
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nbd.[ch] is broken by MAJOR_NR removal
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbd.h now does not include blk.h, so nbd.c needs to include it.  In
nbd.h an ifdef was removed without removing the closing endif.  Patch
is against bk-latest.

--- linus-2.5/drivers/block/nbd.c.orig	Fri Dec  6 11:56:52 2002
+++ linus-2.5/drivers/block/nbd.c	Fri Dec  6 15:48:55 2002
@@ -54,6 +54,7 @@
 #include <asm/types.h>
 
 #include <linux/nbd.h>
+#include <linux/blk.h>
 
 #define LO_MAGIC 0x68797548
 
--- linus-2.5/include/linux/nbd.h.orig	Fri Dec  6 11:56:52 2002
+++ linus-2.5/include/linux/nbd.h	Fri Dec  6 16:11:40 2002
@@ -53,7 +53,6 @@
 	int blksize_bits;
 	u64 bytesize;
 };
-#endif
 
 /* This now IS in some kind of include file...	*/
 

