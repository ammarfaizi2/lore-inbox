Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUDFLbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:31:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27011 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263782AbUDFLat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:30:49 -0400
Date: Tue, 6 Apr 2004 13:30:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] isicom error path
Message-ID: <Pine.GSO.4.58.0404061330010.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Variable error is not initialized, but printed if tty_unregister_driver() fails

--- linux-2.6.5/drivers/char/isicom.c.orig	2004-03-04 11:30:38.000000000 +0100
+++ linux-2.6.5/drivers/char/isicom.c	2004-04-02 10:59:33.000000000 +0200
@@ -1649,8 +1649,8 @@

 static void unregister_drivers(void)
 {
-	int error;
-	if (tty_unregister_driver(isicom_normal))
+	int error = tty_unregister_driver(isicom_normal);
+	if (error)
 		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
 	put_tty_driver(isicom_normal);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
