Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271068AbRHTNfX>; Mon, 20 Aug 2001 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271094AbRHTNfP>; Mon, 20 Aug 2001 09:35:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271068AbRHTNfB>;
	Mon, 20 Aug 2001 09:35:01 -0400
Date: Mon, 20 Aug 2001 09:35:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [Fix] Re: [2.4.8-ac5 and earlier] fatal mount-problem
In-Reply-To: <3B8102D3.846C64A7@athlon.maya.org>
Message-ID: <Pine.GSO.4.21.0108200932070.2638-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, please apply. sync_dev() in ->release() is 100% bogus - all flushing
the stuff out is done by callers (blkdev_close() et.al.).

--- AC8-7/drivers/scsi/sr.c	Sun Jul 29 01:54:47 2001
+++ linux/drivers/scsi/sr.c	Mon Aug 20 09:25:39 2001
@@ -101,7 +101,6 @@
 {
 	if (scsi_CDs[MINOR(cdi->dev)].device->sector_size > 2048)
 		sr_set_blocklength(MINOR(cdi->dev), 2048);
-	sync_dev(cdi->dev);
 	scsi_CDs[MINOR(cdi->dev)].device->access_count--;
 	if (scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module)
 		__MOD_DEC_USE_COUNT(scsi_CDs[MINOR(cdi->dev)].device->host->hostt->module);


