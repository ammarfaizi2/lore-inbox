Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137077AbREKI0K>; Fri, 11 May 2001 04:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137078AbREKI0B>; Fri, 11 May 2001 04:26:01 -0400
Received: from hood.tvd.be ([195.162.196.21]:36494 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S137077AbREKIZs>;
	Fri, 11 May 2001 04:25:48 -0400
Date: Fri, 11 May 2001 10:24:13 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-parport@torque.net
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] parport_pc_init_superio()
Message-ID: <Pine.LNX.4.05.10105111021570.1624-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone forgot to update parport_pc_init_superio() for CONFIG_PCI=n (found by
Richard Zidlicky, IIRC).

Patches against Linus' 2.4.5-pre1 and Alan's 2.4.4-ac6 below.

diff -urN linux-2.4.5-pre1/drivers/parport/parport_pc.c linux-m68k-2.4.5-pre1/drivers/parport/parport_pc.c
--- linux-2.4.5-pre1/drivers/parport/parport_pc.c	Sat Apr 28 20:21:49 2001
+++ linux-m68k-2.4.5-pre1/drivers/parport/parport_pc.c	Wed May  2 08:23:08 2001
@@ -2576,7 +2576,7 @@
 }
 #else
 static struct pci_driver parport_pc_pci_driver;
-static int __init parport_pc_init_superio(void) {return 0;}
+static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
 #endif /* CONFIG_PCI */
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */

--- linux-2.4.4-ac6/drivers/parport/parport_pc.c	Wed May  9 09:20:02 2001
+++ m68k-2.4.4-ac6/drivers/parport/parport_pc.c	Fri May 11 10:16:37 2001
@@ -2718,7 +2718,7 @@
 
 #else
 static struct pci_driver parport_pc_pci_driver;
-static int __init parport_pc_init_superio(void) {return 0;}
+static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
 #endif
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

