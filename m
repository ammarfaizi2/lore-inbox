Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTI1NGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTI1NGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:06:36 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:61748 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262574AbTI1NGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:24 -0400
Date: Sun, 28 Sep 2003 14:55:37 +0200
Message-Id: <200309281255.h8SCtbLc005642@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 328] Dmasound config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound: Use select to get CONFIG_DMASOUND defined for all subdrivers (from
Christoph Hellwig).

--- linux-2.6.0-test6/sound/oss/dmasound/Kconfig	Sun Jun 15 09:39:22 2003
+++ linux-m68k-2.6.0-test6/sound/oss/dmasound/Kconfig	Tue Sep 23 08:50:32 2003
--- linux-2.6.0-test6/sound/oss/dmasound/Kconfig	Sun Sep 28 09:37:25 2003
+++ linux-m68k-2.6.0-test6/sound/oss/dmasound/Kconfig	Sun Sep 28 10:05:48 2003
@@ -1,7 +1,7 @@
-# drivers/sound/dmasound/Config.in
 config DMASOUND_ATARI
 	tristate "Atari DMA sound support"
 	depends on ATARI && SOUND
+	select DMASOUND
 	help
 	  If you want to use the internal audio of your Atari in Linux, answer
 	  Y to this question. This will provide a Sun-like /dev/audio,
@@ -15,6 +15,7 @@
 config DMASOUND_PMAC
 	tristate "PowerMac DMA sound support"
 	depends on PPC_PMAC && SOUND && I2C
+ 	select DMASOUND
 	help
 	  If you want to use the internal audio of your PowerMac in Linux,
 	  answer Y to this question. This will provide a Sun-like /dev/audio,
@@ -28,6 +29,7 @@
 config DMASOUND_PAULA
 	tristate "Amiga DMA sound support"
 	depends on (AMIGA || APUS) && SOUND
+	select DMASOUND
 	help
 	  If you want to use the internal audio of your Amiga in Linux, answer
 	  Y to this question. This will provide a Sun-like /dev/audio,
@@ -41,6 +43,7 @@
 config DMASOUND_Q40
 	tristate "Q40 sound support"
 	depends on Q40 && SOUND
+	select DMASOUND
 	help
 	  If you want to use the internal audio of your Q40 in Linux, answer
 	  Y to this question. This will provide a Sun-like /dev/audio,
@@ -53,13 +56,3 @@
 
 config DMASOUND
 	tristate
-	depends on SOUND!=n
-	default m if DMASOUND_ATARI!=y && DMASOUND_AWACS!=y && DMASOUND_PAULA!=y && DMASOUND_Q40!=y && (DMASOUND_ATARI=m || DMASOUND_AWACS=m || DMASOUND_PAULA=m || DMASOUND_Q40=m)
-	default y if DMASOUND_ATARI=y || DMASOUND_AWACS=y || DMASOUND_PAULA=y || DMASOUND_Q40=y
-	help
-	  Support built-in audio chips accessible by DMA on various machines
-	  that have them.  Note that this symbol does not affect the kernel
-	  directly; rather, it controls whether configuration questions
-	  enabling DMA sound drivers for various specific machine
-	  architectures will be used.
-

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
