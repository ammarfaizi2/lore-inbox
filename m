Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXEee>; Thu, 23 Nov 2000 23:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129632AbQKXEeP>; Thu, 23 Nov 2000 23:34:15 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:54791 "EHLO
        uberbox.mesatop.com") by vger.kernel.org with ESMTP
        id <S129153AbQKXEeI>; Thu, 23 Nov 2000 23:34:08 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] for ReiserFS 3.5.27 on 2.2.18pre23
Date: Thu, 23 Nov 2000 20:56:53 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00112320565300.01042@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those of you who may want to run ReiserFS
on 2.2.18pre23 using reiserfs-3.5.27,
you may find as I did that the main reiserfs patch,
linux-2.2.17-reiserfs-3.5.27-patch, fails like this:

patching file linux/include/linux/fs.h
Hunk #1 FAILED at 279.
Hunk #2 FAILED at 393.
Hunk #3 FAILED at 516.
Hunk #4 FAILED at 560.
4 out of 4 hunks FAILED -- saving rejects to file linux/include/linux/fs.h.rej

Here is a temporary fix. The following will patch linux/include/linux/fs.h 
correctly.  I am currently running 2.2.18pre23 with reiserfs 3.5.27 using 
this patch:

diff -u linux/include/linux/fs.h.orig linux/include/linux/fs.h
--- linux/include/linux/fs.h.orig       Thu Nov 23 18:25:10 2000
+++ linux/include/linux/fs.h    Thu Nov 23 18:38:15 2000
@@ -280,6 +280,7 @@
 #include <linux/adfs_fs_i.h>
 #include <linux/qnx4_fs_i.h>
 #include <linux/usbdev_fs_i.h>
+#include <linux/reiserfs_fs_i.h>

 /*
  * Attribute flags.  These should be or-ed together to figure out what
@@ -395,6 +396,7 @@
                struct adfs_inode_info          adfs_i;
                struct qnx4_inode_info          qnx4_i;
                struct usbdev_inode_info        usbdev_i;
+               struct reiserfs_inode_info      reiserfs_i;
                struct socket                   socket_i;
                void                            *generic_ip;
        } u;
@@ -520,6 +522,7 @@
 #include <linux/adfs_fs_sb.h>
 #include <linux/qnx4_fs_sb.h>
 #include <linux/usbdev_fs_sb.h>
+#include <linux/reiserfs_fs_sb.h>

 extern struct list_head super_blocks;

@@ -564,6 +567,7 @@
                struct adfs_sb_info     adfs_sb;
                struct qnx4_sb_info     qnx4_sb;
                struct usbdev_sb_info   usbdevfs_sb;
+               struct reiserfs_sb_info reiserfs_sb;
                void                    *generic_sbp;
        } u;
        /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
