Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTL0TSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTL0TSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 14:18:38 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:36538 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264537AbTL0TRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 14:17:30 -0500
To: marcelo.tosatti@cyclades.com
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.x CONFIG_BLK_DEV_IDE_MODES long dead
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 27 Dec 2003 20:12:10 +0100
Message-ID: <m3pteaoz1x.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

It looks CONFIG_BLK_DEV_IDE_MODES has been killed by patch-2.4.21.
The attached patch removes the zombies from 2.4.24pre2 kernel.

2.6 kernel is already free of them.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=CONFIG_BLK_DEV_IDE_MODES.patch

--- linux-2.4.orig/drivers/ide/Config.in	2003-11-28 19:26:20.000000000 +0100
+++ linux-2.4/drivers/ide/Config.in	2003-12-27 19:50:14.000000000 +0100
@@ -184,41 +187,6 @@
 ##  dep_mbool CONFIG_BLK_DEV_NTF_DISK $CONFIG_BLK_DEV_IDEDISK
 ##fi
 
-if [ "$CONFIG_BLK_DEV_4DRIVES" = "y" -o \
-     "$CONFIG_BLK_DEV_ALI14XX" != "n" -o \
-     "$CONFIG_BLK_DEV_DTC2278" != "n" -o \
-     "$CONFIG_BLK_DEV_HT6560B" != "n" -o \
-     "$CONFIG_BLK_DEV_PDC4030" != "n" -o \
-     "$CONFIG_BLK_DEV_QD65XX" != "n" -o \
-     "$CONFIG_BLK_DEV_UMC8672" != "n" -o \
-     "$CONFIG_BLK_DEV_AEC62XX" = "y" -o \
-     "$CONFIG_BLK_DEV_ALI15X3" = "y" -o \
-     "$CONFIG_BLK_DEV_AMD74XX" = "y" -o \
-     "$CONFIG_BLK_DEV_CMD640" = "y" -o \
-     "$CONFIG_BLK_DEV_CMD64X" = "y" -o \
-     "$CONFIG_BLK_DEV_CS5530" = "y" -o \
-     "$CONFIG_BLK_DEV_CY82C693" = "y" -o \
-     "$CONFIG_BLK_DEV_HPT34X" = "y" -o \
-     "$CONFIG_BLK_DEV_HPT366" = "y" -o \
-     "$CONFIG_BLK_DEV_IDE_PMAC" = "y" -o \
-     "$CONFIG_BLK_DEV_IT8172" = "y" -o \
-     "$CONFIG_BLK_DEV_MPC8xx_IDE" = "y" -o \
-     "$CONFIG_BLK_DEV_NFORCE" = "y" -o \
-     "$CONFIG_BLK_DEV_OPTI621" = "y" -o \
-     "$CONFIG_BLK_DEV_SVWKS" = "y" -o \
-     "$CONFIG_BLK_DEV_PDC202XX" = "y" -o \
-     "$CONFIG_BLK_DEV_PIIX" = "y" -o \
-     "$CONFIG_BLK_DEV_SVWKS" = "y" -o \
-     "$CONFIG_BLK_DEV_SIIMAGE" = "y" -o \
-     "$CONFIG_BLK_DEV_SIS5513" = "y" -o \
-     "$CONFIG_BLK_DEV_SL82C105" = "y" -o \
-     "$CONFIG_BLK_DEV_SLC90E66" = "y" -o \
-     "$CONFIG_BLK_DEV_VIA82CXXX" = "y" ]; then
-   define_bool CONFIG_BLK_DEV_IDE_MODES y
-else
-   define_bool CONFIG_BLK_DEV_IDE_MODES n
-fi
-
 dep_tristate 'Support for IDE Raid controllers (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL
 dep_tristate '   Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_PDC $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
 dep_tristate '   Highpoint 370 software RAID (EXPERIMENTAL)' CONFIG_BLK_DEV_ATARAID_HPT $CONFIG_BLK_DEV_IDE $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_ATARAID
