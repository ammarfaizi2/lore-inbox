Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWJIUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWJIUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWJIUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:23:59 -0400
Received: from assei2bl6.telenet-ops.be ([195.130.133.69]:37302 "EHLO
	assei2bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964818AbWJIUX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:23:58 -0400
Date: Mon, 9 Oct 2006 22:23:56 +0200
Message-Id: <200610092023.k99KNurB031487@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 625] m68k/Apollo: Remove obsolete arch/m68k/apollo/dma.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused arch/m68k/apollo/dma.c, which was obsoleted by the move to the
generic DMA API.

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 dma.c |   50 --------------------------------------------------
 1 file changed, 50 deletions(-)

--- linux-2.6.18/arch/m68k/apollo/dma.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.18/arch/m68k/apollo/dma.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,50 +0,0 @@
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/kd.h>
-#include <linux/tty.h>
-#include <linux/console.h>
-
-#include <asm/setup.h>
-#include <asm/bootinfo.h>
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/apollodma.h>
-#include <asm/io.h>
-
-/* note only works for 16 Bit 1 page DMA's */
-
-static unsigned short next_free_xlat_entry=0;
-
-unsigned short dma_map_page(unsigned long phys_addr,int count,int type) {
-
-	unsigned long page_aligned_addr=phys_addr & (~((1<<12)-1));
-	unsigned short start_map_addr=page_aligned_addr >> 10;
-	unsigned short free_xlat_entry, *xlat_map_entry;
-	int i;
-
-	free_xlat_entry=next_free_xlat_entry;
-	for(i=0,xlat_map_entry=addr_xlat_map+(free_xlat_entry<<2);i<8;i++,xlat_map_entry++) {
-#if 0
-		printk("phys_addr: %x, page_aligned_addr: %x, start_map_addr: %x\n",phys_addr,page_aligned_addr,start_map_addr+i);
-#endif
-		out_be16(xlat_map_entry, start_map_addr+i);
-	}
-
-	next_free_xlat_entry+=2;
-	if(next_free_xlat_entry>125)
-		next_free_xlat_entry=0;
-
-#if 0
-	printk("next_free_xlat_entry: %d\n",next_free_xlat_entry);
-#endif
-
-	return free_xlat_entry<<10;
-}
-
-void dma_unmap_page(unsigned short dma_addr) {
-
-	return ;
-
-}
-

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
