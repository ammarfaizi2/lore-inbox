Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVAGDY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVAGDY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVAGDY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:24:29 -0500
Received: from havoc.gtf.org ([63.115.148.101]:15494 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261159AbVAGDYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:24:25 -0500
Date: Thu, 6 Jan 2005 22:24:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] fix sx8 blk driver device naming
Message-ID: <20050107032424.GA9482@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[sx8 is one of the few SATA boards that's not scsi nor purely ATA;
it's more like I2O]

Please do a

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 drivers/block/sx8.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<katzj@redhat.com> (05/01/06 1.2229.2.1)
   [PATCH] Fix sx8 device naming in sysfs
   
   Attached fixes sysfs naming of sx8 block devs to follow LANANA naming.
   
   You then get /sys/block/sx8!0, etc instead of /sys/block/sx80_0 (device
   names should be /dev/sx8/0 instead of /dev/sx80_0)
   
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c	2005-01-06 22:23:13 -05:00
+++ b/drivers/block/sx8.c	2005-01-06 22:23:13 -05:00
@@ -1503,7 +1503,7 @@
 		}
 
 		port->disk = disk;
-		sprintf(disk->disk_name, DRV_NAME "%u_%u", host->id, i);
+		sprintf(disk->disk_name, DRV_NAME "/%u", (host->id * CARM_MAX_PORTS) + i);
 		sprintf(disk->devfs_name, DRV_NAME "/%u_%u", host->id, i);
 		disk->major = host->major;
 		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
