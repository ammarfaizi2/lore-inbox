Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292185AbSBOV5L>; Fri, 15 Feb 2002 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292187AbSBOV5B>; Fri, 15 Feb 2002 16:57:01 -0500
Received: from smtp02.web.de ([217.72.192.151]:21256 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292185AbSBOV4q>;
	Fri, 15 Feb 2002 16:56:46 -0500
Date: Fri, 15 Feb 2002 23:07:39 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix xconfig in 2.5.4-dj2
Message-Id: <20020215230739.33e22865.l.s.r@web.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch below allows 'make xconfig' to run successfully.

René



diff -ur linux-2.5.4-dj2/sound/Config.in linux/sound/Config.in
--- linux-2.5.4-dj2/sound/Config.in	Fri Feb 15 22:06:30 2002
+++ linux/sound/Config.in	Fri Feb 15 22:45:24 2002
@@ -19,13 +19,13 @@
   source sound/core/Config.in
   source sound/drivers/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" = "y" ]; then
   source sound/isa/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" = "y" ]; then
   source sound/pci/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" == "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" = "y" ]; then
   source sound/ppc/Config.in
 fi
 
diff -ur linux-2.5.4-dj2/sound/isa/Config.in linux/sound/isa/Config.in
--- linux-2.5.4-dj2/sound/isa/Config.in	Fri Feb 15 22:06:31 2002
+++ linux/sound/isa/Config.in	Fri Feb 15 22:51:34 2002
@@ -20,7 +20,7 @@
 dep_tristate 'Sound Blaster 16 (PnP)' CONFIG_SND_SB16 $CONFIG_SND
 dep_tristate 'Sound Blaster AWE (32,64) (PnP)' CONFIG_SND_SBAWE $CONFIG_SND
 if [ "$CONFIG_SND_SB16" != "n" -o "$CONFIG_SND_SBAWE" != "n" ]; then
-  dep_bool 'Sound Blaster 16/AWE CSP support' CONFIG_SND_SB16_CSP
+  dep_bool 'Sound Blaster 16/AWE CSP support' CONFIG_SND_SB16_CSP $CONFIG_SND
 fi
 dep_tristate 'Turtle Beach Maui,Tropez,Tropez+ (Wavefront)' CONFIG_SND_WAVEFRONT $CONFIG_SND
 dep_tristate 'Avance Logic ALS100/ALS120' CONFIG_SND_ALS100 $CONFIG_SND