--- linux-2.4.orig/arch/sh64/defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/sh64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -171,7 +171,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/sh64/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/sh64/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -175,7 +175,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-   define_bool CONFIG_BLK_DEV_IDE_MODES n
    define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/x86_64/defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/x86_64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -272,7 +272,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/x86_64/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/x86_64/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -139,7 +139,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/ppc64/defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -226,7 +226,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc64/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc64/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -120,7 +120,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/ppc64/configs/pSeries_defconfig	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4/arch/ppc64/configs/pSeries_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -228,7 +228,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc64/configs/iSeries_nodevfs_ideemul_defconfig	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4/arch/ppc64/configs/iSeries_nodevfs_ideemul_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -167,7 +167,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc64/configs/iSeries_devfs_defconfig	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4/arch/ppc64/configs/iSeries_devfs_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -143,7 +143,6 @@
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/i386/defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/i386/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -288,7 +288,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/i386/config.in	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/i386/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -371,7 +371,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
    source drivers/ide/Config.in
 else
-   define_bool CONFIG_BLK_DEV_IDE_MODES n
    define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/alpha/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/alpha/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -341,7 +341,6 @@
   int '  Maximum IDE interfaces' MAX_HWIFS 4
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/alpha/defconfig	2003-06-13 16:51:29.000000000 +0200
+++ linux-2.4/arch/alpha/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -270,7 +270,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/sparc/config.in	2003-12-25 21:41:55.000000000 +0100
+++ linux-2.4/arch/sparc/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -127,14 +127,12 @@
   if [ "$CONFIG_IDE" != "n" ]; then
     source drivers/ide/Config.in
   else
-    define_bool CONFIG_BLK_DEV_IDE_MODES n
     define_bool CONFIG_BLK_DEV_HD n
   fi
   endmenu
 else
 
   define_bool CONFIG_IDE n
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 
--- linux-2.4.orig/arch/sparc/defconfig	2003-12-25 21:41:55.000000000 +0100
+++ linux-2.4/arch/sparc/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -201,7 +201,6 @@
 #
 CONFIG_NET_PKTGEN=m
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/config-shared.in	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/config-shared.in	2003-12-27 19:49:57.000000000 +0100
@@ -982,7 +982,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
    source drivers/ide/Config.in
 else
-   define_bool CONFIG_BLK_DEV_IDE_MODES n
    define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/mips/defconfig-xxs1500	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-xxs1500	2003-12-27 19:49:57.000000000 +0100
