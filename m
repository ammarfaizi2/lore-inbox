Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTAEOoW>; Sun, 5 Jan 2003 09:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTAEOoW>; Sun, 5 Jan 2003 09:44:22 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:7401 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264797AbTAEOoV>;
	Sun, 5 Jan 2003 09:44:21 -0500
Date: Sun, 5 Jan 2003 15:52:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>, linux-parport@torque.net,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [PATCH] parport_pc and !CONFIG_PNP
Message-ID: <Pine.GSO.4.21.0301051548560.10519-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


parport_pc_pnp_driver is const if !CONFIG_PNP, while pnp_register_driver()
takes a non-const pointer as parameter.

An alternative fix is to change the prototype of the dummy
pnp_register_driver(), but this may affect other drivers.

--- linux-2.5.54/drivers/parport/parport_pc.c	Thu Jan  2 12:54:34 2003
+++ linux-m68k-2.5.54/drivers/parport/parport_pc.c	Fri Jan  3 17:45:08 2003
@@ -2987,7 +2987,7 @@
 	.id_table	= pnp_dev_table,
 };
 #else
-static const struct pnp_driver parport_pc_pnp_driver;
+static struct pnp_driver parport_pc_pnp_driver;
 #endif
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

