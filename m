Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbSITPNh>; Fri, 20 Sep 2002 11:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262770AbSITPNh>; Fri, 20 Sep 2002 11:13:37 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:4313 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S262760AbSITPNg>; Fri, 20 Sep 2002 11:13:36 -0400
Subject: [PATCH] 2.5.36-bk3 fix build error with CONFIG_EEPRO100=y.
From: Steven Cole <elenstev@mesatop.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Sep 2002 09:14:52 -0600
Message-Id: <1032534892.14946.156.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes this error with 2.5.36-bk3 and 
CONFIG_EEPRO100=y:

drivers/built-in.o: In function `netdev_ethtool_ioctl':
drivers/built-in.o(.text+0x28891): undefined reference to `mii_ethtool_gset'
drivers/built-in.o(.text+0x2896f): undefined reference to `mii_ethtool_sset'
drivers/built-in.o(.text+0x289ab): undefined reference to `mii_nway_restart'
drivers/built-in.o(.text+0x289d5): undefined reference to `mii_link_ok'
make: *** [vmlinux] Error 1

--- linux-2.5.36-bk3/drivers/net/Makefile.orig	Fri Sep 20 09:03:52 2002
+++ linux-2.5.36-bk3/drivers/net/Makefile	Fri Sep 20 09:04:17 2002
@@ -41,7 +41,7 @@
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
 obj-$(CONFIG_PCNET32) += pcnet32.o mii.o
-obj-$(CONFIG_EEPRO100) += eepro100.o
+obj-$(CONFIG_EEPRO100) += eepro100.o mii.o
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_EPIC100) += epic100.o mii.o
 obj-$(CONFIG_SIS900) += sis900.o


