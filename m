Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTC0WEQ>; Thu, 27 Mar 2003 17:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbTC0WEF>; Thu, 27 Mar 2003 17:04:05 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49381 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261413AbTC0WDK>; Thu, 27 Mar 2003 17:03:10 -0500
Date: Thu, 27 Mar 2003 23:14:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Randolph Chung <tausq@debian.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix ad1889.c .text.exit error
Message-ID: <20030327221418.GF24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2,4,21-pre6 the function ad1889_remove in drivers/sound/ad1889.c is 
__devexit but the pointer to it doesn't use __devexit_p resulting in a 
.text.exit error if !CONFIG_HOTPLUG.

The following patch is needed:

--- linux-2.4.21-pre6-full-nohotplug/drivers/sound/ad1889.c.old	2003-03-27 22:40:12.000000000 +0100
+++ linux-2.4.21-pre6-full-nohotplug/drivers/sound/ad1889.c	2003-03-27 22:42:39.000000000 +0100
@@ -1059,7 +1059,7 @@
 	name:		DEVNAME,
 	id_table:	ad1889_id_tbl,
 	probe:		ad1889_probe,
-	remove:		ad1889_remove,
+	remove:		__devexit_p(ad1889_remove),
 };
 
 static int __init ad1889_init_module(void)


I've tested the compilation with 2.4.21-pre6.


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

