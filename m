Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSJTOiM>; Sun, 20 Oct 2002 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSJTOiM>; Sun, 20 Oct 2002 10:38:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22004 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262784AbSJTOiL>; Sun, 20 Oct 2002 10:38:11 -0400
Date: Sun, 20 Oct 2002 16:44:11 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dag Brattli <dag@brattli.net>, <jt@hpl.hp.com>,
       James McKenzie <james@fishsoup.dhs.org>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] allow only one Toshiba Type-O IR Port driver in the
 kernel
Message-ID: <Pine.NEB.4.44.0210201640090.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to compile both Toshiba Type-O IR Port drivers into the kernel
fails with the following error:

<--  snip  -->

...
   ld -m elf_i386  -r -o drivers/net/irda/built-in.o ...
drivers/net/irda/donauboe.o: In function `toshoboe_init':
drivers/net/irda/donauboe.o(.init.text+0x0): multiple definition of
`toshoboe_init'
drivers/net/irda/toshoboe.o(.init.text+0x0): first defined here
make[3]: *** [drivers/net/irda/built-in.o] Error 1

<--  snip  -->

The following patch allows the builing of the old driver only when the new
one isn't compiled into the kernel.

Additionally it indents three lines inside an if ... fi that weren't
indented.

--- linux-2.5.44-full/drivers/net/irda/Config.in.old	2002-10-20 14:37:54.000000000 +0200
+++ linux-2.5.44-full/drivers/net/irda/Config.in	2002-10-20 14:44:03.000000000 +0200
@@ -28,12 +28,14 @@
 dep_tristate 'IrDA USB dongles (EXPERIMENTAL)' CONFIG_USB_IRDA $CONFIG_IRDA $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate 'NSC PC87108/PC87338' CONFIG_NSC_FIR  $CONFIG_IRDA
 dep_tristate 'Winbond W83977AF (IR)' CONFIG_WINBOND_FIR $CONFIG_IRDA
-dep_tristate 'Toshiba Type-O IR Port (old driver)' CONFIG_TOSHIBA_OLD $CONFIG_IRDA
 dep_tristate 'Toshiba Type-O IR Port' CONFIG_TOSHIBA_FIR $CONFIG_IRDA
+if [ "$CONFIG_TOSHIBA_FIR" != "y" ]; then
+   dep_tristate 'Toshiba Type-O IR Port (old driver)' CONFIG_TOSHIBA_OLD $CONFIG_IRDA
+fi
 if [ "$CONFIG_EXPERIMENTAL" != "n" ]; then
-dep_tristate 'SMC IrCC (EXPERIMENTAL)' CONFIG_SMC_IRCC_FIR $CONFIG_IRDA
-dep_tristate 'ALi M5123 FIR (EXPERIMENTAL)' CONFIG_ALI_FIR $CONFIG_IRDA
-dep_tristate 'VLSI 82C147 SIR/MIR/FIR (EXPERIMENTAL)' CONFIG_VLSI_FIR $CONFIG_IRDA
+   dep_tristate 'SMC IrCC (EXPERIMENTAL)' CONFIG_SMC_IRCC_FIR $CONFIG_IRDA
+   dep_tristate 'ALi M5123 FIR (EXPERIMENTAL)' CONFIG_ALI_FIR $CONFIG_IRDA
+   dep_tristate 'VLSI 82C147 SIR/MIR/FIR (EXPERIMENTAL)' CONFIG_VLSI_FIR $CONFIG_IRDA
 fi
 if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
    dep_tristate 'SA1100 Internal IR' CONFIG_SA1100_FIR $CONFIG_IRDA

cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed



