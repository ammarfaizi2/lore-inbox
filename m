Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJHP5I>; Tue, 8 Oct 2002 11:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSJHP5H>; Tue, 8 Oct 2002 11:57:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261242AbSJHP5F>; Tue, 8 Oct 2002 11:57:05 -0400
Date: Tue, 8 Oct 2002 18:02:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mitchell Blank Jr <mitch@sfgoth.com>,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix kbuild breakage in drivers/atm
Message-ID: <Pine.NEB.4.44.0210081752240.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kbuild changes in 2.5.41 caused the following compile error in
drivers/atm:

<--  snip  -->

...
make[2]: *** No rule to make target `pca200e_ecd.bin2', needed by
`drivers/atm/fore200e_pca_fw.c'.  Stop.
make[1]: *** [drivers/atm] Error 2

<--  snip  -->


The following patch fixes it:


--- linux-2.5.41-notac-full/drivers/atm/Makefile.old	2002-10-08 17:48:26.000000000 +0200
+++ linux-2.5.41-notac-full/drivers/atm/Makefile	2002-10-08 17:50:45.000000000 +0200
@@ -37,7 +37,7 @@
   endif
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
 #   guess the target endianess to choose the right PCA-200E firmware image
-    CONFIG_ATM_FORE200E_PCA_FW := $(shell if test -n "`$(CC) -E -dM ../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
+    CONFIG_ATM_FORE200E_PCA_FW := $(shell if test -n "`$(CC) -E -dM include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo drivers/atm/pca200e.bin; else echo drivers/atm/pca200e_ecd.bin2; fi)
   endif
 endif
 ifeq ($(CONFIG_ATM_FORE200E_SBA),y)





cu
Adrian

BTW:
There might be places in the kernel that are now broken without a compile
error, consider the second part of this line would output a compiler flag
instead of a file name.



