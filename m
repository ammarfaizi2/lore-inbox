Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVCXPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVCXPeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVCXPa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:30:59 -0500
Received: from geode.he.net ([216.218.230.98]:38416 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262839AbVCXP1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:27:55 -0500
From: ecashin@noserose.net
Message-Id: <1111678072.32016@geode.he.net>
Date: Thu, 24 Mar 2005 07:27:52 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [10/12]: Randy Dunlap: avoid warnings on sparc64
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton has already merged this patch.

Randy Dunlap: avoid warnings on sparc64

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-03-07 17:37:14.000000000 -0500
+++ b/drivers/block/aoe/aoeblk.c	2005-03-10 12:20:00.000000000 -0500
@@ -28,7 +28,8 @@ static ssize_t aoedisk_show_mac(struct g
 {
 	struct aoedev *d = disk->private_data;
 
-	return snprintf(page, PAGE_SIZE, "%012llx\n", mac_addr(d->addr));
+	return snprintf(page, PAGE_SIZE, "%012llx\n",
+			(unsigned long long)mac_addr(d->addr));
 }
 static ssize_t aoedisk_show_netif(struct gendisk * disk, char *page)
 {
@@ -241,7 +242,8 @@ aoeblk_gdalloc(void *vp)
 	aoedisk_add_sysfs(d);
 	
 	printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
-		"sectors\n", mac_addr(d->addr), d->aoemajor, d->aoeminor,
+		"sectors\n", (unsigned long long)mac_addr(d->addr),
+		d->aoemajor, d->aoeminor,
 		d->fw_ver, (long long)d->ssize);
 }
 


-- 
  Ed L. Cashin <ecashin@coraid.com>
