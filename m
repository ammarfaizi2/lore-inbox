Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbUDFL2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUDFL2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:28:15 -0400
Received: from witte.sonytel.be ([80.88.33.193]:54913 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263768AbUDFL2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:28:04 -0400
Date: Tue, 6 Apr 2004 13:27:59 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] jiffies must be unsigned long
Message-ID: <Pine.GSO.4.58.0404061327210.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jiffies must be unsigned long

--- linux-2.6.5/drivers/char/isicom.c.orig	2004-03-04 11:30:38.000000000 +0100
+++ linux-2.6.5/drivers/char/isicom.c	2004-04-02 10:59:33.000000000 +0200
@@ -129,6 +129,7 @@
 		         unsigned int cmd, unsigned long arg)
 {
 	unsigned int card, i, j, signature, status, portcount = 0;
+	unsigned long t;
 	unsigned short word_count, base;
 	bin_frame frame;
 	/* exec_record exec_rec; */
@@ -152,12 +153,12 @@

 			inw(base+0x8);

-			for(i=jiffies+HZ/100;time_before(jiffies, i););
+			for(t=jiffies+HZ/100;time_before(jiffies, t););

 			outw(0,base+0x8); /* Reset */

 			for(j=1;j<=3;j++) {
-				for(i=jiffies+HZ;time_before(jiffies, i););
+				for(t=jiffies+HZ;time_before(jiffies, t););
 				printk(".");
 			}
 			signature=(inw(base+0x4)) & 0xff;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
