Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTICIHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTICIFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:05:24 -0400
Received: from dp.samba.org ([66.70.73.150]:37281 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261606AbTICIEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:04:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       Dag Brattli <dagb@cs.uit.no>, Maxim Krasnyansky <maxk@qualcomm.com>,
       Paul Fulghum <paulkf@microgate.com>, Vojtech Pavlik <vojtech@ucw.cz>,
       Andreas =?ISO-8859-1?Q?=20K=F6nsgen?= <ajk@ccac.rwth-aachen.de>
Subject: [PATCH] MODULE_ALIAS for tty ldisc
Date: Wed, 03 Sep 2003 18:01:47 +1000
Message-Id: <20030903080444.65FEB2C07D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hardcoded names in modprobe, modules can offer their own
aliases (which can be overridden by the config file).

Here are the tty-ldisc ones.

Name: Module Aliases Inside Modules: Line Disciplines
Author: Rusty Russell
Status: Trivial

D: MODULE_ALIAS() macros for line disciplines.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/include/asm-i386/termios.h working-2.6.0-test4-bk4-miscmod/include/asm-i386/termios.h
--- linux-2.6.0-test4-bk4/include/asm-i386/termios.h	2001-06-12 12:15:27.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/include/asm-i386/termios.h	2003-09-03 15:11:07.000000000 +1000
@@ -58,6 +58,7 @@ struct termio {
 #define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
+#include <linux/module.h>
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
@@ -101,6 +102,8 @@ struct termio {
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
+#define MODULE_ALIAS_LDISC(ldisc) \
+	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 #endif	/* __KERNEL__ */
 
 #endif	/* _I386_TERMIOS_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/bluetooth/hci_ldisc.c working-2.6.0-test4-bk4-miscmod/drivers/bluetooth/hci_ldisc.c
--- linux-2.6.0-test4-bk4/drivers/bluetooth/hci_ldisc.c	2003-05-27 15:02:07.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/bluetooth/hci_ldisc.c	2003-09-03 15:25:06.000000000 +1000
@@ -574,3 +574,4 @@ module_exit(hci_uart_cleanup);
 MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth HCI UART driver ver " VERSION);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_HCI);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/char/n_hdlc.c working-2.6.0-test4-bk4-miscmod/drivers/char/n_hdlc.c
--- linux-2.6.0-test4-bk4/drivers/char/n_hdlc.c	2003-09-03 09:55:14.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/char/n_hdlc.c	2003-09-03 15:22:26.000000000 +1000
@@ -982,3 +982,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Fulghum paulkf@microgate.com");
 MODULE_PARM(debuglevel, "i");
 MODULE_PARM(maxframe, "i");
+MODULE_ALIAS_LDISC(N_HDLC);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/char/n_r3964.c working-2.6.0-test4-bk4-miscmod/drivers/char/n_r3964.c
--- linux-2.6.0-test4-bk4/drivers/char/n_r3964.c	2003-08-12 06:57:41.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/char/n_r3964.c	2003-09-03 15:27:57.000000000 +1000
@@ -1428,4 +1428,4 @@ static int r3964_receive_room(struct tty
 
 
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_LDISC(N_R3964);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/input/serio/serport.c working-2.6.0-test4-bk4-miscmod/drivers/input/serio/serport.c
--- linux-2.6.0-test4-bk4/drivers/input/serio/serport.c	2003-05-05 12:37:00.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/input/serio/serport.c	2003-09-03 15:28:17.000000000 +1000
@@ -24,6 +24,7 @@
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Input device TTY line discipline");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_MOUSE);
 
 #define SERPORT_BUSY	1
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/hamradio/6pack.c working-2.6.0-test4-bk4-miscmod/drivers/net/hamradio/6pack.c
--- linux-2.6.0-test4-bk4/drivers/net/hamradio/6pack.c	2003-08-12 06:57:45.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/hamradio/6pack.c	2003-09-03 15:19:22.000000000 +1000
@@ -1064,6 +1064,7 @@ static void decode_data(unsigned char in
 MODULE_AUTHOR("Andreas Könsgen <ajk@ccac.rwth-aachen.de>");
 MODULE_DESCRIPTION("6pack driver for AX.25");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_6PACK);
 
 module_init(sixpack_init_driver);
 module_exit(sixpack_exit_driver);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/hamradio/mkiss.c working-2.6.0-test4-bk4-miscmod/drivers/net/hamradio/mkiss.c
--- linux-2.6.0-test4-bk4/drivers/net/hamradio/mkiss.c	2003-07-14 16:58:36.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/hamradio/mkiss.c	2003-09-03 15:14:58.000000000 +1000
@@ -935,7 +935,7 @@ MODULE_DESCRIPTION("KISS driver for AX.2
 MODULE_PARM(ax25_maxdev, "i");
 MODULE_PARM_DESC(ax25_maxdev, "number of MKISS devices");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_LDISC(N_AX25);
 module_init(mkiss_init_driver);
 module_exit(mkiss_exit_driver);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/irda/irtty-sir.c working-2.6.0-test4-bk4-miscmod/drivers/net/irda/irtty-sir.c
--- linux-2.6.0-test4-bk4/drivers/net/irda/irtty-sir.c	2003-07-11 09:54:45.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/irda/irtty-sir.c	2003-09-03 15:21:00.000000000 +1000
@@ -651,5 +651,6 @@ module_exit(irtty_sir_cleanup);
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrDA TTY device driver");
+MODULE_ALIAS_LDISC(N_IRDA);
 MODULE_LICENSE("GPL");
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/ppp_async.c working-2.6.0-test4-bk4-miscmod/drivers/net/ppp_async.c
--- linux-2.6.0-test4-bk4/drivers/net/ppp_async.c	2003-08-12 06:57:45.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/ppp_async.c	2003-09-03 15:12:52.000000000 +1000
@@ -84,7 +84,7 @@ static int flag_time = HZ;
 MODULE_PARM(flag_time, "i");
 MODULE_PARM_DESC(flag_time, "ppp_async: interval between flagged packets (in clock ticks)");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS_LDISC(N_PPP);
 
 /*
  * Prototypes.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/ppp_synctty.c working-2.6.0-test4-bk4-miscmod/drivers/net/ppp_synctty.c
--- linux-2.6.0-test4-bk4/drivers/net/ppp_synctty.c	2003-05-27 15:02:11.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/ppp_synctty.c	2003-09-03 15:23:39.000000000 +1000
@@ -759,3 +759,4 @@ ppp_sync_cleanup(void)
 module_init(ppp_sync_init);
 module_exit(ppp_sync_cleanup);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_SYNC_PPP);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test4-bk4/drivers/net/slip.c working-2.6.0-test4-bk4-miscmod/drivers/net/slip.c
--- linux-2.6.0-test4-bk4/drivers/net/slip.c	2003-08-25 11:58:22.000000000 +1000
+++ working-2.6.0-test4-bk4-miscmod/drivers/net/slip.c	2003-09-03 15:11:27.000000000 +1000
@@ -1513,3 +1513,4 @@ out:
 
 #endif
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_SLIP);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
