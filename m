Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319221AbSHNG0s>; Wed, 14 Aug 2002 02:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319226AbSHNG0s>; Wed, 14 Aug 2002 02:26:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:10133 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S319221AbSHNG0q>;
	Wed, 14 Aug 2002 02:26:46 -0400
Message-ID: <3D59F937.73C60318@alphalink.com.au>
Date: Wed, 14 Aug 2002 16:31:19 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] kernel config 3/N - move sound into drivers/media
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <20020814043558.GN761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> Here's another one - this should fix the forward dependency between
> CONFIG_SOUND and CONFIG_SOUND_ACI_MIXER, by moving the sound config
> into the "Multimedia" menu - where I think it belongs anyway.
> 
>  [...]
> -if [ "$CONFIG_ARCH_ACORN" = "y" -o \
> -     "$CONFIG_ARCH_CLPS7500" = "y" -o \
> -     "$CONFIG_ARCH_TBOX" = "y" -o \
> -     "$CONFIG_ARCH_SHARK" = "y" -o \
> -     "$CONFIG_ARCH_SA1100" = "y" -o \
> -     "$CONFIG_PCI" = "y" ]; then
> -   mainmenu_option next_comment
> -   comment 'Sound'
> -
> -   tristate 'Sound card support' CONFIG_SOUND
> -   if [ "$CONFIG_SOUND" != "n" ]; then
> -      source sound/Config.in
> -   fi
> -   endmenu
> -fi
> -
>  [...]
> -if [ "$CONFIG_DECSTATION" != "y" ]; then
> -   mainmenu_option next_comment
> -   comment 'Sound'
> -
> -   tristate 'Sound card support' CONFIG_SOUND
> -   if [ "$CONFIG_SOUND" != "n" ]; then
> -      source sound/Config.in
> -   fi
> -   endmenu
> -fi
> -
> [...]
> +tristate 'Sound card support' CONFIG_SOUND
> +if [ "$CONFIG_SOUND" != "n" ]; then
> +   source sound/Config.in
> +   source sound/oss/dmasound/Config.in
> +fi
> +
>  tristate 'Video For Linux' CONFIG_VIDEO_DEV
>  if [ "$CONFIG_VIDEO_DEV" != "n" ]; then
>     source drivers/media/video/Config.in

Perhaps you might want to be careful about losing existing behaviour.

This patch makes the following improvements:

--- s-2.5.31-sam2.txt	Wed Aug 14 15:56:09 2002
+++ s-2.5.31-sam3.txt	Wed Aug 14 16:24:25 2002
@@ -279,3 +279,3 @@
     1      CONFIG_PCI_NAMES
-329    undeclared-symbol
+328    undeclared-symbol
     76     CONFIG_OBSOLETE
@@ -294,4 +294,4 @@
     11     CONFIG_SA
-    4      CONFIG_ARCH_TBOX
     3      CONFIG_ARCH_FTVPCI
+    3      CONFIG_ARCH_TBOX
     2      CONFIG_ARCH_NEXUSPCI
@@ -314,3 +314,3 @@
     1      CONFIG_PROC_FS
-134    forward-reference
+123    forward-reference
     43     CONFIG_PROC_FS
@@ -321,3 +321,2 @@
     11     CONFIG_ISDN_DRV_EICON_OLD
-    11     CONFIG_SOUND_ACI_MIXER
     6      CONFIG_PCI
@@ -330,6 +329,5 @@
     1      CONFIG_ZORRO
-34     forward-dependancy
+23     forward-dependancy
     11     CONFIG_ISDN_CAPI
     11     CONFIG_PROC_FS
-    11     CONFIG_SOUND_ACI_MIXER
     1      CONFIG_BLK_DEV_SD
@@ -394,2 +392,2 @@
 10     different-compound-type
-3055   total
+3032   total

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
