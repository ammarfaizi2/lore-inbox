Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277322AbRJEHBW>; Fri, 5 Oct 2001 03:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277323AbRJEHBM>; Fri, 5 Oct 2001 03:01:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:57844 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277322AbRJEHBG>; Fri, 5 Oct 2001 03:01:06 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3982.1002260102@kao2.melbourne.sgi.com> 
In-Reply-To: <3982.1002260102@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [patch] 2.4.11-pre4 EXPORT_SYMBOLS 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 08:01:13 +0100
Message-ID: <17653.1002265273@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
> Some developers are forgetting to update export-objs in the Makefile,
> the bug is silent until somebody compiles with modversions.  This
> patch catches missing Makefile changes.

Thanks. Patch below, which fixes this and also hides a couple of 
ARM-specific modules so you can't attempt to build them for other targets.

Index: drivers/mtd/chips/Makefile
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/Makefile,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- drivers/mtd/chips/Makefile	2001/09/02 18:57:01	1.6
+++ drivers/mtd/chips/Makefile	2001/10/05 06:53:51	1.7
@@ -1,11 +1,11 @@
 #
 # linux/drivers/chips/Makefile
 #
-# $Id: Makefile,v 1.6 2001/09/02 18:57:01 dwmw2 Exp $
+# $Id: Makefile,v 1.7 2001/10/05 06:53:51 dwmw2 Exp $
 
 O_TARGET	:= chipslink.o
 
-export-objs	:= chipreg.o
+export-objs	:= chipreg.o gen_probe.o
 
 #                       *** BIG UGLY NOTE ***
 #
Index: drivers/mtd/Config.in
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/Config.in,v
retrieving revision 1.70
retrieving revision 1.71
diff -u -r1.70 -r1.71
--- drivers/mtd/Config.in	2001/08/11 16:13:38	1.70
+++ drivers/mtd/Config.in	2001/10/03 11:38:38	1.71
@@ -1,5 +1,5 @@
 
-# $Id: Config.in,v 1.70 2001/08/11 16:13:38 dwmw2 Exp $
+# $Id: Config.in,v 1.71 2001/10/03 11:38:38 dwmw2 Exp $
 
 mainmenu_option next_comment
 comment 'Memory Technology Devices (MTD)'
@@ -13,8 +13,10 @@
    fi
    dep_tristate '  MTD partitioning support' CONFIG_MTD_PARTITIONS $CONFIG_MTD
    dep_tristate '  RedBoot partition table parsing' CONFIG_MTD_REDBOOT_PARTS $CONFIG_MTD_PARTITIONS
+if [ "$CONFIG_ARM" = "y" ]; then
    dep_tristate '  Compaq bootldr partition table parsing' CONFIG_MTD_BOOTLDR_PARTS $CONFIG_MTD_PARTITIONS
    dep_tristate '  ARM Firmware Suite partition parsing' CONFIG_MTD_AFS_PARTS $CONFIG_MTD_PARTITIONS
+fi
 
 comment 'User Modules And Translation Layers'
    dep_tristate '  Direct char device access to MTD devices' CONFIG_MTD_CHAR $CONFIG_MTD


--
dwmw2


