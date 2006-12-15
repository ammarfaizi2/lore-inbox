Return-Path: <linux-kernel-owner+w=401wt.eu-S964958AbWLOVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWLOVE7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWLOVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:04:59 -0500
Received: from palrel10.hp.com ([156.153.255.245]:59969 "EHLO palrel10.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964958AbWLOVE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:04:58 -0500
X-Greylist: delayed 933 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 16:04:58 EST
Date: Fri, 15 Dec 2006 14:49:22 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: jens.axboe@oracle.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       daniel_frazier@hp.com, andrew.patterson@hp.com
Subject: [PATCH 1/2] cciss: set default raid level when reading geometry fails
Message-ID: <20061215204922.GA8682@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH 1 of 2

This patch sets a default raid level on a volume that either does not support
reading the geometry or reports an invalid geometry for whatever reason. We
were always setting some values for heads and sectors but never set a raid
level. This caused lots of problems on some buggy firmware. Please consider
this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>
--------------------------------------------------------------------------------

 drivers/block/cciss.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/block/cciss.c~cciss_set_default_raidlevel drivers/block/cciss.c
--- linux-2.6-work/drivers/block/cciss.c~cciss_set_default_raidlevel	2006-12-13 11:04:39.000000000 -0600
+++ linux-2.6-work-mikem/drivers/block/cciss.c	2006-12-13 11:05:06.000000000 -0600
@@ -1907,6 +1907,7 @@ static void cciss_geometry_inquiry(int c
 			       "does not support reading geometry\n");
 			drv->heads = 255;
 			drv->sectors = 32;	// Sectors per track
+			drv->raid_level = RAID_UNKNOWN;
 		} else {
 			drv->heads = inq_buff->data_byte[6];
 			drv->sectors = inq_buff->data_byte[7];
_
