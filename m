Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274553AbRIYHyH>; Tue, 25 Sep 2001 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274554AbRIYHx6>; Tue, 25 Sep 2001 03:53:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:50934 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274553AbRIYHxk>; Tue, 25 Sep 2001 03:53:40 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BAFC969.52B7FCDC@eyal.emu.id.au> 
In-Reply-To: <3BAFC969.52B7FCDC@eyal.emu.id.au>  <Pine.LNX.4.30.0109242233150.18098-100000@Appserv.suse.de> 
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compilation fix for nand.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 08:53:54 +0100
Message-ID: <15588.1001404434@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


eyal@eyal.emu.id.au said:
>  This is not a full solution though: 

This is also already fixed.

Index: drivers/mtd/nand/Config.in
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/nand/Attic/Config.in,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 Config.in
--- drivers/mtd/nand/Config.in	2001/09/19 08:35:21	1.1.2.4
+++ drivers/mtd/nand/Config.in	2001/09/25 07:52:18
@@ -1,6 +1,6 @@
 # drivers/mtd/nand/Config.in
 
-# $Id: Config.in,v 1.3 2001/07/03 17:50:56 sjhill Exp $
+# $Id: Config.in,v 1.4 2001/09/19 09:35:23 dwmw2 Exp $
 
 mainmenu_option next_comment
 
Index: drivers/mtd/nand/Makefile
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/nand/Attic/Makefile,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 Makefile
--- drivers/mtd/nand/Makefile	2001/07/03 07:56:53	1.1.2.3
+++ drivers/mtd/nand/Makefile	2001/09/25 07:52:18
@@ -1,14 +1,16 @@
 #
 # linux/drivers/nand/Makefile
 #
-# $Id: Makefile,v 1.4 2001/06/28 10:49:45 dwmw2 Exp $
+# $Id: Makefile,v 1.5 2001/09/19 22:39:59 dwmw2 Exp $
 
 O_TARGET	:= nandlink.o
 
 export-objs	:= nand.o nand_ecc.o
 
-obj-$(CONFIG_MTD_NAND)		+= nand.o
-obj-$(CONFIG_MTD_NAND_ECC)	+= nand_ecc.o
+nandobjs-y			:= nand.o
+nandobjs-$(CONFIG_MTD_NAND_ECC) += nand_ecc.o
+
+obj-$(CONFIG_MTD_NAND)		+= $(nandobjs-y)
 obj-$(CONFIG_MTD_NAND_SPIA)	+= spia.o
 
 include $(TOPDIR)/Rules.make
Index: drivers/mtd/nand/nand.c
===================================================================
RCS file: /inst/cvs/linux/drivers/mtd/nand/Attic/nand.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 nand.c
--- drivers/mtd/nand/nand.c	2001/06/13 06:41:34	1.1.2.2
+++ drivers/mtd/nand/nand.c	2001/09/25 07:52:18
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2000 Steven J. Hill (sjhill@cotw.com)
  *
- * $Id: nand.c,v 1.10 2001/03/20 07:26:01 dwmw2 Exp $
+ * $Id: nand.c,v 1.11 2001/09/02 15:32:25 dwmw2 Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,6 +21,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ids.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_MTD_NAND_ECC

--
dwmw2


