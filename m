Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271109AbRICDHn>; Sun, 2 Sep 2001 23:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRICDHW>; Sun, 2 Sep 2001 23:07:22 -0400
Received: from dspnet.claranet.fr ([212.43.196.92]:61188 "HELO
	dspnet.fr.eu.org") by vger.kernel.org with SMTP id <S271109AbRICDHT>;
	Sun, 2 Sep 2001 23:07:19 -0400
Date: Mon, 3 Sep 2001 05:07:37 +0200
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: make xconfig problems
Message-ID: <20010903050737.A1223@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Due to inexistant config.in files, make xconfig fail for the following architectures :
* arm
* cris
* mips
* mips64
* sh

Here is a patch for the 2.4.9 kernel :
(a patch for the ac serie follows)

------------------------------------------------------------------------------
diff -u --new-file --recursive linux-2.4.9-vanilla/arch/arm/config.in linux-2.4.9/arch/arm/config.in
--- linux-2.4.9-vanilla/arch/arm/config.in      Mon Aug 13 02:36:24 2001
+++ linux-2.4.9/arch/arm/config.in      Mon Sep  3 04:22:28 2001
@@ -423,9 +423,9 @@
 fi
 endmenu
 
-if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-   source drivers/ssi/Config.in
-fi
+#if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
+#   source drivers/ssi/Config.in
+#fi
 
 source drivers/ieee1394/Config.in
 
diff -u --new-file --recursive linux-2.4.9-vanilla/arch/cris/drivers/Config.in linux-2.4.9/arch/cris/drivers/Config.in
--- linux-2.4.9-vanilla/arch/cris/drivers/Config.in     Wed Jul  4 20:50:38 2001
+++ linux-2.4.9/arch/cris/drivers/Config.in     Mon Sep  3 04:23:33 2001
@@ -166,9 +166,9 @@
 
 bool 'ARTPEC-1 support' CONFIG_JULIETTE
 
-if [ "$CONFIG_JULIETTE" = "y" ]; then
-   source arch/cris/drivers/juliette/Config.in
-fi
+#if [ "$CONFIG_JULIETTE" = "y" ]; then
+#   source arch/cris/drivers/juliette/Config.in
+#fi
 
 bool 'USB host' CONFIG_ETRAX_USB_HOST
 if [ "$CONFIG_ETRAX_USB_HOST" = "y" ]; then
diff -u --new-file --recursive linux-2.4.9-vanilla/arch/mips/config.in linux-2.4.9/arch/mips/config.in
--- linux-2.4.9-vanilla/arch/mips/config.in     Mon Jul  2 22:56:40 2001
+++ linux-2.4.9/arch/mips/config.in     Mon Sep  3 04:25:59 2001
@@ -361,7 +361,7 @@
 
 if [ "$CONFIG_DECSTATION" != "y" -a \
      "$CONFIG_SGI_IP22" != "y" ]; then
-   source drivers/message/i2o/Config.in
+   source drivers/i2o/Config.in
 fi
 
 if [ "$CONFIG_NET" = "y" ]; then
diff -u --new-file --recursive linux-2.4.9-vanilla/arch/mips64/config.in linux-2.4.9/arch/mips64/config.in
--- linux-2.4.9-vanilla/arch/mips64/config.in   Wed Jul  4 20:50:39 2001
+++ linux-2.4.9/arch/mips64/config.in   Mon Sep  3 04:26:09 2001
@@ -177,7 +177,7 @@
 fi
 endmenu
 
-source drivers/message/i2o/Config.in
+source drivers/i2o/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
    mainmenu_option next_comment
diff -u --new-file --recursive linux-2.4.9-vanilla/arch/sh/config.in linux-2.4.9/arch/sh/config.in
--- linux-2.4.9-vanilla/arch/sh/config.in       Wed Jun 27 22:55:29 2001
+++ linux-2.4.9/arch/sh/config.in       Mon Sep  3 04:27:13 2001
@@ -229,9 +229,9 @@
 #
 source drivers/input/Config.in
 
-if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
-source drivers/maple/Config.in
-fi
+#if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
+#source drivers/maple/Config.in
+#fi
 
 mainmenu_option next_comment
 comment 'Character devices'
------------------------------------------------------------------------------------

And here is the same for 2.4.9 ac6 :

------------------------------------------------------------------------------------
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/arm/config.in linux-2.4.9-ac6/arch/arm/config.in
--- linux-2.4.9-ac6-vanilla/arch/arm/config.in  Mon Sep  3 04:49:50 2001
+++ linux-2.4.9-ac6/arch/arm/config.in  Mon Sep  3 04:51:25 2001
@@ -423,13 +423,13 @@
 fi
 endmenu
 
-if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-   source drivers/ssi/Config.in
-fi
+#if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
+#   source drivers/ssi/Config.in
+#fi
 
 source drivers/ieee1394/Config.in
 
-source drivers/i2o/Config.in
+source drivers/message/i2o/Config.in
 
 mainmenu_option next_comment
 comment 'ISDN subsystem'
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/cris/config.in linux-2.4.9-ac6/arch/cris/config.in
--- linux-2.4.9-ac6-vanilla/arch/cris/config.in Mon Sep  3 04:49:54 2001
+++ linux-2.4.9-ac6/arch/cris/config.in Mon Sep  3 04:54:02 2001
@@ -173,7 +173,7 @@
 
 source drivers/ieee1394/Config.in
 
-source drivers/i2o/Config.in
+source drivers/message/i2o/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
   mainmenu_option next_comment
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/cris/drivers/Config.in linux-2.4.9-ac6/arch/cris/drivers/Config.in
--- linux-2.4.9-ac6-vanilla/arch/cris/drivers/Config.in Mon Sep  3 04:49:54 2001
+++ linux-2.4.9-ac6/arch/cris/drivers/Config.in Mon Sep  3 04:54:51 2001
@@ -166,9 +166,9 @@
 
 bool 'ARTPEC-1 support' CONFIG_JULIETTE
 
-if [ "$CONFIG_JULIETTE" = "y" ]; then
-   source arch/cris/drivers/juliette/Config.in
-fi
+#if [ "$CONFIG_JULIETTE" = "y" ]; then
+#   source arch/cris/drivers/juliette/Config.in
+#fi
 
 bool 'USB host' CONFIG_ETRAX_USB_HOST
 if [ "$CONFIG_ETRAX_USB_HOST" = "y" ]; then
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/mips/config.in linux-2.4.9-ac6/arch/mips/config.in
--- linux-2.4.9-ac6-vanilla/arch/mips/config.in Mon Sep  3 04:55:55 2001
+++ linux-2.4.9-ac6/arch/mips/config.in Mon Sep  3 04:53:34 2001
@@ -377,7 +377,7 @@
 
 if [ "$CONFIG_DECSTATION" != "y" -a \
      "$CONFIG_SGI_IP22" != "y" ]; then
-   source drivers/i2o/Config.in
+   source drivers/message/i2o/Config.in
 fi
 
 if [ "$CONFIG_NET" = "y" ]; then
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/sh/config.in linux-2.4.9-ac6/arch/sh/config.in
--- linux-2.4.9-ac6-vanilla/arch/sh/config.in   Mon Sep  3 04:49:51 2001
+++ linux-2.4.9-ac6/arch/sh/config.in   Mon Sep  3 04:55:06 2001
@@ -229,9 +229,9 @@
 #
 source drivers/input/Config.in
 
-if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
-source drivers/maple/Config.in
-fi
+#if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
+#source drivers/maple/Config.in
+#fi
 
 mainmenu_option next_comment
 comment 'Character devices'
-------------------------------------------------------------------------

And this one is an additionnal patch for the ac series. It's a cleanup of a config.in
file. (bool command should have 2 parameters, not 3)

---------------------------------------------------------------------------
diff -u --new-file --recursive linux-2.4.9-ac6-vanilla/arch/parisc/config.in linux-2.4.9-ac6/arch/parisc/config.in
--- linux-2.4.9-ac6-vanilla/arch/parisc/config.in       Mon Sep  3 04:49:54 2001
+++ linux-2.4.9-ac6/arch/parisc/config.in       Mon Sep  3 03:59:49 2001
@@ -27,14 +27,14 @@
 # bool 'GSC/Gecko bus support' CONFIG_GSC y
 define_bool CONFIG_GSC y
 
-bool 'U2/Uturn I/O MMU' CONFIG_IOMMU_CCIO y
-bool 'LASI I/O support' CONFIG_GSC_LASI y
+bool 'U2/Uturn I/O MMU' CONFIG_IOMMU_CCIO
+bool 'LASI I/O support' CONFIG_GSC_LASI
 
-bool 'PCI bus support' CONFIG_PCI y
+bool 'PCI bus support' CONFIG_PCI
 
 if [ "$CONFIG_PCI" = "y" ]; then
-       bool 'GSCtoPCI/DINO PCI support' CONFIG_GSC_DINO y
-       bool 'LBA/Elroy PCI support' CONFIG_PCI_LBA n
+       bool 'GSCtoPCI/DINO PCI support' CONFIG_GSC_DINO
+       bool 'LBA/Elroy PCI support' CONFIG_PCI_LBA
 fi 
 
 if [ "$CONFIG_PCI_LBA" = "y" ]; then
--------------------------------------------------------------------------

Thanks

	JL Leger


