Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbTCGRaS>; Fri, 7 Mar 2003 12:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbTCGRaS>; Fri, 7 Mar 2003 12:30:18 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:48137
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261679AbTCGRaR>; Fri, 7 Mar 2003 12:30:17 -0500
Date: Fri, 7 Mar 2003 12:36:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.64][COMPILE] opl3sa2.c
In-Reply-To: <Pine.LNX.4.44.0303071127420.10491-100000@oddball.prodigy.com>
Message-ID: <Pine.LNX.4.50.0303071235270.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303071127420.10491-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Bill Davidsen wrote:

>   gcc -Wp,-MD,sound/oss/.opl3sa2.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=opl3sa2 -DKBUILD_MODNAME=opl3sa2 -c -o sound/oss/opl3sa2.o sound/oss/opl3sa2.c
> sound/oss/opl3sa2.c: In function `opl3sa2_pnp_probe':
> sound/oss/opl3sa2.c:854: structure has no member named `io_resource'
> sound/oss/opl3sa2.c:855: structure has no member named `irq_resource'
> sound/oss/opl3sa2.c:856: structure has no member named `dma_resource'
> sound/oss/opl3sa2.c:857: structure has no member named `dma_resource'
> sound/oss/opl3sa2.c:860: structure has no member named `io_resource'
> sound/oss/opl3sa2.c:861: structure has no member named `irq_resource'
> sound/oss/opl3sa2.c:862: structure has no member named `dma_resource'
> sound/oss/opl3sa2.c:863: structure has no member named `dma_resource'
> sound/oss/opl3sa2.c:866: structure has no member named `io_resource'
> sound/oss/opl3sa2.c:867: structure has no member named `irq_resource'
> make[2]: *** [sound/oss/opl3sa2.o] Error 1
> make[1]: *** [sound/oss] Error 2
> make: *** [sound] Error 2

The following would fix compilation but it has been broken wrt actually 
functioning by the pnp changes. I'll have a look at resurrecting it this 
weekend.

Index: linux-2.5.64/sound/oss/opl3sa2.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/sound/oss/opl3sa2.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 opl3sa2.c
--- linux-2.5.64/sound/oss/opl3sa2.c	5 Mar 2003 05:08:32 -0000	1.1.1.1
+++ linux-2.5.64/sound/oss/opl3sa2.c	5 Mar 2003 08:34:21 -0000
@@ -851,20 +851,20 @@
 	opl3sa2_activated[card] = 1;
 
 	/* Our own config: */
-	cfg[card].io_base = dev->io_resource[4].start;
-	cfg[card].irq     = dev->irq_resource[0].start;
-	cfg[card].dma     = dev->dma_resource[0].start;
-	cfg[card].dma2    = dev->dma_resource[1].start;
+	cfg[card].io_base = pnp_port_start(dev, 4);
+	cfg[card].irq     = pnp_irq(dev, 0);
+	cfg[card].dma     = pnp_dma(dev, 0);
+	cfg[card].dma2    = pnp_dma(dev, 1);
 
 	/* The MSS config: */
-	cfg_mss[card].io_base      = dev->io_resource[1].start;
-	cfg_mss[card].irq          = dev->irq_resource[0].start;
-	cfg_mss[card].dma          = dev->dma_resource[0].start;
-	cfg_mss[card].dma2         = dev->dma_resource[1].start;
+	cfg_mss[card].io_base      = pnp_port_start(dev, 1);
+	cfg_mss[card].irq          = pnp_irq(dev, 0);
+	cfg_mss[card].dma          = pnp_dma(dev, 0);
+	cfg_mss[card].dma2         = pnp_dma(dev, 1);
 	cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
 
-	cfg_mpu[card].io_base       = dev->io_resource[3].start;
-	cfg_mpu[card].irq           = dev->irq_resource[0].start;
+	cfg_mpu[card].io_base       = pnp_port_start(dev, 3);
+	cfg_mpu[card].irq           = pnp_irq(dev, 0);
 	cfg_mpu[card].dma           = -1;
 	cfg_mpu[card].dma2          = -1;
 	cfg_mpu[card].always_detect = 1; /* It's there, so use shared IRQs */
-- 
function.linuxpower.ca
