Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbSJJTsx>; Thu, 10 Oct 2002 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSJJTsx>; Thu, 10 Oct 2002 15:48:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:785 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262167AbSJJTsc>;
	Thu, 10 Oct 2002 15:48:32 -0400
Date: Thu, 10 Oct 2002 21:52:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: drivers/{atm,char,pci,video,zorro}: ditributed clean
Message-ID: <20021010215252.C577@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021010213440.A508@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021010213440.A508@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 10, 2002 at 09:34:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748.1.2 -> 1.748.1.3
#	drivers/atm/Makefile	1.12    -> 1.13   
#	            Makefile	1.320   -> 1.321  
#	drivers/video/Makefile	1.36    -> 1.37   
#	drivers/zorro/Makefile	1.6     -> 1.7    
#	drivers/pci/Makefile	1.15    -> 1.16   
#	drivers/char/Makefile	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	sam@mars.ravnborg.org	1.748.1.3
# drivers/{atm,char,pci,video,zorro}: ditributed clean
# Move list of files to be deleted during make clean out where
# they are made. host-progs files taken care of automagically
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Oct 10 21:22:24 2002
+++ b/Makefile	Thu Oct 10 21:22:24 2002
@@ -673,14 +673,8 @@
 CLEAN_FILES += \
 	include/linux/compile.h \
 	vmlinux System.map \
-	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
-	drivers/char/conmakehash \
 	drivers/char/drm/*-mod.c \
-	drivers/char/defkeymap.c drivers/char/qtronixmap.c \
-	drivers/pci/devlist.h drivers/pci/classlist.h drivers/pci/gen-devlist \
-	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	sound/oss/bin2hex sound/oss/hex2hex \
-	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
 	net/802/cl2llc.c net/802/transit/pdutr.h net/802/transit/timertr.h \
 	net/802/pseudo/pseudocode.h \
 	net/khttpd/make_times_h net/khttpd/times.h \
@@ -698,7 +692,6 @@
 	sound/oss/msndperm.c \
 	sound/oss/pndsperm.c \
 	sound/oss/pndspini.c \
-	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
 	.version .config* config.in config.old \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
diff -Nru a/drivers/atm/Makefile b/drivers/atm/Makefile
--- a/drivers/atm/Makefile	Thu Oct 10 21:22:24 2002
+++ b/drivers/atm/Makefile	Thu Oct 10 21:22:24 2002
@@ -8,6 +8,10 @@
 fore_200e-objs	:= fore200e.o
 host-progs	:= fore200e_mkfirm
 
+# Files generated that shall be removed upon make clean
+clean-files := {atmsar11,pca200e,pca200e_ecd,sba200e_ecd}.{bin,bin1,bin2}
+# Firmware generated that shall be removed upon make clean
+clean-files += fore200e_pca_fw.c fore200e_sba_fw.c
 
 obj-$(CONFIG_ATM_ZATM)		+= zatm.o uPD98402.o
 obj-$(CONFIG_ATM_NICSTAR)	+= nicstar.o
@@ -61,6 +65,6 @@
 	  -i $(CONFIG_ATM_FORE200E_SBA_FW) -o $@
 
 # deal with the various suffixes of the binary firmware images
-$(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(obj)/%.data
+$(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data
 	objcopy -Iihex $< -Obinary $@.gz
 	gzip -df $@.gz
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Thu Oct 10 21:22:24 2002
+++ b/drivers/char/Makefile	Thu Oct 10 21:22:24 2002
@@ -103,6 +103,9 @@
 obj-$(CONFIG_DRM) += drm/
 obj-$(CONFIG_PCMCIA) += pcmcia/
 
+# Files generated that shall be removed upon make clean
+clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Thu Oct 10 21:22:24 2002
+++ b/drivers/pci/Makefile	Thu Oct 10 21:22:24 2002
@@ -31,6 +31,9 @@
 
 host-progs := gen-devlist
 
+# Files generated that shall be removed upon make clean
+clean-files := devlist.h classlist.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generated files need to be listed explicitly
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	Thu Oct 10 21:22:24 2002
+++ b/drivers/video/Makefile	Thu Oct 10 21:22:24 2002
@@ -119,6 +119,9 @@
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
 obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
 
+# Files generated that shall be removed upon make clean
+clean-files := promcon_tbl.c
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/promcon_tbl.c: $(src)/prom.uni
diff -Nru a/drivers/zorro/Makefile b/drivers/zorro/Makefile
--- a/drivers/zorro/Makefile	Thu Oct 10 21:22:24 2002
+++ b/drivers/zorro/Makefile	Thu Oct 10 21:22:24 2002
@@ -9,6 +9,9 @@
 
 host-progs 		:= gen-devlist
 
+# Files generated that shall be removed upon make clean
+clean-files := devlist.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generated files need to be listed explicitly
