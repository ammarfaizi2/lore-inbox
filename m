Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262004AbSIYP1M>; Wed, 25 Sep 2002 11:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbSIYP1L>; Wed, 25 Sep 2002 11:27:11 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:28389 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262004AbSIYP1I>; Wed, 25 Sep 2002 11:27:08 -0400
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.38 fs/partitions/check.c
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Wed, 25 Sep 2002 17:32:00 +0200
Message-ID: <878z1qjdan.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when building 2.5.38, I get the following error:

  gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/usr/src/kernel/v2.5.38/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/usr/src/kernel/v2.5.38/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=check   -c -o check.o check.c
check.c: In function `devfs_create_cdrom':
check.c:365: `devfs_handle' undeclared (first use in this function)
check.c:365: (Each undeclared identifier is reported only once
check.c:365: for each function it appears in.)

I don't know, wether this patch is correct, but at least it lets me
compile and run UML 2.5.38

Regards, Olaf.

diff -urN a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Wed Sep 25 15:52:01 2002
+++ b/fs/partitions/check.c	Wed Sep 25 16:19:41 2002
@@ -288,6 +288,7 @@
 static struct unique_numspace disc_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
 static devfs_handle_t cdroms;
 static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
+static devfs_handle_t devfs_handle;
 #endif
 
 static void devfs_create_partitions(struct gendisk *dev)
@@ -297,7 +298,6 @@
 	devfs_handle_t dir, slave;
 	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
-	static devfs_handle_t devfs_handle;
 	int part, max_p = 1<<dev->minor_shift;
 	struct hd_struct *p = dev->part;
 
