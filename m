Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbUKTEW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUKTEW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUKTCmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:42:02 -0500
Received: from baikonur.stro.at ([213.239.196.228]:10408 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263076AbUKTCgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:36:07 -0500
Subject: [patch 4/4]  minmax-removal 	arch/sh/cchips/hd6446x/hd64465/io.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       michael.veeck@gmx.net
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:36:04 +0100
Message-ID: <E1CVL6a-0001tU-Jr@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Patch (against 2.6.8.1) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Since I dont have the hardware those patches are not tested.

Best regards
Veeck

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/arch/sh/cchips/hd6446x/hd64465/io.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/sh/cchips/hd6446x/hd64465/io.c~min-max-arch_sh_cchips_hd6446x_hd64465_io arch/sh/cchips/hd6446x/hd64465/io.c
--- linux-2.6.10-rc2-bk4/arch/sh/cchips/hd6446x/hd64465/io.c~min-max-arch_sh_cchips_hd6446x_hd64465_io	2004-11-19 17:15:23.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/sh/cchips/hd6446x/hd64465/io.c	2004-11-19 17:15:23.000000000 +0100
@@ -48,10 +48,6 @@ static unsigned char	hd64465_iomap_lo_sh
 static unsigned long	hd64465_iomap_hi[HD64465_IOMAP_HI_NMAP];
 static unsigned char	hd64465_iomap_hi_shift[HD64465_IOMAP_HI_NMAP];
 
-#ifndef MAX
-#define MAX(a,b)    ((a)>(b)?(a):(b))
-#endif
-
 #define PORT2ADDR(x) (sh_mv.mv_isa_port2addr(x))
 
 void hd64465_port_map(unsigned short baseport, unsigned int nports,
@@ -71,7 +67,7 @@ void hd64465_port_map(unsigned short bas
 	    addr += (1<<(HD64465_IOMAP_LO_SHIFT));
 	}
 
-	for (port = MAX(baseport, HD64465_IOMAP_LO_THRESH) ;
+	for (port = max_t(unsigned int, baseport, HD64465_IOMAP_LO_THRESH);
 	     port < endport && port < HD64465_IOMAP_HI_THRESH ;
 	     port += (1<<HD64465_IOMAP_HI_SHIFT)) {
 	    DPRINTK("    maphi[0x%x] = 0x%08lx\n", port, addr);
@@ -95,7 +91,7 @@ void hd64465_port_unmap(unsigned short b
     	    hd64465_iomap_lo[port>>HD64465_IOMAP_LO_SHIFT] = 0;
 	}
 
-	for (port = MAX(baseport, HD64465_IOMAP_LO_THRESH) ;
+	for (port = max_t(unsigned int, baseport, HD64465_IOMAP_LO_THRESH);
 	     port < endport && port < HD64465_IOMAP_HI_THRESH ;
 	     port += (1<<HD64465_IOMAP_HI_SHIFT)) {
     	    hd64465_iomap_hi[port>>HD64465_IOMAP_HI_SHIFT] = 0;
_
