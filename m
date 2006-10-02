Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965434AbWJBVrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965434AbWJBVrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965433AbWJBVrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:47:32 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:34960 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965434AbWJBVrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:47:31 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 3/4] 2.6.18-mm2 pktcdvd: restructure code
References: <op.tgratfqriudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Oct 2006 23:47:03 +0200
In-Reply-To: <op.tgratfqriudtyh@master>
Message-ID: <m3d59afl0o.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch 3/4 for pktcdvd against Linux 2.6.18 (stable)
> or 2.6.18-mm2 restructures the code for better readability
> and prepares it for the sysfs interface code following in patch 4/4.

This part looks good. Andrew, please apply:


From: Thomas Maier <balagi@justmail.de>

pktcdvd: Rename a variable for better readability.

Signed-off-by: Thomas Maier <balagi@justmail.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 8a73a05..f2904f6 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -82,7 +82,7 @@ #define ZONE(sector, pd) (((sector) + (p
 
 static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
 static struct proc_dir_entry *pkt_proc;
-static int pkt_major;
+static int pktdev_major;
 static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
 static mempool_t *psd_pool;
 
@@ -2476,7 +2476,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 	init_waitqueue_head(&pd->wqueue);
 	pd->bio_queue = RB_ROOT;
 
-	disk->major = pkt_major;
+	disk->major = pktdev_major;
 	disk->first_minor = idx;
 	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE;
@@ -2625,13 +2625,13 @@ static int __init pkt_init(void)
 	if (!psd_pool)
 		return -ENOMEM;
 
-	ret = register_blkdev(pkt_major, DRIVER_NAME);
+	ret = register_blkdev(pktdev_major, DRIVER_NAME);
 	if (ret < 0) {
 		printk(DRIVER_NAME": Unable to register block device\n");
 		goto out2;
 	}
-	if (!pkt_major)
-		pkt_major = ret;
+	if (!pktdev_major)
+		pktdev_major = ret;
 
 	ret = misc_register(&pkt_misc);
 	if (ret) {
@@ -2646,7 +2646,7 @@ static int __init pkt_init(void)
 	return 0;
 
 out:
-	unregister_blkdev(pkt_major, DRIVER_NAME);
+	unregister_blkdev(pktdev_major, DRIVER_NAME);
 out2:
 	mempool_destroy(psd_pool);
 	return ret;
@@ -2656,7 +2656,7 @@ static void __exit pkt_exit(void)
 {
 	remove_proc_entry(DRIVER_NAME, proc_root_driver);
 	misc_deregister(&pkt_misc);
-	unregister_blkdev(pkt_major, DRIVER_NAME);
+	unregister_blkdev(pktdev_major, DRIVER_NAME);
 	mempool_destroy(psd_pool);
 }
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
