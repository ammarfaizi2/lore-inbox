Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTCEXVk>; Wed, 5 Mar 2003 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTCEXVk>; Wed, 5 Mar 2003 18:21:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261857AbTCEXVi>;
	Wed, 5 Mar 2003 18:21:38 -0500
Date: Wed, 5 Mar 2003 17:08:08 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Douglas Gilbert <dougg@torque.net>
cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: sysfs mount point permissions in 2.5.64
In-Reply-To: <3E667068.4000204@torque.net>
Message-ID: <Pine.LNX.4.33.0303051706020.998-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Douglas Gilbert wrote:

> In lk 2.5.64 on my i386 box the sysfs mount point
> ( "/sys") changes permission from:
>    drwxr-xr-x
> to
>    drw-r--r--
> during the boot process. I didn't notice this feature
> in lk 2.5.63 . Chmodding the directory back to its former
> permissions get overridden by subsequent boot sequences.
> 
> This change in permissions inhibits non-root users from using
> utilities that scan sysfs for information (e.g. lsscsi).
> 
> Is this a feature or otherwise?

This is certainly not intended, and is entirely my fault. The patch below 
should fix it.

	-pat

===== fs/sysfs/mount.c 1.5 vs edited =====
--- 1.5/fs/sysfs/mount.c	Tue Mar  4 12:17:14 2003
+++ edited/fs/sysfs/mount.c	Wed Mar  5 17:06:25 2003
@@ -33,7 +33,7 @@
 	sb->s_op = &sysfs_ops;
 	sysfs_sb = sb;
 
-	inode = sysfs_new_inode(S_IFDIR | S_IRUGO | S_IWUSR);
+	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
 		inode->i_op = &simple_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;

