Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286501AbSABBUO>; Tue, 1 Jan 2002 20:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286519AbSABBUB>; Tue, 1 Jan 2002 20:20:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286517AbSABBTn>;
	Tue, 1 Jan 2002 20:19:43 -0500
Message-ID: <3C32602D.C52FF784@mandrakesoft.com>
Date: Tue, 01 Jan 2002 20:19:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: PATCH 2.5.2.6: fix umsdos build
Content-Type: multipart/mixed;
 boundary="------------04C128F80ED75A82C741EE1C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------04C128F80ED75A82C741EE1C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

add two calls to kdev_same
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------04C128F80ED75A82C741EE1C
Content-Type: text/plain; charset=us-ascii;
 name="umsdos-2.5.2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="umsdos-2.5.2.6.patch"

Index: fs/umsdos/inode.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/fs/umsdos/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- fs/umsdos/inode.c	2001/09/30 19:26:08	1.1.1.1
+++ fs/umsdos/inode.c	2002/01/02 01:16:13
@@ -49,7 +49,7 @@
 void UMSDOS_put_super (struct super_block *sb)
 {
 	Printk ((KERN_DEBUG "UMSDOS_put_super: entering\n"));
-	if (saved_root && pseudo_root && sb->s_dev == ROOT_DEV) {
+	if (saved_root && pseudo_root && kdev_same(sb->s_dev, ROOT_DEV)) {
 		shrink_dcache_parent(saved_root);
 		dput(saved_root);
 		saved_root = NULL;
@@ -414,7 +414,7 @@
 	 * must check like this, because we can be used with initrd
 	 */
 		
-	if (sb->s_dev != ROOT_DEV)
+	if (!kdev_same(sb->s_dev, ROOT_DEV))
 		goto out_noroot;
 
 	/* 

--------------04C128F80ED75A82C741EE1C--

