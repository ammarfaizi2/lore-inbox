Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVHHWb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHHWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVHHWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:48 -0400
Received: from coderock.org ([193.77.147.115]:44419 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932308AbVHHWbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:31:21 -0400
Message-Id: <20050808223032.262613000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:45 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Michael Veeck <michael.veeck@gmx.net>,
       Maximilian Attems <janitor@sternwelten.at>, domen@coderock.org
Subject: [patch 09/16] sh: bigsur/io: minmax-removal
Content-Disposition: inline; filename=min-max-arch_sh_boards_bigsur_io.patch
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

Index: quilt/arch/sh/boards/bigsur/io.c
===================================================================
--- quilt.orig/arch/sh/boards/bigsur/io.c
+++ quilt/arch/sh/boards/bigsur/io.c
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
+	for (port = max_t(u32, baseport, BIGSUR_IOMAP_LO_THRESH);
 	     port < endport && port < BIGSUR_IOMAP_HI_THRESH ;
 	     port += (1<<BIGSUR_IOMAP_HI_SHIFT)) {
 	    	pr_debug("    maphi[0x%x] = 0x%08x\n", port, addr);
@@ -80,7 +76,7 @@ void bigsur_port_unmap(u32 baseport, u32
 		bigsur_iomap_lo[port>>BIGSUR_IOMAP_LO_SHIFT] = 0;
 	}
 
-	for (port = MAX(baseport, BIGSUR_IOMAP_LO_THRESH) ;
+	for (port = max_t(u32, baseport, BIGSUR_IOMAP_LO_THRESH);
 	     port < endport && port < BIGSUR_IOMAP_HI_THRESH ;
 	     port += (1<<BIGSUR_IOMAP_HI_SHIFT)) {
 		bigsur_iomap_hi[port>>BIGSUR_IOMAP_HI_SHIFT] = 0;

--
