Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268634AbTBZE4a>; Tue, 25 Feb 2003 23:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268637AbTBZE4a>; Tue, 25 Feb 2003 23:56:30 -0500
Received: from pandora.cantech.net.au ([203.26.6.29]:50181 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S268634AbTBZE43>; Tue, 25 Feb 2003 23:56:29 -0500
Date: Wed, 26 Feb 2003 13:06:42 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix compile for drivers/pcmcia/i82365.c
Message-ID: <Pine.LNX.4.44.0302261256510.1039-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	The 2.5.63 kernel contains changes to pnp.h that mean the template arg
is nolonger there.  The object compiles with this patch.

If this patch is correct I'm happy to create patches that will fix the same
issue in the rest of the drivers tree.
	
--------------------------------------------------------------------------------
diff -X dontdiff -purN linux-2.5.63.clean/drivers/pcmcia/i82365.c linux-2.5.63.i82365/drivers/pcmcia/i82365.c
--- linux-2.5.63.clean/drivers/pcmcia/i82365.c	2003-02-27 10:55:04.000000000 +0800
+++ linux-2.5.63.i82365/drivers/pcmcia/i82365.c	2003-02-27 12:31:08.000000000 +0800
@@ -846,7 +846,7 @@ static void __init isa_probe(void)
 	
 	    printk("PNP ");
 	    
-	    if (pnp_activate_dev(dev, NULL) < 0) {
+	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;
--------------------------------------------------------------------------------

Yours Tony.

/*
 * "The significant problems we face cannot be solved at the 
 * same level of thinking we were at when we created them."
 * --Albert Einstein
 */

