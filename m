Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSLIVhQ>; Mon, 9 Dec 2002 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLIVhQ>; Mon, 9 Dec 2002 16:37:16 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:48685 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S266296AbSLIVhP>; Mon, 9 Dec 2002 16:37:15 -0500
Date: Mon, 9 Dec 2002 16:44:46 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, "" <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.20 compile fix for drivers/scsi/t128.c
Message-ID: <Pine.LNX.4.50L0.0212091638400.24225-100000@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon    -nostdinc -iwithprefix
include -DKBUILD_BASENAME=t128  -c -o t128.o t128.c
t128.c:148: signatures causes a section type conflict
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
make[3]: *** [t128.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make: *** [_dir_drivers] Error 2



diff -Naur linux-2.4.20/drivers/scsi/t128.c linux-2.4.20-new/drivers/scsi/t128.c
--- linux-2.4.20/drivers/scsi/t128.c	2001-12-21 12:41:55.000000000 -0500
+++ linux-2.4.20-new/drivers/scsi/t128.c	2002-12-09 12:52:21.000000000 -0500
@@ -142,7 +142,7 @@
 
 #define NO_BASES (sizeof (bases) / sizeof (struct base))
 
-static const struct signature {
+static struct signature {
 	const char *string;
 	int offset;
 } signatures[] __initdata = {
