Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283453AbRK3BTE>; Thu, 29 Nov 2001 20:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283456AbRK3BSy>; Thu, 29 Nov 2001 20:18:54 -0500
Received: from mail108.mail.bellsouth.net ([205.152.58.48]:33384 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S283453AbRK3BSr>; Thu, 29 Nov 2001 20:18:47 -0500
Message-ID: <3C06DE6F.746DA60A@mandrakesoft.com>
Date: Thu, 29 Nov 2001 20:18:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.1.4: fix rd.c build
Content-Type: multipart/mixed;
 boundary="------------B671379D82C0D5E1AC21AF6C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B671379D82C0D5E1AC21AF6C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

...just a missed s/bio_size/foo->bi_size/ conversion. please apply.
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------B671379D82C0D5E1AC21AF6C
Content-Type: text/plain; charset=us-ascii;
 name="rd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rd.patch"

Index: drivers/block/rd.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/block/rd.c,v
retrieving revision 1.3
diff -u -r1.3 rd.c
--- drivers/block/rd.c	2001/11/30 01:10:57	1.3
+++ drivers/block/rd.c	2001/11/30 01:17:24
@@ -239,7 +239,7 @@
 
 	index = sbh->bi_sector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sbh->bi_sector << 9) & ~PAGE_CACHE_MASK;
-	size = bio_size(sbh);
+	size = sbh->bi_size;
 
 	do {
 		int count;
@@ -323,7 +323,7 @@
 		goto fail;
 
 	offset = sbh->bi_sector << 9;
-	len = bio_size(sbh);
+	len = sbh->bi_size;
 
 	if ((offset + len) > rd_length[minor])
 		goto fail;

--------------B671379D82C0D5E1AC21AF6C--


