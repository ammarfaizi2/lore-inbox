Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbSLIV24>; Mon, 9 Dec 2002 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSLIV24>; Mon, 9 Dec 2002 16:28:56 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:21549 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S266257AbSLIV2y>; Mon, 9 Dec 2002 16:28:54 -0500
Date: Mon, 9 Dec 2002 16:36:25 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@connectiva.com.br, "" <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.20 compile fix for drivers/scsi/in2000.c
Message-ID: <Pine.LNX.4.50L0.0212091613530.24225-100000@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon    -nostdinc -iwithprefix include -DKBUILD_BASENAME=in2000  
-c -o in2000.o in2000.c
in2000.c:1919: base_tab causes a section type conflict
in2000.c:1926: int_tab causes a section type conflict
make[3]: *** [in2000.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make: *** [_dir_drivers] Error 2



diff -Naur linux-2.4.20/drivers/scsi/in2000.c linux-2.4.20-new/drivers/scsi/in2000.c
--- linux-2.4.20/drivers/scsi/in2000.c	2001-09-30 15:26:07.000000000 -0400
+++ linux-2.4.20-new/drivers/scsi/in2000.c	2002-12-09 12:13:42.000000000 -0500
@@ -1916,14 +1916,14 @@
    0
    };
 
-static const unsigned short base_tab[] in2000__INITDATA = {
+static unsigned short base_tab[] in2000__INITDATA = {
    0x220,
    0x200,
    0x110,
    0x100,
    };
 
-static const int int_tab[] in2000__INITDATA = {
+static int int_tab[] in2000__INITDATA = {
    15,
    14,
    11,
