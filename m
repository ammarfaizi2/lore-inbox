Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSFYMa4>; Tue, 25 Jun 2002 08:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFYMaz>; Tue, 25 Jun 2002 08:30:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42445 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314080AbSFYMay>; Tue, 25 Jun 2002 08:30:54 -0400
Date: Tue, 25 Jun 2002 14:30:51 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Denis Oliver Kropp <dok@convergence.de>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in neofb.c
Message-ID: <Pine.NEB.4.44.0206251426180.14220-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following error occured at the final linking of 2.4.19-rc:

<--  snip  -->

...
drivers/video/video.o(.data+0x46b4): more undefined references to
`local symbols in discarded section .text.exit' follow
...

<--  snip  -->

The following patch fixes it (neofb_remove is __devexit but the pointer to
it didn't use __devexit_p):


--- drivers/video/neofb.c.old	Tue Jun 25 12:53:45 2002
+++ drivers/video/neofb.c	Tue Jun 25 12:54:28 2002
@@ -2330,7 +2330,7 @@
   name:      "neofb",
   id_table:  neofb_devices,
   probe:     neofb_probe,
-  remove:    neofb_remove
+  remove:    __devexit_p(neofb_remove)
 };

 /* **************************** init-time only **************************** */

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


