Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUCZOGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCZOGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:06:49 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:29455 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261815AbUCZOGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:06:48 -0500
Date: Fri, 26 Mar 2004 08:19:46 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: cciss update for 2.6 -- resubmit
Message-ID: <20040326141946.GF4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
References: <D4CFB69C345C394284E4B78B876C1CF105BC1F6E@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF105BC1F6E@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the right patch for 2.6. Sorry for my confusion.

 cciss.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)
-------------------------------------------------------------------------------
diff -burpN lx265-rc2.orig/drivers/block/cciss.c lx265-rc2/drivers/block/cciss.c
--- lx265-rc2.orig/drivers/block/cciss.c	2004-03-12 10:10:47.000000000 -0600
+++ lx265-rc2/drivers/block/cciss.c	2004-03-26 08:09:52.000000000 -0600
@@ -469,11 +469,8 @@ static int cciss_ioctl(struct inode *ino
                         driver_geo.heads = drv->heads;
                         driver_geo.sectors = drv->sectors;
                         driver_geo.cylinders = drv->cylinders;
-                } else {
-                        driver_geo.heads = 0xff;
-                        driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = (int)drv->nr_blocks / (0xff*0x3f);
-                }
+                } else
+			return -ENXIO;
                 driver_geo.start= get_start_sect(inode->i_bdev);
                 if (copy_to_user((void *) arg, &driver_geo,
                                 sizeof( struct hd_geometry)))
