Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUBCXnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUBCXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:43:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:53225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266174AbUBCXni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:43:38 -0500
Date: Tue, 3 Feb 2004 15:36:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: stelian@popies.net, akpm <akpm@osdl.org>
Subject: [PATCH] meye: correct printk of dma_addr_t
Message-Id: <20040203153606.76442b9c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


description:	fix dma_addr_t type error with CONFIG_HIGHMEM64G=y;
product_versions: linux-262-rc3

diffstat:=
 drivers/media/video/meye.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naurp ./drivers/media/video/meye.c~meye_dma ./drivers/media/video/meye.c
--- ./drivers/media/video/meye.c~meye_dma	2004-01-08 22:59:44.000000000 -0800
+++ ./drivers/media/video/meye.c	2004-02-03 14:43:42.000000000 -0800
@@ -162,7 +162,7 @@ static void rvfree(void * mem, unsigned 
 
 /* return a page table pointing to N pages of locked memory */
 static int ptable_alloc(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
 	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
@@ -176,7 +176,7 @@ static int ptable_alloc(void) {
 		return -1;
 	}
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev, 
 							  PAGE_SIZE,
@@ -184,7 +184,7 @@ static int ptable_alloc(void) {
 							  GFP_KERNEL);
 		if (!meye.mchip_ptable[i]) {
 			int j;
-			pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+			pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 			for (j = 0; j < i; ++j) {
 				dma_free_coherent(&meye.mchip_dev->dev,
 						  PAGE_SIZE,
@@ -200,10 +200,10 @@ static int ptable_alloc(void) {
 }
 
 static void ptable_free(void) {
-	u32 *pt;
+	dma_addr_t *pt;
 	int i;
 
-	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
 	for (i = 0; i < MCHIP_NB_PAGES; i++) {
 		if (meye.mchip_ptable[i])
 			dma_free_coherent(&meye.mchip_dev->dev, 


--
~Randy