@@ -435,7 +435,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-workpad	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-workpad	2003-12-27 19:49:57.000000000 +0100
@@ -284,7 +284,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-ti1500	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ti1500	2003-12-27 19:49:57.000000000 +0100
@@ -398,7 +398,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-tb0229	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-tb0229	2003-12-27 19:49:57.000000000 +0100
@@ -262,7 +262,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-tb0226	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-tb0226	2003-12-27 19:49:57.000000000 +0100
@@ -260,7 +260,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-sead	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-sead	2003-12-27 19:49:57.000000000 +0100
@@ -200,7 +200,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-sb1250-swarm	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-sb1250-swarm	2003-12-27 19:49:57.000000000 +0100
@@ -315,7 +315,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-rm200	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-rm200	2003-12-27 19:49:57.000000000 +0100
@@ -259,7 +259,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-pb1500	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-pb1500	2003-12-27 19:49:57.000000000 +0100
@@ -437,7 +437,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-pb1100	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-pb1100	2003-12-27 19:49:57.000000000 +0100
@@ -384,7 +384,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-pb1000	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-pb1000	2003-12-27 19:49:57.000000000 +0100
@@ -383,7 +383,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-osprey	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-osprey	2003-12-27 19:49:57.000000000 +0100
@@ -257,7 +257,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-ocelot	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ocelot	2003-12-27 19:49:57.000000000 +0100
@@ -334,7 +334,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-nino	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-nino	2003-12-27 19:49:57.000000000 +0100
@@ -258,7 +258,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-mtx-1	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-mtx-1	2003-12-27 19:49:57.000000000 +0100
@@ -348,7 +348,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-mpc30x	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-mpc30x	2003-12-27 19:49:57.000000000 +0100
@@ -261,7 +261,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-mirage	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-mirage	2003-12-27 19:49:57.000000000 +0100
@@ -290,7 +290,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-malta	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-malta	2003-12-27 19:49:57.000000000 +0100
@@ -267,7 +267,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-lasat	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-lasat	2003-12-27 19:49:57.000000000 +0100
@@ -397,7 +397,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-jmr3927	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-jmr3927	2003-12-27 19:49:57.000000000 +0100
@@ -257,7 +257,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-ivr	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ivr	2003-12-27 19:49:57.000000000 +0100
@@ -325,7 +325,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-it8172	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-it8172	2003-12-27 19:49:57.000000000 +0100
@@ -400,7 +400,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-ip22	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ip22	2003-12-27 19:49:57.000000000 +0100
@@ -267,7 +267,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-hp-lj	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-hp-lj	2003-12-27 19:49:57.000000000 +0100
@@ -400,7 +400,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-ev96100	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ev96100	2003-12-27 19:49:57.000000000 +0100
@@ -263,7 +263,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-ev64120	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ev64120	2003-12-27 19:49:57.000000000 +0100
@@ -260,7 +260,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-eagle	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-eagle	2003-12-27 19:49:57.000000000 +0100
@@ -383,7 +383,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-e55	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-e55	2003-12-27 19:49:57.000000000 +0100
@@ -284,7 +284,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-decstation	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-decstation	2003-12-27 19:49:57.000000000 +0100
@@ -254,7 +254,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-ddb5477	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ddb5477	2003-12-27 19:49:57.000000000 +0100
@@ -258,7 +258,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-ddb5476	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-ddb5476	2003-12-27 19:49:57.000000000 +0100
@@ -325,7 +325,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-db1500	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-db1500	2003-12-27 19:49:57.000000000 +0100
@@ -366,7 +366,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-db1100	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-db1100	2003-12-27 19:49:57.000000000 +0100
@@ -400,7 +400,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-db1000	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-db1000	2003-12-27 19:49:57.000000000 +0100
@@ -401,7 +401,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-cobalt	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-cobalt	2003-12-27 19:49:57.000000000 +0100
@@ -320,7 +320,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-capcella	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-capcella	2003-12-27 19:49:57.000000000 +0100
@@ -291,7 +291,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-bosporus	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-bosporus	2003-12-27 19:49:57.000000000 +0100
@@ -399,7 +399,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-atlas	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-atlas	2003-12-27 19:49:57.000000000 +0100
@@ -265,7 +265,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -267,7 +267,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-csb250	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-csb250	2003-12-27 19:49:57.000000000 +0100
@@ -367,7 +367,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-hydrogen3	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-hydrogen3	2003-12-27 19:49:57.000000000 +0100
@@ -400,7 +400,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips/defconfig-rbtx4927	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-rbtx4927	2003-12-27 19:49:57.000000000 +0100
@@ -255,7 +255,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips/defconfig-yosemite	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips/defconfig-yosemite	2003-12-27 19:49:57.000000000 +0100
@@ -256,7 +256,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/config.in	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ppc/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -423,7 +423,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/ppc/defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -308,7 +308,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/rpxlite_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/rpxlite_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -190,7 +190,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/rpxcllf_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/rpxcllf_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -190,7 +190,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/ocotea_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/ocotea_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -183,7 +183,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/mbx_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/mbx_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -177,7 +177,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/ebony_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/ebony_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -182,7 +182,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/bseip_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/bseip_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -180,7 +180,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/apus_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/apus_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -290,7 +290,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/TQM860L_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/TQM860L_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -215,7 +215,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/TQM850L_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/TQM850L_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -181,7 +181,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/TQM823L_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/TQM823L_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -181,7 +181,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/SPD823TS_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/SPD823TS_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -180,7 +180,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/SM850_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/SM850_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -181,7 +181,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/IVMS8_defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/ppc/configs/IVMS8_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -214,7 +214,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/walnut_defconfig	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4/arch/ppc/configs/walnut_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -172,7 +172,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/pplus_defconfig	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4/arch/ppc/configs/pplus_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -299,7 +299,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/spruce_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/spruce_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -172,7 +172,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/power3_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/power3_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -180,7 +180,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/pmac_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/pmac_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -312,7 +312,6 @@
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
 CONFIG_BLK_DEV_PDC202XX=y
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/pal4_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/pal4_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -225,7 +225,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/oak_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/oak_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -164,7 +164,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/ibmchrp_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/ibmchrp_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -226,7 +226,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/gemini_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/gemini_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -182,7 +182,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/est8260_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/est8260_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -163,7 +163,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/ppc/configs/common_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/common_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -308,7 +308,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ppc/configs/briq_defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/ppc/configs/briq_defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -300,7 +300,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/m68k/defconfig	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/m68k/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -124,7 +124,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/m68k/config.in	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/m68k/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -185,7 +185,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/sparc64/defconfig	2003-12-25 21:41:55.000000000 +0100
+++ linux-2.4/arch/sparc64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -450,7 +450,6 @@
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
 CONFIG_BLK_DEV_PDC202XX=y
