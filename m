Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbTC0WCh>; Thu, 27 Mar 2003 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbTC0WCh>; Thu, 27 Mar 2003 17:02:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53733 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261406AbTC0WCf>; Thu, 27 Mar 2003 17:02:35 -0500
Date: Thu, 27 Mar 2003 23:13:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in drivers/net/r8169.c
Message-ID: <20030327221342.GC24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In drivers/net/r8169.c the function rtl8169_remove_one is __devexit but 
the pointer to it didn't use __devexit_p resulting in a.text.exit 
compile error when !CONFIG_HOTPLUG.

The fix is simple:

--- linux-2.4.21-pre6-full-nohotplug/drivers/net/r8169.c.old	2003-03-27 22:17:09.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/net/r8169.c	2003-03-27 22:19:18.000000000 +0100
@@ -1110,7 +1110,7 @@
 	.name		= MODULENAME,
 	.id_table	= rtl8169_pci_tbl,
 	.probe		= rtl8169_init_one,
-	.remove		= rtl8169_remove_one,
+	.remove		= __devexit_p(rtl8169_remove_one),
 	.suspend	= NULL,
 	.resume		= NULL,
 };


The patch applies against 2.4.21-pre6 and 2.5.66. I've tested the 
compilation with 2.4.21-pre6.


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

