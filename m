Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTDFPLh (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTDFPLh (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:11:37 -0400
Received: from smtp-103.nerim.net ([62.4.16.103]:52752 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id S262989AbTDFPLg (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 11:11:36 -0400
Date: Sun, 6 Apr 2003 17:25:11 +0200
From: Jerome Chantelauze <jchantelauze@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [Patch 2.4.21-pre7] Old hard disk (MFM/RLL/IDE) driver not build.
Message-ID: <20030406152511.GA248@i486X33>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I applied Stephane Ouellette's patch on my linux 2.4.21-pre7. Now, the
kernel builds.

But, there's a problem with the IDE support (problem also present in
2.4.21-pre6, but not in 2.4.20).

I configure the kernel to use the "Old hard disk (MFM/RLL/IDE)" driver:

#
# IDE, ATA and ATAPI Block devices
#
# CONFIG_BLK_DEV_IDE is not set
CONFIG_BLK_DEV_HD_ONLY=y
CONFIG_BLK_DEV_HD=y
...

drivers/ide/Makefile does not compile the drivers/ide/legacy/ subdir and
generates an empty idedriver.o because CONFIG_BLK_DEV_IDE is not set.
Setting this option would result in a driver not compatible with my old
hardware.

The following patch fixes the problem, but is it ok ?

*** linux-2.4.21-pre7/drivers/ide/Makefile.orig Sat Apr  5 18:57:07 2003
--- linux-2.4.21-pre7/drivers/ide/Makefile      Sat Apr  5 19:16:48 2003
***************
*** 21,26 ****
--- 21,28 ----

  subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci

+ subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
+
  # First come modules that register themselves with the core

  ifeq ($(CONFIG_BLK_DEV_IDE),y)
***************
*** 48,53 ****
--- 50,59 ----
    obj-y               += legacy/idedriver-legacy.o
    obj-y               += ppc/idedriver-ppc.o
    obj-y               += arm/idedriver-arm.o
+ endif
+
+ ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
+   obj-y               += legacy/idedriver-legacy.o
  endif

  ifeq ($(CONFIG_BLK_DEV_IDE),y)


Regards.
--
Jerome Chantelauze.