-CONFIG_BLK_DEV_IDE_MODES=y
 CONFIG_BLK_DEV_ATARAID=m
 CONFIG_BLK_DEV_ATARAID_PDC=m
 CONFIG_BLK_DEV_ATARAID_HPT=m
--- linux-2.4.orig/arch/sparc64/config.in	2003-12-25 21:41:55.000000000 +0100
+++ linux-2.4/arch/sparc64/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -132,7 +132,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/arm/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/arm/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -585,7 +585,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/arm/defconfig	2001-05-20 02:43:05.000000000 +0200
+++ linux-2.4/arch/arm/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -303,7 +303,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/riscstation	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/riscstation	2003-12-27 19:49:57.000000000 +0100
@@ -372,7 +372,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/omaha	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/omaha	2003-12-27 19:49:57.000000000 +0100
@@ -358,7 +358,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/nanoengine	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/nanoengine	2003-12-27 19:49:57.000000000 +0100
@@ -413,7 +413,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/lusl7200	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/lusl7200	2003-12-27 19:49:57.000000000 +0100
@@ -161,7 +161,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/graphicsmaster	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/graphicsmaster	2003-12-27 19:49:57.000000000 +0100
@@ -535,7 +535,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/graphicsclient	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/graphicsclient	2003-12-27 19:49:57.000000000 +0100
@@ -533,7 +533,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/frodo	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/frodo	2003-12-27 19:49:57.000000000 +0100
@@ -462,7 +462,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/epxa1db	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/epxa1db	2003-12-27 19:49:57.000000000 +0100
@@ -404,7 +404,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/epxa10db	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/epxa10db	2003-12-27 19:49:57.000000000 +0100
@@ -422,7 +422,6 @@
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/cep	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/cep	2003-12-27 19:49:57.000000000 +0100
@@ -303,7 +303,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/at91rm9200dk	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/at91rm9200dk	2003-12-27 19:49:57.000000000 +0100
@@ -426,7 +426,6 @@
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/adsbitsyplus	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/adsbitsyplus	2003-12-27 19:49:57.000000000 +0100
@@ -535,7 +535,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/adsbitsy	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/adsbitsy	2003-12-27 19:49:57.000000000 +0100
@@ -535,7 +535,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/adsagc	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/adsagc	2003-12-27 19:49:57.000000000 +0100
@@ -535,7 +535,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/accelent_sa	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/accelent_sa	2003-12-27 19:49:57.000000000 +0100
@@ -506,7 +506,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/footbridge	2003-06-13 16:51:29.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/footbridge	2003-12-27 19:49:57.000000000 +0100
@@ -437,7 +437,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/badge4	2003-06-13 16:51:29.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/badge4	2003-12-27 19:49:57.000000000 +0100
@@ -527,7 +527,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/system3	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/system3	2003-12-27 19:49:57.000000000 +0100
@@ -496,7 +496,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/shark	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/shark	2003-12-27 19:49:57.000000000 +0100
@@ -391,7 +391,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/shannon	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/shannon	2003-12-27 19:49:57.000000000 +0100
@@ -387,7 +387,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/rpc	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/rpc	2003-12-27 19:49:57.000000000 +0100
@@ -412,7 +412,6 @@
 CONFIG_IDEDMA_AUTO=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/pleb	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pleb	2003-12-27 19:49:57.000000000 +0100
