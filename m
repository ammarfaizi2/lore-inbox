Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTI1NMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTI1NKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:10:23 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:27480 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262555AbTI1NIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:08:46 -0400
Date: Sun, 28 Sep 2003 14:55:18 +0200
Message-Id: <200309281255.h8SCtIcG005480@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 300] Sun-3 bootmem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: Use init_bootmem_node() instead of init_bootmem() for Sun-3, to avoid
setting min/max_low_pfn in init_bootmem(). This was screwing up SCSI, and the
new method is more like m68k/motorola. (from Sam Creasey)

--- linux-2.6.0-test6/arch/m68k/sun3/config.c	Tue May 27 19:02:33 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/sun3/config.c	Mon Sep  1 13:50:04 2003
@@ -129,7 +129,7 @@
 	high_memory = (void *)memory_end;
 	availmem = memory_start;
 
-	availmem += init_bootmem(start_page, num_pages);
+	availmem += init_bootmem_node(NODE_DATA(0), start_page, 0, num_pages);
 	availmem = (availmem + (PAGE_SIZE-1)) & PAGE_MASK;
 
 	free_bootmem(__pa(availmem), memory_end - (availmem));

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
