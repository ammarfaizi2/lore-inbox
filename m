Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbUKTESh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUKTESh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUKTCmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:42:16 -0500
Received: from baikonur.stro.at ([213.239.196.228]:52613 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262849AbUKTCgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:36:04 -0500
Subject: [patch 3/4]  minmax-removal arch/sh/boards/bigsur/io.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       michael.veeck@gmx.net
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:36:00 +0100
Message-ID: <E1CVL6X-0001qL-5o@sputnik>
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

 linux-2.6.10-rc2-bk4-max/arch/sh/boards/bigsur/io.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff -puN arch/sh/boards/bigsur/io.c~min-max-arch_sh_boards_bigsur_io arch/sh/boards/bigsur/io.c
--- linux-2.6.10-rc2-bk4/arch/sh/boards/bigsur/io.c~min-max-arch_sh_boards_bigsur_io	2004-11-19 17:15:21.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/sh/boards/bigsur/io.c	2004-11-19 17:15:21.000000000 +0100
@@ -37,10 +37,6 @@ static u8 bigsur_iomap_lo_shift[BIGSUR_I
 static u32 bigsur_iomap_hi[BIGSUR_IOMAP_HI_NMAP];
 static u8 bigsur_iomap_hi_shift[BIGSUR_IOMAP_HI_NMAP];
 
-#ifndef MAX
-#define MAX(a,b)    ((a)>(b)?(a):(b))
-#endif
-
 void bigsur_port_map(u32 baseport, u32 nports, u32 addr, u8 shift)
 {
 	u32 port, endport = baseport + nports;
@@ -57,7 +53,7 @@ void bigsur_port_map(u32 baseport, u32 n
 	    	addr += (1<<(BIGSUR_IOMAP_LO_SHIFT));
 	}
 
-	for (port = MAX(baseport, BIGSUR_IOMAP_LO_THRESH) ;
+	for (port = max(baseport, BIGSUR_IOMAP_LO_THRESH);
 	     port < endport && port < BIGSUR_IOMAP_HI_THRESH ;
 	     port += (1<<BIGSUR_IOMAP_HI_SHIFT)) {
 	    	pr_debug("    maphi[0x%x] = 0x%08x\n", port, addr);
@@ -80,7 +76,7 @@ void bigsur_port_unmap(u32 baseport, u32
 		bigsur_iomap_lo[port>>BIGSUR_IOMAP_LO_SHIFT] = 0;
 	}
 
-	for (port = MAX(baseport, BIGSUR_IOMAP_LO_THRESH) ;
+	for (port = max(baseport, BIGSUR_IOMAP_LO_THRESH);
 	     port < endport && port < BIGSUR_IOMAP_HI_THRESH ;
 	     port += (1<<BIGSUR_IOMAP_HI_SHIFT)) {
 		bigsur_iomap_hi[port>>BIGSUR_IOMAP_HI_SHIFT] = 0;
_