@@ -331,7 +331,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/pfs168_satft	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pfs168_satft	2003-12-27 19:49:57.000000000 +0100
@@ -458,7 +458,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/pfs168_sastn	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pfs168_sastn	2003-12-27 19:49:57.000000000 +0100
@@ -459,7 +459,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/pfs168_mqvga	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pfs168_mqvga	2003-12-27 19:49:57.000000000 +0100
@@ -458,7 +458,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/pfs168_mqtft	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pfs168_mqtft	2003-12-27 19:49:57.000000000 +0100
@@ -458,7 +458,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/pangolin	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/pangolin	2003-12-27 19:49:57.000000000 +0100
@@ -434,7 +434,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/neponset	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/neponset	2003-12-27 19:49:57.000000000 +0100
@@ -455,7 +455,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/lart	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/lart	2003-12-27 19:49:57.000000000 +0100
@@ -484,7 +484,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/jornada720	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/jornada720	2003-12-27 19:49:57.000000000 +0100
@@ -482,7 +482,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/integrator	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/integrator	2003-12-27 19:49:57.000000000 +0100
@@ -410,7 +410,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/h3600	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/h3600	2003-12-27 19:49:57.000000000 +0100
@@ -482,7 +482,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/freebird_new	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/freebird_new	2003-12-27 19:49:57.000000000 +0100
@@ -398,7 +398,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/freebird	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/freebird	2003-12-27 19:49:57.000000000 +0100
@@ -384,7 +384,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/fortunet	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/fortunet	2003-12-27 19:49:57.000000000 +0100
@@ -295,7 +295,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/flexanet	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/flexanet	2003-12-27 19:49:57.000000000 +0100
@@ -479,7 +479,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/ebsa110	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/ebsa110	2003-12-27 19:49:57.000000000 +0100
@@ -387,7 +387,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/clps7500	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/clps7500	2003-12-27 19:49:57.000000000 +0100
@@ -298,7 +298,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/cerfpod	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/cerfpod	2003-12-27 19:49:57.000000000 +0100
@@ -475,7 +475,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/cerfpda	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/cerfpda	2003-12-27 19:49:57.000000000 +0100
@@ -504,7 +504,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/cerfcube	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/cerfcube	2003-12-27 19:49:57.000000000 +0100
@@ -474,7 +474,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/assabet	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/assabet	2003-12-27 19:49:57.000000000 +0100
@@ -493,7 +493,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/arm/def-configs/anakin	2002-08-03 02:39:42.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/anakin	2003-12-27 19:49:57.000000000 +0100
@@ -259,7 +259,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/a5k	2000-11-28 02:07:59.000000000 +0100
+++ linux-2.4/arch/arm/def-configs/a5k	2003-12-27 19:49:57.000000000 +0100
@@ -287,7 +287,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/brutus	2001-08-12 20:13:59.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/brutus	2003-12-27 19:49:57.000000000 +0100
@@ -123,7 +123,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/huw_webpanel	2001-08-12 20:13:59.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/huw_webpanel	2003-12-27 19:49:57.000000000 +0100
@@ -227,7 +227,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/arm/def-configs/omnimeter	2001-08-12 20:13:59.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/omnimeter	2003-12-27 19:49:57.000000000 +0100
@@ -314,7 +314,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/arm/def-configs/edb7211	2001-10-25 22:53:44.000000000 +0200
+++ linux-2.4/arch/arm/def-configs/edb7211	2003-12-27 19:49:57.000000000 +0100
@@ -225,7 +225,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/sh/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/sh/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -307,7 +307,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/sh/defconfig	2001-10-15 22:36:48.000000000 +0200
+++ linux-2.4/arch/sh/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -121,7 +121,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support
--- linux-2.4.orig/arch/ia64/defconfig	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -291,7 +291,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ia64/config.in	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/config.in	2003-12-27 19:49:57.000000000 +0100
@@ -147,7 +147,6 @@
   if [ "$CONFIG_IDE" != "n" ]; then
     source drivers/ide/Config.in
   else
