Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292839AbSCIUkx>; Sat, 9 Mar 2002 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292836AbSCIUkc>; Sat, 9 Mar 2002 15:40:32 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:17188 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292654AbSCIUka>; Sat, 9 Mar 2002 15:40:30 -0500
Message-ID: <3C7EF02B001C2A55@mail.libertysurf.net> (added by
	    postmaster@libertysurf.fr)
Content-Type: text/plain; charset=US-ASCII
From: William Stinson <wstinson@infonie.fr>
Reply-To: wstinson@infonie.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix xconfig in 2.5.6
Date: Sat, 9 Mar 2002 21:40:40 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

this is a small patch to fix error: 
	/tkparse < ../arch/i386/config.in >> kconfig.tk
	sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
upon make xconfig got with 2.5.6

Please CC me for any answers/comments.

I also put this patch at http://www.chez.com/wstinson/linux/kernel/patch-sound-core-Config.in

William Stinson (wstinson@infonie.fr)



--- linux-2.5.6/sound/core/Config.in	Sat Mar  9 21:03:45 2002
+++ linux-local/sound/core/Config.in	Sat Mar  9 21:04:57 2002
@@ -1,13 +1,13 @@
 # ALSA soundcard-configuration
 
 if [ "$CONFIG_X86_64" = "y" -a "$CONFIG_IA32_EMULATION" = "y" ]; then
-  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL
+  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL $CONFIG_SND
 fi
 if [ "$CONFIG_PPC64" = "y" ]; then
-  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL
+  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL $CONFIG_SND
 fi
 if [ "$CONFIG_SPARC64" = "y" ]; then
-  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL
+  dep_tristate '  Emulation for 32-bit applications' CONFIG_SND_BIT32_EMUL $CONFIG_SND
 fi
 dep_tristate '  Sequencer support' CONFIG_SND_SEQUENCER $CONFIG_SND
 if [ "$CONFIG_SND_SEQUENCER" != "n" ]; then




