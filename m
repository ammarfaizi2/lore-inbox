Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291806AbSBXXVZ>; Sun, 24 Feb 2002 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291834AbSBXXVF>; Sun, 24 Feb 2002 18:21:05 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:48633 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S291806AbSBXXUz>;
	Sun, 24 Feb 2002 18:20:55 -0500
Date: Mon, 25 Feb 2002 00:20:53 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202242320.AAA15930@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.18-pre/rc broke PLIP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sent to Tim Waugh and Marcelo previously, but of course
I managed to put a typo in the cc: to lkml]

Someone (sorry I forgot who) reported having problems with
PLIP in recent kernels. I've done some testing and can confirm
that PLIP worked up to 2.4.17 but broke in 2.4.18-pre/rc.
The only thing PLIP does is put "plip0: transmit timeout(1,87)"
messages in the kernel log.

After a lot of testing I've narrowed it down to the following
hunk in the 2.4.18-rc4 patch:

--- linux.orig/drivers/parport/parport_pc.c	Mon Feb 18 20:18:40 2002
+++ linux/drivers/parport/parport_pc.c	Mon Jan 14 19:08:50 2002
@@ -2212,7 +2233,7 @@
 	}
 	memcpy (ops, &parport_pc_ops, sizeof (struct parport_operations));
 	priv->ctr = 0xc;
-	priv->ctr_writable = 0xff;
+	priv->ctr_writable = ~0x10;
 	priv->ecr = 0;
 	priv->fifo_depth = 0;
 	priv->dma_buf = 0;

If I back this hunk out, PLIP starts working again.
Is this fix sufficient or is there something else that need fixing?

/Mikael
