Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319198AbSHNEc2>; Wed, 14 Aug 2002 00:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319199AbSHNEc2>; Wed, 14 Aug 2002 00:32:28 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:1418 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S319198AbSHNEcX>; Wed, 14 Aug 2002 00:32:23 -0400
Date: Tue, 13 Aug 2002 23:35:58 -0500
To: Greg Banks <gnb@alphalink.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814043558.GN761@cadcamlab.org>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20020814032841.GM761@cadcamlab.org>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here's another one - this should fix the forward dependency between
CONFIG_SOUND and CONFIG_SOUND_ACI_MIXER, by moving the sound config
into the "Multimedia" menu - where I think it belongs anyway.

The big loser here is ARM - it no longer suppresses the sound card
question for the appropriate boards.  But it's just one question, so I
didn't sweat it too much.

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="3.diff"

diff -urNXxpk 2.5.31-2/arch/alpha/config.in 2.5.31w/arch/alpha/config.in
--- 2.5.31-2/arch/alpha/config.in	2002-08-13 22:07:23.000000000 -0500
+++ 2.5.31w/arch/alpha/config.in	2002-08-13 22:38:58.000000000 -0500
@@ -366,15 +366,6 @@
   endmenu
 fi
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-  source sound/Config.in
-fi
-endmenu
-
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
diff -urNXxpk 2.5.31-2/arch/arm/config.in 2.5.31w/arch/arm/config.in
--- 2.5.31-2/arch/arm/config.in	2002-08-13 22:07:42.000000000 -0500
+++ 2.5.31w/arch/arm/config.in	2002-08-13 22:43:26.000000000 -0500
@@ -630,22 +630,6 @@
    endmenu
 fi
 
