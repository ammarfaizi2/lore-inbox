Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTICOV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTICOV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:21:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55767 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262228AbTICOVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:21:24 -0400
Date: Wed, 3 Sep 2003 16:19:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] fix warning with modular ide.c
Message-ID: <20030903141901.GZ23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I got the following compile warning when trying to compile ide.c modular 
in 2.6.0-tet4-mm5:

<--  snip  -->

...
  CC [M]  drivers/ide/ide.o
drivers/ide/ide.c: In function `ide_unregister_subdriver':
drivers/ide/ide.c:2476: warning: implicit declaration of function 
`pnpide_init'
...

<--  snip  -->

I'd suggest the patch below (or something similar).

cu
Adrian

--- linux-2.6.0-test4-mm5-modular-no-smp/drivers/ide/ide.c.old	2003-09-03 15:55:46.000000000 +0200
+++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/ide/ide.c	2003-09-03 15:59:46.000000000 +0200
@@ -214,6 +214,11 @@
 extern ide_driver_t idedefault_driver;
 static void setup_driver_defaults(ide_driver_t *driver);
 
+#ifdef CONFIG_BLK_DEV_IDEPNP
+extern void pnpide_init(int enable);
+#endif
+
+
 /*
  * Do not even *think* about calling this!
  */
@@ -2288,7 +2293,6 @@
 #endif /* CONFIG_BLK_DEV_BUDDHA */
 #if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP)
 	{
-		extern void pnpide_init(int enable);
 		pnpide_init(1);
 	}
 #endif /* CONFIG_BLK_DEV_IDEPNP */


