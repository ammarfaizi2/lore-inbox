Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbUBBUnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUBBT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:59:28 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:14969 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265919AbUBBT7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:59:05 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:59:03 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 30/42]
Message-ID: <20040202195903.GD6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


meye.c:212: warning: passing arg 3 of `dma_alloc_coherent' from incompatible pointer type

dma_addr_t is not u32!

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/media/video/meye.c linux-2.4/drivers/media/video/meye.c
--- linux-2.4-vanilla/drivers/media/video/meye.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/drivers/media/video/meye.c	Sat Jan 31 18:27:19 2004
@@ -190,7 +190,7 @@
 
 /* return a page table pointing to N pages of locked memory */
 static int ptable_alloc(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
@@ -204,7 +204,7 @@
 		return -1;
 	}
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		meye.mchip_ptable[i] = dma_alloc_coherent(meye.mchip_dev, 
 							  PAGE_SIZE,
@@ -212,7 +212,7 @@
 							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
-			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+			pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 			for (j = 0; j < i; ++j) {
 				dma_free_coherent(meye.mchip_dev,
 						  PAGE_SIZE,
@@ -228,10 +228,10 @@
 }
 
 static void ptable_free(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
 			dma_free_coherent(meye.mchip_dev, 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il dottore mi ha detto di smettere di fare cene intime per quattro.
A meno che non ci siamo altre tre persone.
