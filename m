Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272518AbTHKGvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272512AbTHKGvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:51:06 -0400
Received: from 13.telemaxx.net ([213.144.13.149]:47823 "EHLO
	gatekeeper.syskonnect.de") by vger.kernel.org with ESMTP
	id S272458AbTHKGu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:50:58 -0400
From: <support@syskonnect.de>
To: "'Adrian Bunk'" <bunk@fs.tum.de>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>, <linux@syskonnect.de>
Subject: RE: [2.6 patch] fix net/sk98lin/skge.c for !PROC_FS
Date: Mon, 11 Aug 2003 08:47:00 +0200
Message-ID: <000e01c35fd4$5e80a320$bc01090a@skd.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <20030808201823.GE16091@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

Thank you very much for your interest in SysKonnect products.

We will consider your suggestion during the next release.

Thank you again for your cooperation.

Best regards
Karim

SysKonnect GmbH
A Marvell®Company
-------------------------------------
Karim Jamal
Technical Support Engineer
--------------------------------------
Phone: +49 (0) 7243502-330
Fax: +49 (0) 7243502-364
Mail: support@syskonnect.de
Web: http:\\www.syskonnect.de




-----Original Message-----
From: Adrian Bunk [mailto:bunk@fs.tum.de]
Sent: Friday, August 08, 2003 10:18 PM
To: linux@syskonnect.de
Cc: linux-net@vger.kernel.org; linux-kernel@vger.kernel.org;
trivial@rustcorp.com.au
Subject: [2.6 patch] fix net/sk98lin/skge.c for !PROC_FS


I got the following compile error compiling 2.6.0-test2-mm5 with
!CONFIG_PROC_FS:

<--  snip  -->

...
  CC      drivers/net/sk98lin/skge.o
...
drivers/net/sk98lin/skge.c:730: error: `proc_net' undeclared (first use
in this function)
drivers/net/sk98lin/skge.c:730: error: (Each undeclared identifier is
reported only once
drivers/net/sk98lin/skge.c:730: error: for each function it appears in.)
make[3]: *** [drivers/net/sk98lin/skge.o] Error 1

<--  snip  -->

The following patch fixes it:

--- linux-2.6.0-test2-mm5/drivers/net/sk98lin/skge.c.old	2003-08-08
20:24:50.000000000 +0200
+++ linux-2.6.0-test2-mm5/drivers/net/sk98lin/skge.c	2003-08-08
20:25:22.000000000 +0200
@@ -724,6 +724,7 @@
 			SK_MEMCPY(&SK_Root_Dir_entry, BootString,
 				sizeof(SK_Root_Dir_entry) - 1);

+#ifdef CONFIG_PROC_FS
 			/*Create proc (directory)*/
 			if(!proc_root_initialized) {
 				pSkRootDir = create_proc_entry(SK_Root_Dir_entry,
@@ -731,6 +732,7 @@
 				pSkRootDir->owner = THIS_MODULE;
 				proc_root_initialized = 1;
 			}
+#endif  /*  CONFIG_PROC_FS  */

 		}



Please apply
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


