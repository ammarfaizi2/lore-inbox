Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUDHOcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDHOag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:30:36 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:64954 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S261888AbUDHO36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:29:58 -0400
Date: Thu, 8 Apr 2004 16:29:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/12): dcss block driver fix.
Message-ID: <20040408142947.GG1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DCSS block device driver changes:
 - Fix remove_store function, put_device is called too early.

diffstat:
 drivers/s390/block/dcssblk.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-s390/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	Sun Apr  4 05:36:26 2004
+++ linux-2.6-s390/drivers/s390/block/dcssblk.c	Thu Apr  8 15:21:27 2004
@@ -548,10 +548,10 @@
 	dev_info->gd->queue = NULL;
 	put_disk(dev_info->gd);
 	device_unregister(&dev_info->dev);
-	put_device(&dev_info->dev);
 	segment_unload(dev_info->segment_name);
 	PRINT_DEBUG("Segment %s unloaded successfully\n",
 			dev_info->segment_name);
+	put_device(&dev_info->dev);
 	rc = count;
 out_buf:
 	kfree(local_buf);
