Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266530AbRGLT3d>; Thu, 12 Jul 2001 15:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266531AbRGLT3X>; Thu, 12 Jul 2001 15:29:23 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:49166 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S266530AbRGLT3S>; Thu, 12 Jul 2001 15:29:18 -0400
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfat: attempt to access beyond end of device
In-Reply-To: <20010712141653.A483@c239-1.fem.tu-ilmenau.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 13 Jul 2001 04:29:02 +0900
In-Reply-To: <20010712141653.A483@c239-1.fem.tu-ilmenau.de>
Message-ID: <87hewi2bgh.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This bug will be fixed by the following change.

diff -urN linux-2.4.7-pre6.orig/fs/fat/inode.c linux-2.4.7-pre6/fs/fat/inode.c
--- linux-2.4.7-pre6.orig/fs/fat/inode.c	Tue Jun 12 11:15:27 2001
+++ linux-2.4.7-pre6/fs/fat/inode.c	Fri Jul 13 04:20:04 2001
@@ -842,7 +842,7 @@
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
-	int i_pos;
+	unsigned int i_pos;
 
 retry:
 	i_pos = MSDOS_I(inode)->i_location;


But, should change ino/i_location/i_pos to unsigned long in
fat/vfat/msdos/umsdos, IMHO.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

