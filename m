Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVFKUPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVFKUPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVFKUPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:15:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261813AbVFKUOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:14:50 -0400
Date: Sat, 11 Jun 2005 22:14:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix compile errors and warning after devfs removal patches
Message-ID: <20050611201444.GM3770@stusta.de>
References: <20050611074327.GA27785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611074327.GA27785@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes three compile errors and one compile warning after 
applying the devfs removal patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-tape.c |    1 -
 drivers/md/md.c        |    1 -
 init/do_mounts_md.c    |    2 +-
 init/do_mounts_rd.c    |    4 ++--
 4 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc6-mm1-full/init/do_mounts_rd.c.old	2005-06-11 20:18:09.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/init/do_mounts_rd.c	2005-06-11 20:19:14.000000000 +0200
@@ -262,8 +262,8 @@
 {
 	if (rd_prompt)
 		change_floppy("root floppy disk to be loaded into RAM disk");
-	create_dev("/dev/root", ROOT_DEV, root_device_name);
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n), NULL);
+	create_dev("/dev/root", ROOT_DEV);
+	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
 	return rd_load_image("/dev/root");
 }
 
--- linux-2.6.12-rc6-mm1-full/init/do_mounts_md.c.old	2005-06-11 20:20:08.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/init/do_mounts_md.c	2005-06-11 20:20:17.000000000 +0200
@@ -275,7 +275,7 @@
 
 void __init md_run_setup(void)
 {
-	create_dev("/dev/md0", MKDEV(MD_MAJOR, 0), "md/0");
+	create_dev("/dev/md0", MKDEV(MD_MAJOR, 0));
 	if (raid_noautodetect)
 		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
 	else {
--- linux-2.6.12-rc6-mm1-full/drivers/ide/ide-tape.c.old	2005-06-11 20:41:08.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/ide/ide-tape.c	2005-06-11 20:42:00.000000000 +0200
@@ -4875,7 +4875,6 @@
 
 	idetape_setup(drive, tape, minor);
 
-	g->number = -1;
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
--- linux-2.6.12-rc6-mm1-full/drivers/md/md.c.old	2005-06-11 20:48:07.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/md/md.c	2005-06-11 20:49:16.000000000 +0200
@@ -3947,7 +3947,6 @@
 {
 	mddev_t *mddev;
 	struct list_head *tmp;
-	int i;
 	blk_unregister_region(MKDEV(MAJOR_NR,0), MAX_MD_DEVS);
 	blk_unregister_region(MKDEV(mdp_major,0), MAX_MD_DEVS << MdpMinorShift);
 

