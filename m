Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290270AbSAXGfK>; Thu, 24 Jan 2002 01:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSAXGfA>; Thu, 24 Jan 2002 01:35:00 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:42187 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290270AbSAXGer>; Thu, 24 Jan 2002 01:34:47 -0500
Date: Thu, 24 Jan 2002 08:31:10 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <adam@yggdrasil.com>
Subject: [PATCH][2.5] Fix block backed loop mounts
Message-ID: <Pine.LNX.4.44.0201240825070.28541-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
	This is a patch which Adam Richter posted sometime back, it still 
hasn't been integrated as of 2.5.3-pre3. I've tested the patch on my box 
and vote for it, it applies clean on 2.5.3-pre3.

Regards,
	Zwane Mwaikambo


--- linux-2.5.2-pre11/drivers/block/loop.c	Mon Jan 14 05:48:01 2002
+++ linux/drivers/block/loop.c	Mon Jan 14 06:13:33 2002
@@ -488,15 +488,15 @@
 			      struct bio *rbh)
 {
 	unsigned long IV = loop_get_iv(lo, rbh->bi_sector);
-	struct bio_vec *to;
+	struct bio_vec *from;
 	char *vto, *vfrom;
 	int ret = 0, i;

-	bio_for_each_segment(to, bio, i) {
-		vfrom = page_address(rbh->bi_io_vec[i].bv_page) + rbh->bi_io_vec[i].bv_offset;
-		vto = page_address(to->bv_page) + to->bv_offset;
+	bio_for_each_segment(from, rbh, i) {
+		vfrom = page_address(from->bv_page) + from->bv_offset;
+		vto = page_address(bio->bi_io_vec[i].bv_page) + bio->bi_io_vec[i].bv_offset;
 		ret |= lo_do_transfer(lo, bio_data_dir(bio), vto, vfrom,
-					to->bv_len, IV);
+					from->bv_len, IV);
 	}

 	return ret;

