Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266264AbUA2AeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUA2AeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:34:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32244 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266264AbUA2AeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:34:17 -0500
Date: Thu, 29 Jan 2004 01:34:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Olaf Hering <olh@suse.de>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040129003412.GQ3004@fs.tum.de>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040128200408.GA23896@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128200408.GA23896@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:04:08PM +0100, Olaf Hering wrote:
> 
> Here is a patch to fix compilation on ppc32.
>...
> The ide object files can be found in a subdirectory.
> 
> 
> diff -p -purN linux-2.6.2-rc2-mm1.orig/drivers/ide/Makefile linux-2.6.2-rc2-mm1/drivers/ide/Makefile
> --- linux-2.6.2-rc2-mm1.orig/drivers/ide/Makefile	2004-01-28 19:30:54.000000000 +0000
> +++ linux-2.6.2-rc2-mm1/drivers/ide/Makefile	2004-01-28 19:55:41.000000000 +0000
> @@ -34,9 +34,9 @@ ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= ma
>  ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
>  
>  # built-in only drivers from ppc/
> -ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
> -ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= pmac.o
> -ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= swarm.o
> +ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
> +ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
> +ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
>  
>  obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
>  obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
>...


This was fixed in ide-legacy-build-fix.patch up to 2.6.2-rc1-mm2, which 
was dropped as "merged" in 2.6.2-rc1-mm3.

The same is needed for legacy/, and a complete patch for 
drivers/ide/Makefile is below.

cu
Adrian

--- linux-2.6.2-rc2-mm1/drivers/ide/Makefile.old	2004-01-29 01:30:27.000000000 +0100
+++ linux-2.6.2-rc2-mm1/drivers/ide/Makefile	2004-01-29 01:31:09.000000000 +0100
@@ -26,17 +26,17 @@
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 
 # built-in only drivers from legacy/
-ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
-ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= buddha.o
-ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
-ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= gayle.o
-ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= macide.o
-ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
+ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
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
