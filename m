Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTHHNMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTHHNMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:12:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271313AbTHHNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:11:03 -0400
Date: Fri, 8 Aug 2003 15:10:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [2.4 patch] fix cmd640 with modular IDE
Message-ID: <20030808131054.GT16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

2.4.22-rc1 with CONFIG_BLK_DEV_IDE=m and CONFIG_BLK_DEV_CMD640=y results 
in an unresolved reference to init_cmd640_vlb when depmod runs.

The patch below fixes this.

I've only tested the compilation, if it's not possible to use the 
CMD640 support modular, I'll send another patch that only adds the 
dependency on CONFIG_BLK_DEV_IDE (and therefore CMD640 will be 
unusable with modular IDE).


--- linux-2.4.22-rc1-modular/drivers/ide/Config.in.old	2003-08-08 01:27:27.000000000 +0200
+++ linux-2.4.22-rc1-modular/drivers/ide/Config.in	2003-08-08 01:30:35.000000000 +0200
@@ -27,8 +27,10 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86 $CONFIG_BLK_DEV_IDE
+      if [ "$CONFIG_BLK_DEV_CMD640" != "n" ]; then
+         bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED
+      fi
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

