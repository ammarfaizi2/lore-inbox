Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbSJBOBj>; Wed, 2 Oct 2002 10:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSJBOBj>; Wed, 2 Oct 2002 10:01:39 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:64772 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263104AbSJBOBh>; Wed, 2 Oct 2002 10:01:37 -0400
To: m.c.p@wolk-project.de
Subject: Re: [PATCH] ALSA 'make menuconfig exits' fix
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Message-Id: <E17wk9W-0005c1-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 02 Oct 2002 16:07:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marc-Christian Petersen wrote:

> attached patch fixes "make menuconfig" crashes when entering Sound/ALSA.
> 
> Dunno if it is the correct way but it works. Consider this as a workaround.

This is no valid config syntax.
Below is a better patch + another sparc sound config fix.
Linus, please apply.

bye, Roman

--- linux/arch/sparc/config.in	2002/10/02 09:30:33	1.1.1.14
+++ linux/arch/sparc/config.in	2002/10/02 12:44:45
@@ -222,6 +224,9 @@ source drivers/input/Config.in
 
 source fs/Config.in
 
+mainmenu_option next_comment
+comment 'Sound'
+
 tristate 'Sound card support' CONFIG_SOUND
 if [ "$CONFIG_SOUND" != "n" ]; then
    source sound/Config.in
--- linux/sound/Config.in	2002/10/02 09:34:47	1.1.1.3
+++ linux/sound/Config.in	2002/10/02 10:23:26
@@ -31,11 +31,10 @@ fi
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
   source sound/arm/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
-  source sound/sparc/Config.in
-fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
-  source sound/sparc/Config.in
+if [ "$CONFIG_SND" != "n" ]; then
+  if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
+    source sound/sparc/Config.in
+  fi
 fi
 
 endmenu
