Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262463AbSJKOHg>; Fri, 11 Oct 2002 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJKOHd>; Fri, 11 Oct 2002 10:07:33 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:37903 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S262463AbSJKOHb>; Fri, 11 Oct 2002 10:07:31 -0400
Date: Fri, 11 Oct 2002 08:09:30 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss (2 of 3)
Message-ID: <20021011080930.B1911@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set gendisk fops.  (IBM logical volume manager, for one, needs this.)

diff -urN linux-2.5.41-o/drivers/block/cciss.c linux-2.5.41-p/drivers/block/cciss.c
--- linux-2.5.41-o/drivers/block/cciss.c	Wed Oct  9 15:08:22 2002
+++ linux-2.5.41-p/drivers/block/cciss.c	Wed Oct  9 15:22:14 2002
@@ -2501,6 +2501,7 @@
 		disk->major = MAJOR_NR + i;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->minor_shift = NWD_SHIFT;
+		disk->fops = &cciss_fops;
 		if( !(drv->nr_blocks))
 			continue;
 		(BLK_DEFAULT_QUEUE(MAJOR_NR + i))->hardsect_size = drv->block_size;
