Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUFUPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUFUPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUFUPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:38:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43738 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266274AbUFUPiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:38:25 -0400
Date: Mon, 21 Jun 2004 17:38:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Laurent Pinchart <laurent.pinchart@skynet.be>,
       Mailinglist <mjpeg-users@lists.sf.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let VIDEO_ZORAN depend on I2C_ALGOBIT
Message-ID: <20040621153817.GD28607@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile error occurs with VIDEO_ZORAN=y and I2C_ALGOBIT=n
in 2.6.7-mm1 (but it's not specific to -mm):

<--  snip  -->

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x3861d3): In function `zoran_register_i2c':
: undefined reference to `i2c_bit_add_bus'
drivers/built-in.o(.text+0x3861e9): In function `zoran_unregister_i2c':
: undefined reference to `i2c_bit_del_bus'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue:


--- linux-2.6.7-mm1-full/drivers/media/video/Kconfig.old	2004-06-21 17:35:29.000000000 +0200
+++ linux-2.6.7-mm1-full/drivers/media/video/Kconfig	2004-06-21 17:35:50.000000000 +0200
@@ -155,7 +155,7 @@
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C_ALGOBIT
 	help
 	  Say Y for support for MJPEG capture cards based on the Zoran
 	  36057/36067 PCI controller chipset. This includes the Iomega



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

