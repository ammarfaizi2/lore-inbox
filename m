Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTDTXe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTDTXe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:34:27 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30217 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263732AbTDTXeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:34:25 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kpfleming@cox.net (Kevin P. Fleming), linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 oops booting with initrd
In-Reply-To: <3EA22FDD.6010109@cox.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E197OVO-0008VR-00@gondolin.me.apana.org.au>
Date: Mon, 21 Apr 2003 09:45:54 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming <kpfleming@cox.net> wrote:
> Very small and simple kernel configuration (includes devfs, which is 
> where this problem came from), using Etherboot to load it along with a 
> small (768K) initrd.

> Call Trace:
>  [<c0114000>] default_wake_function+0x0/0x20
>  [<c01099cc>] __down_failed+0x8/0xc
>  [<c01772d9>] .text.lock.util+0x55/0x7c

This should fix it.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: fs/partitions/check.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/partitions/check.c,v
retrieving revision 1.1.1.8
retrieving revision 1.6
diff -u -r1.1.1.8 -r1.6
--- fs/partitions/check.c	7 Apr 2003 17:32:48 -0000	1.1.1.8
+++ fs/partitions/check.c	13 Apr 2003 00:15:54 -0000	1.6
@@ -414,7 +414,8 @@
 	unlink_gendisk(disk);
 	disk_stat_set_all(disk, 0);
 	disk->stamp = disk->stamp_idle = 0;
-	devfs_remove_partitions(disk);
+	if (disk->minors != 1)
+		devfs_remove_partitions(disk);
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
