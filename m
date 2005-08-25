Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVHYFV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVHYFV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVHYFVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3532 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751554AbVHYFVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:46 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (14/22) oktagon makefile fix
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEN-0005dM-HE@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oktagon_esp is described as modular.  However, drivers/scsi/Makefile doesn't
handle it right - it's multi-object module, with one of the parts being
built from .S.  Current makefile tries to declare each part a module of
its own; that not only wouldn't work (oktagon_io.o doesn't have the right
parts for that), it actually doesn't even build since kbuild doesn't believe
in single-object modules built from .S.  Turned into proper multi-object
module...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-isa_type/drivers/scsi/Makefile RC13-rc7-oktagon/drivers/scsi/Makefile
--- RC13-rc7-isa_type/drivers/scsi/Makefile	2005-08-10 10:37:50.000000000 -0400
+++ RC13-rc7-oktagon/drivers/scsi/Makefile	2005-08-25 00:54:14.000000000 -0400
@@ -41,7 +41,7 @@
 obj-$(CONFIG_BLZ2060_SCSI)	+= NCR53C9x.o	blz2060.o
 obj-$(CONFIG_BLZ1230_SCSI)	+= NCR53C9x.o	blz1230.o
 obj-$(CONFIG_FASTLANE_SCSI)	+= NCR53C9x.o	fastlane.o
-obj-$(CONFIG_OKTAGON_SCSI)	+= NCR53C9x.o	oktagon_esp.o	oktagon_io.o
+obj-$(CONFIG_OKTAGON_SCSI)	+= NCR53C9x.o	oktagon_esp_mod.o
 obj-$(CONFIG_ATARI_SCSI)	+= atari_scsi.o
 obj-$(CONFIG_MAC_SCSI)		+= mac_scsi.o
 obj-$(CONFIG_SCSI_MAC_ESP)	+= mac_esp.o	NCR53C9x.o
@@ -160,6 +160,7 @@
 cpqfc-objs	:= cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o \
 		   cpqfcTSworker.o cpqfcTStrigger.o
 libata-objs	:= libata-core.o libata-scsi.o
+oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
 clean-files :=	53c7xx_d.h 53c700_d.h	\
