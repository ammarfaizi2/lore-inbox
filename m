Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281833AbRK1Ag6>; Tue, 27 Nov 2001 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281825AbRK1Agm>; Tue, 27 Nov 2001 19:36:42 -0500
Received: from www.transvirtual.com ([206.14.214.140]:17165 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S281833AbRK1Afv>; Tue, 27 Nov 2001 19:35:51 -0500
Date: Tue, 27 Nov 2001 16:35:40 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] small VT cleanup
Message-ID: <Pine.LNX.4.10.10111271630480.11861-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small cleanups for the VT system. Doesn't make sense to have any VT code
in genhd.c. So I moved it to tty_io.c where it belongs. Patch has been
tested.

--- linux-2.5.0/drivers/block/genhd.c	Tue Nov 27 12:05:59 2001
+++ linux/drivers/block/genhd.c	Tue Nov 27 17:24:26 2001
@@ -183,7 +183,6 @@
 extern int fusion_init(void);
 #endif
 extern int net_dev_init(void);
-extern void console_map_init(void);
 extern int soc_probe(void);
 extern int atmdev_init(void);
 extern int i2o_init(void);
@@ -212,9 +211,6 @@
 #endif
 #ifdef CONFIG_ATM
 	(void) atmdev_init();
-#endif
-#ifdef CONFIG_VT
-	console_map_init();
 #endif
 	return 0;
 }
--- linux-2.5.0/drivers/char/tty_io.c	Tue Nov 27 11:56:43 2001
+++ linux/drivers/char/tty_io.c	Tue Nov 27 17:24:05 2001
@@ -2317,7 +2317,9 @@
 	if (tty_register_driver(&dev_console_driver))
 		panic("Couldn't register /dev/tty0 driver\n");
 
+	vcs_init();
 	kbd_init();
+	console_map_init();
 #endif
 
 #ifdef CONFIG_ESPSERIAL  /* init ESP before rs, so rs doesn't see the port */
@@ -2363,9 +2365,6 @@
 #ifdef CONFIG_MOXA_INTELLIO
 	moxa_init();
 #endif	
-#ifdef CONFIG_VT
-	vcs_init();
-#endif
 #ifdef CONFIG_TN3270
 	tub3270_init();
 #endif

