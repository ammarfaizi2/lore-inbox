Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTC0WEQ>; Thu, 27 Mar 2003 17:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTC0WEB>; Thu, 27 Mar 2003 17:04:01 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50661 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261412AbTC0WDD>; Thu, 27 Mar 2003 17:03:03 -0500
Date: Thu, 27 Mar 2003 23:14:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       GOTO Masanori <gotom@debian.or.jp>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix nsp32.c .text.exit error
Message-ID: <20030327221410.GE24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In drivers/scsi/nsp32.c the function nsp32_remove is __devexit but the
pointer to it isn't __devexit_p resulting in a .text.exit compile error 
if !CONFIG_HOTPLUG.

The following patch is needed:

--- linux-2.4.21-pre6-full-nohotplug/drivers/scsi/nsp32.c.old	2003-03-27 22:35:04.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/scsi/nsp32.c	2003-03-27 22:36:14.000000000 +0100
@@ -2125,7 +2125,7 @@
 	.name =		"nsp32",
 	.id_table =	nsp32_pci_table,
 	.probe =	nsp32_probe,
-	.remove =	nsp32_remove,
+	.remove =	__devexit_p(nsp32_remove),
 #ifdef CONFIG_PM
 /*	.suspend =	nsp32_suspend,*/
 /*	.resume =	nsp32_resume,*/


This patch applies against 2.4.21-pre6 and 2.5.66. I've tested the 
compilation with 2.4.21-pre6.


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

