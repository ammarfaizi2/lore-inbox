Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262440AbSJTMAu>; Sun, 20 Oct 2002 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSJTMAu>; Sun, 20 Oct 2002 08:00:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9975 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262440AbSJTMAt>; Sun, 20 Oct 2002 08:00:49 -0400
Date: Sun, 20 Oct 2002 14:06:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: sailer@ife.ee.ethz.ch
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] fix kbuild breakage in drivers/net/hamradio/soundmodem
Message-ID: <Pine.NEB.4.44.0210201353150.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/net/hamradio/soundmodem/Makefile includes the following:

<--  snip  -->

...
$(obj)/sm_tbl_%: $(obj)/gentbl
        $(obj)/gentbl

<--  snip  -->

gentbl is a program that generates some header files. The recent kbuild
changes have the "interesting" effect that this now outputs the header
files to the root directory of the kernel tree instead of
drivers/net/hamradio/soundmodem ...

The following patch fixes this breakage:

--- linux-2.5.44-full/drivers/net/hamradio/soundmodem/Makefile.old	2002-10-20 13:58:47.000000000 +0200
+++ linux-2.5.44-full/drivers/net/hamradio/soundmodem/Makefile	2002-10-20 13:59:04.000000000 +0200
@@ -38,5 +38,5 @@
 $(obj)/sm_fsk9600.o:    $(obj)/sm_tbl_fsk9600.h

 $(obj)/sm_tbl_%: $(obj)/gentbl
-	$(obj)/gentbl
+	cd $(obj) && ./gentbl


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed





