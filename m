Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUJBRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUJBRCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJBRAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:00:42 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:22036
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S267400AbUJBRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:26 -0400
Date: Sat, 2 Oct 2004 19:00:23 +0200
Message-Id: <200410021700.i92H0NqB021167@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 489] minmax-removal arch/m68k/kernel/bios32.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k PCI: Removes unnecessary min/max macros and change calls to use kernel.h
macros instead.

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/arch/m68k/kernel/bios32.c	2004-08-24 14:17:47.000000000 +0200
+++ linux-m68k-2.6.9-rc3/arch/m68k/kernel/bios32.c	2004-09-10 20:20:25.000000000 +0200
@@ -46,8 +46,6 @@
 
 #define ALIGN(val,align)	(((val) + ((align) - 1)) & ~((align) - 1))
 
-#define MAX(val1, val2)		(((val1) > (val2)) ? val1 : val2)
-
 /*
  * Offsets relative to the I/O and memory base addresses from where resources
  * are allocated.
@@ -171,7 +169,7 @@ static void __init layout_dev(struct pci
 			 * Align to multiple of size of minimum base.
 			 */
 
-			alignto = MAX(0x040, size) ;
+			alignto = max_t(unsigned int, 0x040, size);
 			base = ALIGN(io_base, alignto);
 			io_base = base + size;
 			pci_write_config_dword(dev, reg, base | PCI_BASE_ADDRESS_SPACE_IO);
@@ -214,7 +212,7 @@ static void __init layout_dev(struct pci
 			 * Align to multiple of size of minimum base.
 			 */
 
-			alignto = MAX(0x1000, size) ;
+			alignto = max_t(unsigned int, 0x1000, size);
 			base = ALIGN(mem_base, alignto);
 			mem_base = base + size;
 			pci_write_config_dword(dev, reg, base);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