-    define_bool CONFIG_BLK_DEV_IDE_MODES n
     define_bool CONFIG_BLK_DEV_HD n
   fi
   endmenu
--- linux-2.4.orig/arch/ia64/configs/zx1	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/configs/zx1	2003-12-27 19:49:57.000000000 +0100
@@ -291,7 +291,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ia64/configs/numa	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/configs/numa	2003-12-27 19:49:57.000000000 +0100
@@ -293,7 +293,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ia64/configs/generic	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/configs/generic	2003-12-27 19:49:57.000000000 +0100
@@ -291,7 +291,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/ia64/configs/dig	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/ia64/configs/dig	2003-12-27 19:49:57.000000000 +0100
@@ -290,7 +290,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-CONFIG_BLK_DEV_IDE_MODES=y
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/mips64/defconfig	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig	2003-12-27 19:49:57.000000000 +0100
@@ -247,7 +247,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-sead	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-sead	2003-12-27 19:49:58.000000000 +0100
@@ -198,7 +198,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-sb1250-swarm	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-sb1250-swarm	2003-12-27 19:49:58.000000000 +0100
@@ -284,7 +284,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-malta	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-malta	2003-12-27 19:49:58.000000000 +0100
@@ -265,7 +265,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-ip27	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-ip27	2003-12-27 19:49:58.000000000 +0100
@@ -247,7 +247,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-ip22	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-ip22	2003-12-27 19:49:58.000000000 +0100
@@ -267,7 +267,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-decstation	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-decstation	2003-12-27 19:49:58.000000000 +0100
@@ -255,7 +255,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-atlas	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-atlas	2003-12-27 19:49:58.000000000 +0100
@@ -262,7 +262,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-jaguar	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-jaguar	2003-12-27 19:49:58.000000000 +0100
@@ -256,7 +256,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/mips64/defconfig-ocelotc	2003-12-25 21:41:54.000000000 +0100
+++ linux-2.4/arch/mips64/defconfig-ocelotc	2003-12-27 19:49:58.000000000 +0100
@@ -261,7 +261,6 @@
 # ATA/IDE/MFM/RLL support
 #
 # CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
--- linux-2.4.orig/arch/parisc/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/parisc/config.in	2003-12-27 19:49:58.000000000 +0100
@@ -116,7 +116,6 @@
     if [ "$CONFIG_IDE" != "n" ]; then
       source drivers/ide/Config.in
     else
-      define_bool CONFIG_BLK_DEV_IDE_MODES n
       define_bool CONFIG_BLK_DEV_HD n
     fi
     endmenu
--- linux-2.4.orig/arch/parisc/defconfig	2003-06-13 16:51:31.000000000 +0200
+++ linux-2.4/arch/parisc/defconfig	2003-12-27 19:49:58.000000000 +0100
@@ -245,7 +245,6 @@
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
--- linux-2.4.orig/arch/cris/config.in	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4/arch/cris/config.in	2003-12-27 19:49:58.000000000 +0100
@@ -184,7 +184,6 @@
 if [ "$CONFIG_IDE" != "n" ]; then
   source drivers/ide/Config.in
 else
-  define_bool CONFIG_BLK_DEV_IDE_MODES n
   define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
--- linux-2.4.orig/arch/cris/defconfig	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4/arch/cris/defconfig	2003-12-27 19:49:58.000000000 +0100
@@ -282,7 +282,6 @@
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_DMA_NONPCI is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
 
 #
 # SCSI support

--=-=-=--
