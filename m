Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSGQRsM>; Wed, 17 Jul 2002 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGQRsM>; Wed, 17 Jul 2002 13:48:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:38636 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316088AbSGQRsL>; Wed, 17 Jul 2002 13:48:11 -0400
Date: Wed, 17 Jul 2002 19:51:04 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <hermes@gibson.dropbear.id.au>
Subject: [patch] fix .text.exit error in orinoco_plx.c
Message-ID: <Pine.NEB.4.44.0207171944130.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the following .text.exit error is still present in 2.4.19-rc2:

<--  snip  -->

...
drivers/net/wireless/wireless_net.o(.data+0x554): undefined reference to
`local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

<--  snip  -->

Please apply the following patch that fixes it in -rc3:

--- drivers/net/wireless/orinoco_plx.c.old	Wed Jul 17 19:41:02 2002
+++ drivers/net/wireless/orinoco_plx.c	Wed Jul 17 19:42:13 2002
@@ -385,7 +385,7 @@
 	name:"orinoco_plx",
 	id_table:orinoco_plx_pci_id_table,
 	probe:orinoco_plx_init_one,
-	remove:orinoco_plx_remove_one,
+	remove:__devexit_p(orinoco_plx_remove_one),
 	suspend:0,
 	resume:0
 };


TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


