Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSFYNen>; Tue, 25 Jun 2002 09:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSFYNen>; Tue, 25 Jun 2002 09:34:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:40191 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315468AbSFYNem>; Tue, 25 Jun 2002 09:34:42 -0400
Date: Tue, 25 Jun 2002 15:34:39 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in mtd/maps/pci.c
Message-ID: <Pine.NEB.4.44.0206251532090.14220-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following error occured at the final linking of 2.4.19-rc1:

<--  snip  -->

...
drivers/mtd/mtdlink.o(.data+0x934): undefined reference to `local
symbols in discarded section .text.exit'
...

<--  snip  -->


The following patch fixes it (mtd_pci_remove is __devexit but the pointer
to it didn't use __devexit_p):


--- drivers/mtd/maps/pci.c.old	Tue Jun 25 15:26:49 2002
+++ drivers/mtd/maps/pci.c	Tue Jun 25 15:27:25 2002
@@ -361,7 +361,7 @@
 static struct pci_driver mtd_pci_driver = {
 	name:		"MTD PCI",
 	probe:		mtd_pci_probe,
-	remove:		mtd_pci_remove,
+	remove:		__devexit_p(mtd_pci_remove),
 	id_table:	mtd_pci_ids,
 };


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

