Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSFDJTZ>; Tue, 4 Jun 2002 05:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSFDJTY>; Tue, 4 Jun 2002 05:19:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:24537 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317463AbSFDJTX>; Tue, 4 Jun 2002 05:19:23 -0400
Date: Tue, 4 Jun 2002 11:19:19 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <bcollins@debian.org>,
        <andreas.bombe@munich.netsurf.de>,
        <linux1394-devel@lists.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: [patch] disable CONFIG_IEEE1394_PCILYNX_PORTS config option
Message-ID: <Pine.NEB.4.44.0206041108400.8847-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

IMHO it gives a bad picture of the quality of Linux if a stable kernel
contains options that doesn't compile. CONFIG_IEEE1394_PCILYNX_PORTS
doesn't compile (the error message is at the end of the mail) and Andreas
Bombe stated in a private mail to me four months ago that it shouldn't
have been a public option.

My patch doesn't do any harm because currently the kernel doesn't compile
when this option is enabled and if someone fixes pcilynx.c it's pretty
trivial to revert this patch.



--- drivers/ieee1394/Config.in.old	Fri May  3 11:11:06 2002
+++ drivers/ieee1394/Config.in	Fri May  3 11:12:18 2002
@@ -12,7 +12,7 @@
 	dep_tristate '  Texas Instruments PCILynx support' CONFIG_IEEE1394_PCILYNX $CONFIG_IEEE1394
 	if [ "$CONFIG_IEEE1394_PCILYNX" != "n" ]; then
 	    bool '    Use PCILynx local RAM' CONFIG_IEEE1394_PCILYNX_LOCALRAM
-	    bool '    Support for non-IEEE1394 local ports' CONFIG_IEEE1394_PCILYNX_PORTS
+#	    bool '    Support for non-IEEE1394 local ports' CONFIG_IEEE1394_PCILYNX_PORTS
 	fi
 	dep_tristate '  OHCI-1394 support' CONFIG_IEEE1394_OHCI1394 $CONFIG_IEEE1394





TIA
Adrian



<--  snip  -->

gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=pcilynx  -c -o pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:647: `num_of_cards' undeclared (first use in this function)
pcilynx.c:647: (Each undeclared identifier is reported only once
pcilynx.c:647: for each function it appears in.)
pcilynx.c:647: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:706: `cards' undeclared (first use in this function)
make[3]: *** [pcilynx.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-full/drivers/ieee1394'

<--  snip  -->

