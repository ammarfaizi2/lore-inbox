Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262785AbSJGUq7>; Mon, 7 Oct 2002 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbSJGUq6>; Mon, 7 Oct 2002 16:46:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29196 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262785AbSJGUqs>; Mon, 7 Oct 2002 16:46:48 -0400
Date: Mon, 7 Oct 2002 13:51:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: <linux-kernel@vger.kernel.org>, <maxk@qualcomm.com>
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth subsystem
In-Reply-To: <Pine.LNX.4.33.0210071347470.10749-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210071350420.10749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Linus Torvalds wrote:
> 
> Looks good, but you should _not_ remove the "static". Please keep the init
> functions static, they will be explicitly exported to the stuff that cares
> (and nobody else) by the "module_init()" thing anyway.

In other words, I think the patch should be just this instead..

		Linus

diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	Mon Oct  7 22:16:14 2002
+++ b/net/bluetooth/af_bluetooth.c	Mon Oct  7 22:16:14 2002
@@ -356,11 +356,9 @@
 	remove_proc_entry("bluetooth", NULL);
 }
 
-#ifdef MODULE
 module_init(bluez_init);
 module_exit(bluez_cleanup);
 
 MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>");
 MODULE_DESCRIPTION("BlueZ Core ver " VERSION);
 MODULE_LICENSE("GPL");
-#endif
diff -Nru a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c	Mon Oct  7 22:16:14 2002
+++ b/net/bluetooth/rfcomm/tty.c	Mon Oct  7 22:16:14 2002
@@ -501,12 +501,6 @@
 #endif
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
-#define __minor MINOR
-#else
-#define __minor minor
-#endif
-
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -514,7 +508,7 @@
 	struct rfcomm_dlc *dlc;
 	int err, id;
 
-        id = __minor(tty->device) - tty->driver.minor_start;
+        id = minor(tty->device) - tty->driver.minor_start;
 
 	BT_DBG("tty %p id %d", tty, id);
 


