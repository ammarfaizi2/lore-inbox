Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJNVFq>; Mon, 14 Oct 2002 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSJNVFq>; Mon, 14 Oct 2002 17:05:46 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:27921 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S262214AbSJNVFo>; Mon, 14 Oct 2002 17:05:44 -0400
Date: Mon, 14 Oct 2002 15:07:51 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.42, cciss, set gendisk fops (2 of 7)
Message-ID: <20021014150751.B1257@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch 2 of 7
This patch sets the fops (IBM logical volume manager needs this, for one.)
Applies to 2.5.42.

diff -urN linux-2.5.42-b/drivers/block/cciss.c linux-2.5.42-c/drivers/block/cciss.c
--- linux-2.5.42-b/drivers/block/cciss.c	Mon Oct 14 10:08:01 2002
+++ linux-2.5.42-c/drivers/block/cciss.c	Mon Oct 14 10:19:07 2002
@@ -2448,6 +2448,7 @@
 		disk->major = MAJOR_NR + i;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->minor_shift = NWD_SHIFT;
+		disk->fops = &cciss_fops;
 		if( !(drv->nr_blocks))
 			continue;
 		(BLK_DEFAULT_QUEUE(MAJOR_NR + i))->hardsect_size = drv->block_size;
