Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSLKMnx>; Wed, 11 Dec 2002 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbSLKMnx>; Wed, 11 Dec 2002 07:43:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6106 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266986AbSLKMnv>; Wed, 11 Dec 2002 07:43:51 -0500
Date: Wed, 11 Dec 2002 13:51:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21-pre1 compile failure: drivers/net/pcmcia/fmvj18x_cs.c
Message-ID: <20021211125133.GU17522@fs.tum.de>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <3DF7075E.CB1C7201@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF7075E.CB1C7201@eyal.emu.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 08:37:34PM +1100, Eyal Lebedinsky wrote:
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=fmvj18x_cs  -c -o
> fmvj18x_cs.o fmvj18x_cs.c
> fmvj18x_cs.c: In function `fmvj18x_config':
> fmvj18x_cs.c:489: `PRODID_TDK_GN3410' undeclared (first use in this
> function)
> fmvj18x_cs.c:489: (Each undeclared identifier is reported only once
> fmvj18x_cs.c:489: for each function it appears in.)
> fmvj18x_cs.c:529: `MANFID_UNGERMANN' undeclared (first use in this
> function)
> make[3]: *** [fmvj18x_cs.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/net/pcmcia'
>...

The pcmcia networking updates that came from -ac didn't include the 
changes to ciscode.h. The patch below (stolen from -ac) fixes this 
problem.

cu
Adrian

--- linux.vanilla/include/pcmcia/ciscode.h	2001-12-21 17:42:04.000000000 +0000
+++ linux.20-ac1/include/pcmcia/ciscode.h	2002-11-15 16:42:06.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * ciscode.h 1.48 2001/08/24 12:16:12
+ * ciscode.h 1.57 2002/11/03 20:38:14
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -60,6 +60,10 @@
 #define PRODID_INTEL_DUAL_RS232		0x0301
 #define PRODID_INTEL_2PLUS		0x8422
 
+#define MANFID_KME			0x0032
+#define PRODID_KME_KXLC005_A		0x0704
+#define PRODID_KME_KXLC005_B		0x2904
+
 #define MANFID_LINKSYS			0x0143
 #define PRODID_LINKSYS_PCMLM28		0xc0ab
 #define PRODID_LINKSYS_3400		0x3341
@@ -94,6 +98,8 @@
 #define PRODID_OSITECH_JACK_336		0x0007
 #define PRODID_OSITECH_SEVEN		0x0008
 
+#define MANFID_OXSEMI			0x0279
+
 #define MANFID_PIONEER			0x000b
 
 #define MANFID_PSION			0x016c
@@ -103,6 +109,7 @@
 #define PRODID_QUATECH_SPP100		0x0003
 #define PRODID_QUATECH_DUAL_RS232	0x0012
 #define PRODID_QUATECH_DUAL_RS232_D1	0x0007
+#define PRODID_QUATECH_DUAL_RS232_D2	0x0052
 #define PRODID_QUATECH_QUAD_RS232	0x001b
 #define PRODID_QUATECH_DUAL_RS422	0x000e
 #define PRODID_QUATECH_QUAD_RS422	0x0045
@@ -120,9 +127,12 @@
 
 #define MANFID_TDK			0x0105
 #define PRODID_TDK_CF010		0x0900
+#define PRODID_TDK_GN3410		0x4815
 
 #define MANFID_TOSHIBA			0x0098
 
+#define MANFID_UNGERMANN		0x02c0
+
 #define MANFID_XIRCOM			0x0105
 
 #endif /* _LINUX_CISCODE_H */


