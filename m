Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268549AbTANDdg>; Mon, 13 Jan 2003 22:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268553AbTANDdf>; Mon, 13 Jan 2003 22:33:35 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:16481
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268549AbTANDdd>; Mon, 13 Jan 2003 22:33:33 -0500
Date: Mon, 13 Jan 2003 22:42:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jaroslav Kysela <perex@perex.cz>
cc: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] sound/oss/ad1848.c compile fix
Message-ID: <Pine.LNX.4.44.0301132235020.12490-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fails to compile, tested on an opl3sa2.

Although this driver doesn't actually use the new pnp code to do detection. 

Index: linux-2.5.57/sound/oss/ad1848.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.57/sound/oss/ad1848.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ad1848.c
--- linux-2.5.57/sound/oss/ad1848.c	13 Jan 2003 22:55:14 -0000	1.1.1.1
+++ linux-2.5.57/sound/oss/ad1848.c	14 Jan 2003 03:39:35 -0000
@@ -3007,7 +3007,7 @@
 		if((ad1848_dev = activate_dev(ad1848_isapnp_list[slot].name, "ad1848", ad1848_dev)))
 		{
 			get_device(&ad1848_dev->dev);
-			hw_config->io_base 	= ad1848_dev->resource[ad1848_isapnp_list[slot].mss_io].start;
+			hw_config->io_base 	= ad1848_dev->io_resource[ad1848_isapnp_list[slot].mss_io].start;
 			hw_config->irq 		= ad1848_dev->irq_resource[ad1848_isapnp_list[slot].irq].start;
 			hw_config->dma 		= ad1848_dev->dma_resource[ad1848_isapnp_list[slot].dma].start;
 			if(ad1848_isapnp_list[slot].dma2 != -1)
-- 
function.linuxpower.ca

