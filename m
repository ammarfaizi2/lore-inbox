Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTAKNCU>; Sat, 11 Jan 2003 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAKNCU>; Sat, 11 Jan 2003 08:02:20 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48856 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263991AbTAKNCT>; Sat, 11 Jan 2003 08:02:19 -0500
Date: Sat, 11 Jan 2003 14:11:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] go to drivers/ide/pci/ even for !CONFIG_BLK_DEV_IDEPCI
Message-ID: <20030111131059.GK10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I observed the following problem with the cmd640 driver in 2.5.56:

- cmd640.c is in the drivers/ide/pci/ subdirectory.
- BLK_DEV_CMD640 does not depend on BLK_DEV_IDEPCI
- drivers/ide/Makefile only goes to pci/ if BLK_DEV_IDEPCI is selected

If the .config contains the following legal configuration:

<--  snip  -->

...
CONFIG_BLK_DEV_CMD640=y
...
# CONFIG_BLK_DEV_IDEPCI is not set
...

<--  snip  -->

the cmd640 driver isn't built.

The following patch fixes this (similar to 2.4 where pci/ is already 
visited for !CONFIG_BLK_DEV_IDEPCI):

--- linux-2.5.56/drivers/ide/Makefile.old	2003-01-11 13:52:30.000000000 +0100
+++ linux-2.5.56/drivers/ide/Makefile	2003-01-11 13:52:51.000000000 +0100
@@ -10,7 +10,7 @@
 export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o
 
 # First come modules that register themselves with the core
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= pci/
+obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
 
 # Core IDE code - must come before legacy
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

