Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSDASls>; Mon, 1 Apr 2002 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDASli>; Mon, 1 Apr 2002 13:41:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:48582 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312556AbSDASl1>;
	Mon, 1 Apr 2002 13:41:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 1 Apr 2002 18:41:26 GMT
Message-Id: <UTC200204011841.SAA486178.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] omission in video driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documenting the video ioctls, I noticed to my dismay
that the ioctl to set the border color of the console
screen is lacking.

Here part of the fix for 2.4.19:

--- /linux/2.4/linux-2.4.19pre4/linux/drivers/video/vgacon.c	Fri Mar 29 01:02:00 2002
+++ ./vgacon.c	Tue Apr  1 20:14:14 2002
@@ -244,6 +244,14 @@
 				outb_p (6, 0x3ce) ;
 				outb_p (6, 0x3cf) ;
 #endif
+				/*
+				 * Load overscan register red.
+				 */
+				inb_p(0x3da);        /* clear flipflop */
+				outb_p(0x11, 0x3c0); /* index overscan color */
+				outb_p(0x0c, 0x3c0); /* load value */
+				outb_p(0x20, 0x3c0); /* allow display memory
+							to access palette */
 
 				/*
 				 * Normalise the palette registers, to point

Andries

[this is the nontrivial part; the rest is left as an exercise]
