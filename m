Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVLLURw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVLLURw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLLURv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:17:51 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:14762 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932220AbVLLURu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:17:50 -0500
Date: Mon, 12 Dec 2005 14:17:03 -0600
From: mike.miller@hp.com
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/1] cciss: fix for deregister_disk
Message-ID: <20051212201703.GA9395@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/1
Been doing some cleanup in various parts of the driver (more like adding
bugs). Got to keep busy!
This patch adds setting our drv->queue = NULL back in deregister_disk.
The drv->queue is part of our controller struct. blk_cleanup_queue works
only on the queue in the gendisk struct. Please apply this patch.

Signed-off-by: Mike Miller <mike.miller@hp.com.
--------------------------------------------------------------------------------
 cciss.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index e34104d..1d56f2a 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1464,8 +1464,10 @@ static int deregister_disk(struct gendis
 			request_queue_t *q = disk->queue;
 			if (disk->flags & GENHD_FL_UP)
 				del_gendisk(disk);
-			if (q)	
+			if (q) {	
 				blk_cleanup_queue(q);
+				drv->queue = NULL;
+			}
 		}
 	}
 
