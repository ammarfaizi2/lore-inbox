Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVFQUBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVFQUBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVFQUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 16:01:40 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:15532 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262089AbVFQUBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 16:01:37 -0400
Date: Fri, 17 Jun 2005 14:02:08 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] cciss 2.6: remove partition info from CCISS_GETLUNINFO
Message-ID: <20050617190208.GA10465@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fulfills a promise I made to Christoph sometime back. I am removing the partition info from the CCISS_GETLUNINFO ioctl as I was informed my "driver had no damn business reading that structure." ;)
The application folks are to use /proc or /sys for partition info from now on. I am only aware of a few apps that use this ioctl and I'm not sure they ever used the partition info.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    7 -------
 1 files changed, 7 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2612-rc6-p002/drivers/block/cciss.c lx2612-rc6/drivers/block/cciss.c
--- lx2612-rc6-p002/drivers/block/cciss.c	2005-06-17 13:17:23.262424000 -0500
+++ lx2612-rc6/drivers/block/cciss.c	2005-06-17 13:51:47.347635712 -0500
@@ -792,13 +792,6 @@ static int cciss_ioctl(struct inode *ino
  		luninfo.LunID = drv->LunID;
  		luninfo.num_opens = drv->usage_count;
  		luninfo.num_parts = 0;
- 		/* count partitions 1 to 15 with sizes > 0 */
- 		for (i = 0; i < MAX_PART - 1; i++) {
-			if (!disk->part[i])
-				continue;
-			if (disk->part[i]->nr_sects != 0)
-				luninfo.num_parts++;
-		}
  		if (copy_to_user(argp, &luninfo,
  				sizeof(LogvolInfo_struct)))
  			return -EFAULT;
