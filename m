Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbTC0NIq>; Thu, 27 Mar 2003 08:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTC0NIq>; Thu, 27 Mar 2003 08:08:46 -0500
Received: from mario.gams.at ([194.42.96.10]:18490 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S262545AbTC0NIq> convert rfc822-to-8bit;
	Thu, 27 Mar 2003 08:08:46 -0500
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: Fix compile error in fs/cramfs/inode.c in 2.5.66
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 27 Mar 2003 14:19:59 +0100
Message-ID: <12120.1048771199@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cramfs does not compile without it.

	Bernd

--- fs/cramfs/inode.c-orig	Thu Mar 27 14:17:22 2003
+++ fs/cramfs/inode.c	Thu Mar 27 13:47:56 2003
@@ -51,7 +51,9 @@
 		inode->i_blocks = (cramfs_inode->size - 1) / 512 + 1;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_gid = cramfs_inode->gid;
-		inode->i_mtime = inode->i_atime = inode->i_ctime = 0;
+		inode->i_mtime.tv_sec = inode->i_mtime.tv_nsec = 
+			inode->i_atime.tv_sec = inode->i_atime.tv_nsec = 
+			inode->i_ctime.tv_sec = inode->i_ctime.tv_nsec = 0;
 		inode->i_ino = CRAMINO(cramfs_inode);
 		/* inode->i_nlink is left 1 - arguably wrong for directories,
 		   but it's the best we can do without reading the directory

-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


