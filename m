Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbTC0WEP>; Thu, 27 Mar 2003 17:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTC0WEN>; Thu, 27 Mar 2003 17:04:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48101 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261415AbTC0WDY>; Thu, 27 Mar 2003 17:03:24 -0500
Date: Thu, 27 Mar 2003 23:14:31 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: chas@cmf.nrl.navy.mil, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix atm/iphase.c .text.exit error
Message-ID: <20030327221431.GG24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function ia_remove_one in drivers/atm/iphase.c is __devexit but the
pointer to it doesn't use __devexit_p resulting in a .text.exit error if
!CONFIG_HOTPLUG.

The following patch is needed:


--- linux-2.4.21-pre6-full-nohotplug/drivers/atm/iphase.c.old	2003-03-27 22:45:31.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/atm/iphase.c	2003-03-27 22:46:28.000000000 +0100
@@ -3322,7 +3322,7 @@
 	.name =         DEV_LABEL,
 	.id_table =     ia_pci_tbl,
 	.probe =        ia_init_one,
-	.remove =       ia_remove_one,
+	.remove =       __devexit_p(ia_remove_one),
 };
 
 static int __init ia_init_module(void)


This patch applies against 2.4.21-pre6 and 2.5.66. I've tested the 
compilation with 2.4.21-pre6.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

