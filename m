Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCFGT1>; Wed, 6 Mar 2002 01:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293244AbSCFGTS>; Wed, 6 Mar 2002 01:19:18 -0500
Received: from mail.mesatop.com ([208.164.122.9]:1811 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S293242AbSCFGTE>;
	Wed, 6 Mar 2002 01:19:04 -0500
Message-Id: <200203060618.g266Inb29051@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dave Jones <davej@suse.de>
Subject: [PATCH] 2.5.5-dj3, fix dep_tristate in sound/oss/Config.in
Date: Tue, 5 Mar 2002 23:08:42 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error with make xconfig and 2.5.5-dj3:

./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/oss/Config.in: 38: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/home/steven/kernels/linux-2.5.5-dj3/scripts'
make: *** [xconfig] Error 2

If an additional guard is needed, then this tristate will have to be reverted
to a dep_tristate.  In the meantime, here is a small patch to get dj3 to configure.

Steven

--- linux-2.5.5-dj3/sound/oss/Config.in.orig	Tue Mar  5 22:37:54 2002
+++ linux-2.5.5-dj3/sound/oss/Config.in	Tue Mar  5 22:49:07 2002
@@ -35,7 +35,7 @@
 dep_tristate '  Crystal SoundFusion (CS4280/461x)' CONFIG_SOUND_FUSION $CONFIG_SOUND
 dep_tristate '  Crystal Sound CS4281' CONFIG_SOUND_CS4281 $CONFIG_SOUND
 if [ "$CONFIG_SIBYTE_SB1250" = "y" -a "$CONFIG_REMOTE_DEBUG" != "y" ]; then
-    dep_tristate '  Crystal Sound CS4297a (for Swarm)' CONFIG_SOUND_BCM_CS4297A 
+    tristate '  Crystal Sound CS4297a (for Swarm)' CONFIG_SOUND_BCM_CS4297A
 fi
 dep_tristate '  Ensoniq AudioPCI (ES1370)' CONFIG_SOUND_ES1370 $CONFIG_SOUND $CONFIG_PCI $CONFIG_SOUND_GAMEPORT
 dep_tristate '  Creative Ensoniq AudioPCI 97 (ES1371)' CONFIG_SOUND_ES1371 $CONFIG_SOUND $CONFIG_PCI $CONFIG_SOUND_GAMEPORT
