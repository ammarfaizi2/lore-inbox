Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUK2WIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUK2WIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUK2WIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:08:44 -0500
Received: from palrel12.hp.com ([156.153.255.237]:65233 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261826AbUK2WHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:07:52 -0500
Date: Mon, 29 Nov 2004 16:07:25 -0600
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       andrew.patterson@hp.com
Subject: [PATCH 2.6] cciss: CCISS_GETLUNINFO fix 
Message-ID: <20041129220725.GA32035@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses a problem with reading the partition table struct.
The last time this was submitted it was rejected on the grounds that the driver
has no business reading the partition table. I don't disagree with that, but
we have legacy apps to consider. Changing the ioctl would break those apps
already in customers hands.

Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>
Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>

 cciss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
--------------------------------------------------------------------------------
diff -urNp lx2610-rc1.orig/drivers/block/cciss.c lx2610-rc1-adrianb/drivers/block/cciss.c
--- lx2610-rc1.orig/drivers/block/cciss.c	2004-11-12 11:17:56.000000000 -0600
+++ lx2610-rc1-adrianb/drivers/block/cciss.c	2004-11-29 15:54:21.668060552 -0600
@@ -809,7 +809,7 @@ static int cciss_ioctl(struct inode *ino
  		luninfo.num_opens = drv->usage_count;
  		luninfo.num_parts = 0;
  		/* count partitions 1 to 15 with sizes > 0 */
- 		for(i=1; i <MAX_PART; i++) {
+ 		for(i=0; i < MAX_PART-1; i++) {
 			if (!disk->part[i])
 				continue;
 			if (disk->part[i]->nr_sects != 0)
