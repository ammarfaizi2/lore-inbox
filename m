Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSHKHNT>; Sun, 11 Aug 2002 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSHKHNT>; Sun, 11 Aug 2002 03:13:19 -0400
Received: from h-64-105-136-41.SNVACAID.covad.net ([64.105.136.41]:45528 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317836AbSHKHNS>; Sun, 11 Aug 2002 03:13:18 -0400
Date: Sun, 11 Aug 2002 00:16:59 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.31/include/linux/blkdev.h paranethesis problem in BLK__DEFAULT_QUEUE
Message-ID: <20020811001659.A25279@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

	The following trivial fix has been in my kernel tree for
ages.  It is need for the C compiler to compile statements like
the following, which I use in my version of loop.c:

	BLK_DEFAULT_QUEUE(MAJOR_NR)->queuedata = NULL;

	Could you please apply it to your tree and forward it to
Linus (or let me know if you'd prefer to handle it some other way).

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blkdev.patch"

--- linux-2.5.31/include/linux/blkdev.h	2002-08-10 18:41:23.000000000 -0700
+++ linux/include/linux/blkdev.h	2002-08-11 00:06:37.000000000 -0700
@@ -272,7 +272,7 @@
  * so as to eliminate the need for each and every block device
  * driver to know about the internal structure of blk_dev[].
  */
-#define BLK_DEFAULT_QUEUE(_MAJOR)  &blk_dev[_MAJOR].request_queue
+#define BLK_DEFAULT_QUEUE(_MAJOR)  (&blk_dev[_MAJOR].request_queue)
 
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];

--lrZ03NoBR/3+SXJZ--
