Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUHDVBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUHDVBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267418AbUHDVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:00:48 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:57356 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267421AbUHDVAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:00:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: cciss update [2 of 6]
Date: Wed, 4 Aug 2004 16:00:36 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107436093@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [2 of 6]
Thread-index: AcR6ZhcPOlSjZTw8QD+oFPxkHfoXlQ==
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <akpm@osdl.org>, <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 21:00:39.0407 (UTC) FILETIME=[18C58FF0:01C47A66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 6
Name: p002_memset_for_268rc2.patch

This patch addresses a problem with our utilities. Seems like some of them
don't know how much data to request so I have to cover for them in
the driver. We zero out the buffer before copying their data into it.
This patch applies to 2.6.8-rc2. Please consider this for inclusion.
Please apply patches in order.

Thanks,
mikem
-------------------------------------------------------------------------------
diff -burpN lx268-rc2-p001/drivers/block/cciss.c lx268-rc2/drivers/block/cciss.c
--- lx268-rc2-p001/drivers/block/cciss.c        2004-07-30 10:26:55.243049000 -0500
+++ lx268-rc2/drivers/block/cciss.c     2004-07-30 11:19:33.666896400 -0500
@@ -868,6 +868,8 @@ static int cciss_ioctl(struct inode *ino
                                kfree(buff);
                                return -EFAULT;
                        }
+               } else {
+                       memset(buff, 0, iocommand.buf_size);
                }
                if ((c = cmd_alloc(host , 0)) == NULL)
                {
@@ -1014,6 +1016,8 @@ static int cciss_ioctl(struct inode *ino
                                copy_from_user(buff[sg_used], data_ptr, sz)) {
                                        status = -ENOMEM;
                                        goto cleanup1;
+                       } else {
+                               memset(buff[sg_used], 0, sz);
                        }
                        left -= sz;
                        data_ptr += sz;
