Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbSKWApi>; Fri, 22 Nov 2002 19:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbSKWApi>; Fri, 22 Nov 2002 19:45:38 -0500
Received: from p508B6AB2.dip.t-dialin.net ([80.139.106.178]:13004 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S266285AbSKWApi>; Fri, 22 Nov 2002 19:45:38 -0500
Date: Sat, 23 Nov 2002 01:52:40 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] do_mounts.c ioctl fix
Message-ID: <20021123015240.B30919@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

init/do_mounts.c is using the BLKGETSIZE ioctl which expects a pointer to
an unsigned long but actually it passes a pointer to an int which of
course is blowing up on 64-bit systems.

  Ralf

Index: init/do_mounts.c
===================================================================
RCS file: /home/cvs/linux/init/do_mounts.c,v
retrieving revision 1.16
diff -u -r1.16 do_mounts.c
--- init/do_mounts.c	5 Nov 2002 15:18:24 -0000	1.16
+++ init/do_mounts.c	23 Nov 2002 00:48:12 -0000
@@ -488,7 +595,8 @@
 
 #ifdef CONFIG_BLK_DEV_RAM
 	int in_fd, out_fd;
-	int nblocks, rd_blocks, devblocks, i;
+	unsigned long rd_blocks, devblocks;
+	int nblocks, i;
 	char *buf;
 	unsigned short rotate = 0;
 #if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
