Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423201AbWCXG4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423201AbWCXG4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423202AbWCXG4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:56:30 -0500
Received: from h139-142-50-161.gtconnect.net ([139.142.50.161]:15521 "EHLO
	quartz.orcorp.ca") by vger.kernel.org with ESMTP id S1423201AbWCXG43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:56:29 -0500
Date: Thu, 23 Mar 2006 23:56:19 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo causing bad mode of /initrd.image
Message-ID: <20060324065619.GA24390@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that after boot with an initrd in 2.6.16 the rootfs had:

--w-r-xr-T    1 root     root      6241141 Jan  1  1970 initrd.image

Which is caused by a small typo:

diff --git a/init/initramfs.c b/init/initramfs.c
index 637344b..f6fcc60 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -518,7 +518,7 @@ void __init populate_rootfs(void)
 			return;
 		}
 		printk("it isn't (%s); looks like an initrd\n", err);
-		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 700);
+		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 0700);
 		if (fd >= 0) {
 			sys_write(fd, (char *)initrd_start,
 					initrd_end - initrd_start);
