Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVHHWa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVHHWa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVHHWa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:30:58 -0400
Received: from coderock.org ([193.77.147.115]:36995 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932310AbVHHWaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:55 -0400
Message-Id: <20050808223033.449331000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:46 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Michael Veeck <michael.veeck@gmx.net>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 10/16] sh: hd64465: minmax-removal
Content-Disposition: inline; filename=min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Veeck <michael.veeck@gmx.net>



Patch removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 io.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

Index: quilt/arch/sh/cchips/hd6446x/hd64465/io.c
===================================================================
--- quilt.orig/arch/sh/cchips/hd6446x/hd64465/io.c
+++ quilt/arch/sh/cchips/hd6446x/hd64465/io.c
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

--
