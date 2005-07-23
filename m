Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVGWWJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVGWWJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGWWHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:07:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23812 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261901AbVGWWF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:05:29 -0400
Date: Sun, 24 Jul 2005 00:05:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] FB_INTEL must depend on HW_CONSOLE
Message-ID: <20050723220523.GM3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FB_INTEL=y and CONFIG_HW_CONSOLE results in the following compile 
error:

<--  snip  -->

...
  LD      vmlinux
drivers/built-in.o: In function `intelfb_pci_register':
intelfbdrv.c:(.text+0x171960): undefined reference to `color_table'
intelfbdrv.c:(.text+0x171971): undefined reference to `default_red'
intelfbdrv.c:(.text+0x17197e): undefined reference to `default_grn'
intelfbdrv.c:(.text+0x17198b): undefined reference to `default_blu'
intelfbdrv.c:(.text+0x17199a): undefined reference to `color_table'
make: *** [vmlinux] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/video/Kconfig.old	2005-07-23 22:12:18.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/video/Kconfig	2005-07-23 22:12:51.000000000 +0200
@@ -756,7 +756,7 @@
 
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
+	depends on FB && HW_CONSOLE && EXPERIMENTAL && PCI && X86 && !X86_64
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS

