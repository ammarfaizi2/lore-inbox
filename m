Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUATNU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUATNU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:20:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8130 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265514AbUATNUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:20:18 -0500
Date: Tue, 20 Jan 2004 14:20:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.1-mm5: compile error with IDE legacy driver
Message-ID: <20040120132011.GB12027@fs.tum.de>
References: <20040120000535.7fb8e683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:05:35AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.1-mm4:
>...
> -modular-ide-is-broken.patch
> +fix-improve-modular-ide.patch
> 
>  Make IDE work as a module again.
>...

I got the following compile error:

<--  snip  -->

...
  CC      drivers/ide/ide-pnp.o
make[2]: *** No rule to make target `drivers/ide/pdc4030.s', needed by 
`drivers/ide/pdc4030.o'.  Stop.
make[1]: *** [drivers/ide] Error 2

<--  snip  -->

The patch below fixes this problem.

cu
Adrian


--- linux-2.6.1-mm5/drivers/ide/Makefile.old	2004-01-20 13:39:23.000000000 +0100
+++ linux-2.6.1-mm5/drivers/ide/Makefile	2004-01-20 13:40:04.000000000 +0100
@@ -23,18 +23,18 @@
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
-ide-core-$(CONFIG_BLK_DEV_PDC4030)	+= pdc4030.o
-ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= buddha.o
-ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
-ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= gayle.o
-ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= macide.o
-ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
+ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
+ide-core-$(CONFIG_BLK_DEV_PDC4030)	+= legacy/pdc4030.o
+ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= legacy/buddha.o
+ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= legacy/falconide.o
+ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= legacy/gayle.o
+ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= legacy/macide.o
+ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= legacy/q40ide.o
 
 # built-in only drivers from ppc/
-ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
-ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= pmac.o
-ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= swarm.o
+ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
+ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
+ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o


