Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbREPR4R>; Wed, 16 May 2001 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbREPR4H>; Wed, 16 May 2001 13:56:07 -0400
Received: from fandango.cs.unitn.it ([193.205.199.228]:17939 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S262040AbREPRzt>; Wed, 16 May 2001 13:55:49 -0400
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200105161205.OAA13638@nikita.dz.net>
Subject: [PATCH] move aic7xxx ld in drivers/scsi/Makefile
To: alan@redhat.com
Date: Wed, 16 May 2001 14:05:16 +0200 (MEST)
CC: linux-kernel@vger.kernel.org, tmm@image.dk
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while examining the makefiles of kernel-2.4.4 I noticed that the top Makefile
contains a specific reference to the aic7xxx driver which should IMHO be
referenced only by the drivers/scsi/Makefile.
While this is not a real bug I suggest anyway the following patch which moves
the aic7xxx compilation entirely in the drivers/scsi makefile:

--- Makefile.orig	Sat May  5 11:58:47 2001
+++ Makefile	Wed May 16 09:39:37 2001
@@ -155,7 +155,6 @@
 DRIVERS-$(CONFIG_ATM) += drivers/atm/atm.o
 DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
 DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
-DRIVERS-$(CONFIG_SCSI_AIC7XXX) += drivers/scsi/aic7xxx/aic7xxx_drv.o
 DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
 
 ifneq ($(CONFIG_CD_NO_IDESCSI)$(CONFIG_BLK_DEV_IDECD)$(CONFIG_BLK_DEV_SR)$(CONFIG_PARIDE_PCD),)
--- drivers/scsi/Makefile.orig	Tue Mar 27 01:36:30 2001
+++ drivers/scsi/Makefile	Wed May 16 13:30:47 2001
@@ -33,6 +33,10 @@
 
 obj-$(CONFIG_SCSI)		+= scsi_mod.o
 
+ifeq ($(CONFIG_SCSI_AIC7XXX),y)
+  obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx/aic7xxx_mod.o
+endif
+
 obj-$(CONFIG_A4000T_SCSI)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A4091_SCSI)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_BLZ603EPLUS_SCSI)	+= amiga7xx.o	53c7xx.o
@@ -184,3 +188,6 @@
 sim710_u.h: sim710_d.h
 
 sim710.o : sim710_d.h
+
+aic7xxx/aic7xxx_mod.o:
+	make -C aic7xxx


-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@cs.unitn.it               |
|  Via Marconi, 141                phone: ++39-0461534251              |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                             pgp: see my www home page         |
+----------------------------------------------------------------------+
