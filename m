Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbTADEEG>; Fri, 3 Jan 2003 23:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbTADEEG>; Fri, 3 Jan 2003 23:04:06 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:29192 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266660AbTADEEF>; Fri, 3 Jan 2003 23:04:05 -0500
Date: Sat, 4 Jan 2003 15:12:19 +1100
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 INITRD + DEVFS crash
Message-ID: <20030104041219.GA3066@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

INITRD loading fails when DEVFS is enabled in the kernel as initrd_release
calls del_gendisk which tries to free DEVFS partitions even though the
create partitions function was never called.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: fs/partitions/check.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/partitions/check.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 check.c
--- fs/partitions/check.c	3 Jan 2003 01:36:55 -0000	1.1.1.3
+++ fs/partitions/check.c	4 Jan 2003 04:04:05 -0000
@@ -522,7 +522,8 @@
 	disk->io_ticks = 0;
 	disk->time_in_queue = 0;
 	disk->stamp = disk->stamp_idle = 0;
-	devfs_remove_partitions(disk);
+	if (disk->minors != 1)
+		devfs_remove_partitions(disk);
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");

--/04w6evG8XlLl3ft--
