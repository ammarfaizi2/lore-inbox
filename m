Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316283AbSEKX1a>; Sat, 11 May 2002 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316282AbSEKX13>; Sat, 11 May 2002 19:27:29 -0400
Received: from pl174.dhcp.adsl.tpnet.pl ([217.98.31.174]:11139 "EHLO
	blurp.slackware.pl") by vger.kernel.org with ESMTP
	id <S316283AbSEKX13>; Sat, 11 May 2002 19:27:29 -0400
Date: Sun, 12 May 2002 01:29:37 +0200 (CEST)
From: Pawel Kot <pkot@ziew.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move MAX_BUF_PER_PAGE definition into the header file
Message-ID: <Pine.LNX.4.33.0205120111110.6469-100000@blurp.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The patch attached moves the MAX_BUF_PER_PAGE definition from the fs/*
files into include/linux/fs.h. It is defined now independly in 2 spearate
files in fs/ and we use it also in the NTFS-TNG (all definitions are
identical). Not much win, but it is IMHO the correct thing.
The similiar thing is already done in 2.5.x.

Please apply.

diff -Nur linux-2.4.19-pre8/fs/block_dev.c linux-2.4.19-pre8-1/fs/block_dev.c
--- linux-2.4.19-pre8/fs/block_dev.c	Sun May 12 00:43:38 2002
+++ linux-2.4.19-pre8-1/fs/block_dev.c	Sun May 12 00:26:03 2002
@@ -22,8 +22,6 @@

 #include <asm/uaccess.h>

-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-
 static unsigned long max_block(kdev_t dev)
 {
 	unsigned int retval = ~0U;
diff -Nur linux-2.4.19-pre8/fs/buffer.c linux-2.4.19-pre8-1/fs/buffer.c
--- linux-2.4.19-pre8/fs/buffer.c	Sun May 12 00:43:38 2002
+++ linux-2.4.19-pre8-1/fs/buffer.c	Sun May 12 00:26:20 2002
@@ -54,7 +54,6 @@
 #include <asm/bitops.h>
 #include <asm/mmu_context.h>

-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
 #define NR_RESERVED (10*MAX_BUF_PER_PAGE)
 #define MAX_UNUSED_BUFFERS NR_RESERVED+20 /* don't ever have more than this
 					     number of unused buffer heads */
diff -Nur linux-2.4.19-pre8/include/linux/fs.h linux-2.4.19-pre8-1/include/linux/fs.h
--- linux-2.4.19-pre8/include/linux/fs.h	Sun May 12 00:43:48 2002
+++ linux-2.4.19-pre8-1/include/linux/fs.h	Sun May 12 01:03:50 2002
@@ -225,6 +225,8 @@
 			 */
 };

+#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
+
 /*
  * Try to keep the most commonly used fields in single cache lines (16
  * bytes) to improve performance.  This ordering should be

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku


