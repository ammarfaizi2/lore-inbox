Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315390AbSEGIxD>; Tue, 7 May 2002 04:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315391AbSEGIxC>; Tue, 7 May 2002 04:53:02 -0400
Received: from [210.175.4.211] ([210.175.4.211]:6660 "EHLO sarah.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S315390AbSEGIxC>;
	Tue, 7 May 2002 04:53:02 -0400
Message-ID: <3CD79586.63E17164@cinet.co.jp>
Date: Tue, 07 May 2002 17:51:18 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.79C-ja  [ja/Vine] (X11; U; Linux 2.5.14-pc98 i586)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.14 IDE CD-ROM PIO mode
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could not use CD-ROM drive [PIO mode] on 2.5.14.
Error messeges are follows.

May  7 11:05:03 sarah kernel: hdc: cdrom_read_intr: data underrun (4294967292 blocks)
May  7 11:05:03 sarah kernel: end_request: I/O error, dev 16:00, sector 92
May  7 11:05:03 sarah kernel: Buffer I/O error on device ide1(22,0), logical block 22

This patch works fine for me. Please check it.

--- linux/drivers/ide/ide-cd.c.orig	Mon May  6 12:38:01 2002
+++ linux/drivers/ide/ide-cd.c	Tue May  7 16:43:51 2002
@@ -962,7 +962,7 @@
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
-	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
+	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
-- 
Osamu Tomita
E-mail: tomita@cinet.co.jp