-if [ "$CONFIG_ARCH_ACORN" = "y" -o \
-     "$CONFIG_ARCH_CLPS7500" = "y" -o \
-     "$CONFIG_ARCH_TBOX" = "y" -o \
-     "$CONFIG_ARCH_SHARK" = "y" -o \
-     "$CONFIG_ARCH_SA1100" = "y" -o \
-     "$CONFIG_PCI" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Sound'
-
-   tristate 'Sound card support' CONFIG_SOUND
-   if [ "$CONFIG_SOUND" != "n" ]; then
-      source sound/Config.in
-   fi
-   endmenu
-fi
-
 source drivers/misc/Config.in
 
 source drivers/usb/Config.in
diff -urNXxpk 2.5.31-2/arch/cris/config.in 2.5.31w/arch/cris/config.in
--- 2.5.31-2/arch/cris/config.in	2002-08-13 22:08:01.000000000 -0500
+++ 2.5.31w/arch/cris/config.in	2002-08-13 22:43:45.000000000 -0500
@@ -205,15 +205,6 @@
 
 source fs/Config.in
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-  source sound/Config.in
-fi
-endmenu
-
 source drivers/usb/Config.in
 
 mainmenu_option next_comment
diff -urNXxpk 2.5.31-2/arch/i386/config.in 2.5.31w/arch/i386/config.in
--- 2.5.31-2/arch/i386/config.in	2002-08-13 22:05:49.000000000 -0500
+++ 2.5.31w/arch/i386/config.in	2002-08-13 23:06:04.000000000 -0500
@@ -385,15 +385,6 @@
    endmenu
 fi
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/Config.in
-fi
-endmenu
-
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
diff -urNXxpk 2.5.31-2/arch/ia64/config.in 2.5.31w/arch/ia64/config.in
--- 2.5.31-2/arch/ia64/config.in	2002-08-13 22:08:38.000000000 -0500
+++ 2.5.31w/arch/ia64/config.in	2002-08-13 22:44:28.000000000 -0500
@@ -217,15 +217,6 @@
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-  source sound/Config.in
-fi
-endmenu
-
 source drivers/usb/Config.in
 
 source lib/Config.in
diff -urNXxpk 2.5.31-2/arch/mips/config.in 2.5.31w/arch/mips/config.in
--- 2.5.31-2/arch/mips/config.in	2002-08-13 22:09:54.000000000 -0500
+++ 2.5.31w/arch/mips/config.in	2002-08-13 22:47:58.000000000 -0500
@@ -471,17 +471,6 @@
    endmenu
 fi
 
-if [ "$CONFIG_DECSTATION" != "y" ]; then
-   mainmenu_option next_comment
-   comment 'Sound'
-
-   tristate 'Sound card support' CONFIG_SOUND
-   if [ "$CONFIG_SOUND" != "n" ]; then
-      source sound/Config.in
-   fi
-   endmenu
-fi
-
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    source drivers/sgi/Config.in
 fi
diff -urNXxpk 2.5.31-2/arch/mips64/config.in 2.5.31w/arch/mips64/config.in
--- 2.5.31-2/arch/mips64/config.in	2002-08-13 22:10:16.000000000 -0500
+++ 2.5.31w/arch/mips64/config.in	2002-08-13 22:48:17.000000000 -0500
@@ -219,15 +219,6 @@
    define_bool CONFIG_KCORE_ELF y
 fi
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/Config.in
-fi
-endmenu
-
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    source drivers/sgi/Config.in
 fi
diff -urNXxpk 2.5.31-2/arch/ppc/config.in 2.5.31w/arch/ppc/config.in
--- 2.5.31-2/arch/ppc/config.in	2002-08-13 22:14:09.000000000 -0500
+++ 2.5.31w/arch/ppc/config.in	2002-08-13 22:54:57.000000000 -0500
@@ -558,15 +558,6 @@
 
 source fs/Config.in
 
-mainmenu_option next_comment
-comment 'Sound'
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/oss/dmasound/Config.in
-   source sound/Config.in
-fi
-endmenu
-
 if [ "$CONFIG_8xx" = "y" ]; then
    source arch/ppc/8xx_io/Config.in
 fi
diff -urNXxpk 2.5.31-2/arch/ppc64/config.in 2.5.31w/arch/ppc64/config.in
--- 2.5.31-2/arch/ppc64/config.in	2002-08-13 22:14:24.000000000 -0500
+++ 2.5.31w/arch/ppc64/config.in	2002-08-13 22:56:14.000000000 -0500
@@ -197,15 +197,6 @@
 
 source fs/Config.in
 
-mainmenu_option next_comment
-comment 'Sound'
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/Config.in
-fi
-
-endmenu
-
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
diff -urNXxpk 2.5.31-2/arch/sh/config.in 2.5.31w/arch/sh/config.in
--- 2.5.31-2/arch/sh/config.in	2002-08-13 22:11:50.000000000 -0500
+++ 2.5.31w/arch/sh/config.in	2002-08-13 22:56:45.000000000 -0500
@@ -348,16 +348,6 @@
    endmenu
 fi
 
-
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/Config.in
-fi
-endmenu
-
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -urNXxpk 2.5.31-2/arch/x86_64/config.in 2.5.31w/arch/x86_64/config.in
--- 2.5.31-2/arch/x86_64/config.in	2002-08-13 22:11:44.000000000 -0500
+++ 2.5.31w/arch/x86_64/config.in	2002-08-13 22:57:49.000000000 -0500
@@ -199,15 +199,6 @@
    endmenu
 fi
 
-mainmenu_option next_comment
-comment 'Sound'
-
-tristate 'Sound card support' CONFIG_SOUND
-if [ "$CONFIG_SOUND" != "n" ]; then
-   source sound/Config.in
-fi
-endmenu
-
 source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
diff -urNXxpk 2.5.31-2/drivers/media/Config.in 2.5.31w/drivers/media/Config.in
--- 2.5.31-2/drivers/media/Config.in	2002-06-09 00:29:41.000000000 -0500
+++ 2.5.31w/drivers/media/Config.in	2002-08-13 23:19:28.000000000 -0500
@@ -4,6 +4,12 @@
 mainmenu_option next_comment
 comment 'Multimedia devices'
 
+tristate 'Sound card support' CONFIG_SOUND
+if [ "$CONFIG_SOUND" != "n" ]; then
+   source sound/Config.in
+   source sound/oss/dmasound/Config.in
+fi
+
 tristate 'Video For Linux' CONFIG_VIDEO_DEV
 if [ "$CONFIG_VIDEO_DEV" != "n" ]; then
    source drivers/media/video/Config.in

--jho1yZJdad60DJr+--
