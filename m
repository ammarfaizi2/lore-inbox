Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSFYMfy>; Tue, 25 Jun 2002 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFYMfx>; Tue, 25 Jun 2002 08:35:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:39373 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315454AbSFYMfx>; Tue, 25 Jun 2002 08:35:53 -0400
Date: Tue, 25 Jun 2002 14:35:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jean Tourrilhes <jt@hpl.hp.com>, <akpm@zip.com.au>,
       <jgarzik@mandrakesoft.com>, Daniel Barlow <dan@telent.net>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit errors in orinoco_{pci,plx}.c
Message-ID: <Pine.NEB.4.44.0206251430540.14220-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following errors occured at the final linking of 2.4.19-rc1:

<--  snip  -->

...
drivers/net/wireless/wireless_net.o(.data+0x554): undefined reference to
`local symbols in discarded section .text.exit'
drivers/net/wireless/wireless_net.o(.data+0x594): more undefined
references to `local symbols in discarded section .text.exit' follow
...

<--  snip  -->

The following patch fixes it (the functions are __devexit but the pointers
to them didn't use __devexit_p):

--- drivers/net/wireless/orinoco_pci.c.old	Tue Jun 25 12:48:15 2002
+++ drivers/net/wireless/orinoco_pci.c	Tue Jun 25 12:51:11 2002
@@ -364,7 +364,7 @@
 	name:"orinoco_pci",
 	id_table:orinoco_pci_pci_id_table,
 	probe:orinoco_pci_init_one,
-	remove:orinoco_pci_remove_one,
+	remove:__devexit_p(orinoco_pci_remove_one),
 	suspend:0,
 	resume:0
 };
--- drivers/net/wireless/orinoco_plx.c.old	Tue Jun 25 12:51:21 2002
+++ drivers/net/wireless/orinoco_plx.c	Tue Jun 25 12:51:51 2002
@@ -385,7 +385,7 @@
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
-	remove:orinoco_plx_remove_one,
+	remove:__devexit_p(orinoco_plx_remove_one),
 	suspend:0,
 	resume:0
 };


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

