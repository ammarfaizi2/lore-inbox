Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUDLQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUDLQo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 12:44:26 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:8327 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262963AbUDLQoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 12:44:23 -0400
Date: Mon, 12 Apr 2004 18:43:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v2.6.5 drivers/char/isicom.c
Message-ID: <20040412184359.D30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

A small fix for drivers/char/isicom.c .
It's untested since I don't have this hardware myself.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c	Thu Mar 11 03:55:21 2004
+++ b/drivers/char/isicom.c	Mon Apr 12 18:30:21 2004
@@ -1312,7 +1312,6 @@
 			   unsigned int set, unsigned int clear)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	unsigned int arg;
 	unsigned long flags;
 	
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
@@ -1650,7 +1649,7 @@
 static void unregister_drivers(void)
 {
 	int error;
-	if (tty_unregister_driver(isicom_normal))
+	if ((error = tty_unregister_driver(isicom_normal)))
 		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
 	put_tty_driver(isicom_normal);
 }
