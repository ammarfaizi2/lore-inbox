Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUA1UL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUA1UL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:11:28 -0500
Received: from ns.suse.de ([195.135.220.2]:13957 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266027AbUA1ULZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:11:25 -0500
Date: Wed, 28 Jan 2004 21:04:08 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040128200408.GA23896@suse.de>
References: <20040127233402.6f5d3497.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 27, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/
> 
> 
> - From now on, -mm kernels will contain the latest contents of:
> 
> 	Linus's tree:		linus.patch
> 	The ACPI tree:		acpi.patch
> 	Vojtech's tree:		input.patch
> 	Jeff's tree:		netdev.patch
> 	The ALSA tree:		alsa.patch
> 
>   If anyone has any more external trees which need similar treatment,
>   please let me know.

The bigendian trees.


Here is a patch to fix compilation on ppc32.
pm_prepare_console returns int and linux/suspend.h is already included.
The ide object files can be found in a subdirectory.


diff -p -purN linux-2.6.2-rc2-mm1.orig/drivers/ide/Makefile linux-2.6.2-rc2-mm1/drivers/ide/Makefile
--- linux-2.6.2-rc2-mm1.orig/drivers/ide/Makefile	2004-01-28 19:30:54.000000000 +0000
+++ linux-2.6.2-rc2-mm1/drivers/ide/Makefile	2004-01-28 19:55:41.000000000 +0000
@@ -34,9 +34,9 @@ ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= ma
 ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
 
 # built-in only drivers from ppc/
-ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
-ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= pmac.o
-ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= swarm.o
+ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
+ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
+ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
diff -p -purN linux-2.6.2-rc2-mm1.orig/drivers/macintosh/via-pmu.c linux-2.6.2-rc2-mm1/drivers/macintosh/via-pmu.c
--- linux-2.6.2-rc2-mm1.orig/drivers/macintosh/via-pmu.c	2004-01-28 19:30:54.000000000 +0000
+++ linux-2.6.2-rc2-mm1/drivers/macintosh/via-pmu.c	2004-01-28 20:00:00.000000000 +0000
@@ -2339,8 +2339,6 @@ restore_via_state(void)
 }
 
 extern long sys_sync(void);
-extern void pm_prepare_console(void);
-extern void pm_restore_console(void);
 
 static int __pmac
 pmac_suspend_devices(void)

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
