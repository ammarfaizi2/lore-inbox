Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290280AbSAXHBP>; Thu, 24 Jan 2002 02:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290281AbSAXHAz>; Thu, 24 Jan 2002 02:00:55 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:39569 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S290280AbSAXHAt>; Thu, 24 Jan 2002 02:00:49 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 23 Jan 2002 23:00:26 -0800
Message-Id: <200201240700.XAA17286@adam.yggdrasil.com>
To: axboe@suse.de, zwane@linux.realnet.co.sz
Subject: Re: [PATCH][2.5] Fix block backed loop mounts
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Thank you for picking up this patch and resubmitting it.  I
don't think anyone had any complaints about it before.  I was
wondering if it had fallen through the cracks.  Jens, do you want to
integrate this patch into whatever you are sending to Linus, or should
Zwane or I needle Linus directly about it?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


>From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
>To: Jens Axboe <axboe@suse.de>

>Hi Jens,
>	This is a patch which Adam Richter posted sometime back, it still 
>hasn't been integrated as of 2.5.3-pre3. I've tested the patch on my box 
>and vote for it, it applies clean on 2.5.3-pre3.

>Regards,
>	Zwane Mwaikambo


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


