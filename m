Return-Path: <linux-kernel-owner+w=401wt.eu-S1030470AbXAKNvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbXAKNvl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbXAKNvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:51:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4603 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030455AbXAKNtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:49:12 -0500
Date: Thu, 11 Jan 2007 14:49:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Message-ID: <20070111134917.GE20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's unlikely that this driver will ever be of any use on other 
architectures.

This fixes the following compile error on ia64:

<--  snip  -->

...
  CC      drivers/ide/pci/amd74xx.o
/home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c: In function 'init_hwif_amd74xx':
/home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c:421: warning: implicit declaration of function 'pci_get_legacy_ide_irq'
  CC      drivers/ide/pci/cmd64x.o
...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `init_hwif_amd74xx':
/home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c:421: undefined reference to `pci_get_legacy_ide_irq'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


This fixes kernel Bugzilla #6644.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc3-mm1/drivers/ide/Kconfig.old	2007-01-11 11:15:24.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/ide/Kconfig	2007-01-11 11:15:37.000000000 +0100
@@ -478,6 +478,7 @@
 
 config BLK_DEV_AMD74XX
 	tristate "AMD and nVidia IDE support"
+	depends on X86
 	help
 	  This driver adds explicit support for AMD-7xx and AMD-8111 chips
 	  and also for the nVidia nForce chip.  This allows the kernel to

