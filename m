Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTAOVhe>; Wed, 15 Jan 2003 16:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTAOVhd>; Wed, 15 Jan 2003 16:37:33 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:34565 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267361AbTAOVh3>;
	Wed, 15 Jan 2003 16:37:29 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND w/ reasonable Subject] alsa before oss in Kconfig
References: <Pine.LNX.4.44.0301100921460.12833-100000@home.transmeta.com>
	<m3y95o33xi.fsf@lugabout.jhcloos.org>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <m3y95o33xi.fsf@lugabout.jhcloos.org>
Date: 15 Jan 2003 16:46:12 -0500
Message-ID: <m38yxmjdcr.fsf_-_@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have changed the subject when I first sent this....

[re OSS vs ALSA audio drivers]
Linus> So I don't see a huge reason to remove them from the sources,
Linus> but we might well make them harder to select by mistake, for
Linus> example. Right now the config help files aren't exactly helpful,
Linus> and the OSS choice is before the ALSA one, which looks wrong.

Linus> They should probably be marked deprecated, and if they don't
Linus> get a lot of maintenance, that's fine.

Like this?

Also available from:

        bk://cloos.bkbits.net/alsa-oss

ChangeSet@1.966, 2003-01-13 20:05:11-05:00, cloos@lugabout.jhcloos.org
  Move ALSA before OSS

 sound/Kconfig          |   26 ++++++++++++--------------
 arch/i386/defconfig    |   10 +++++-----
 arch/ia64/defconfig    |   10 +++++-----
 arch/parisc/defconfig  |    8 ++++----
 arch/sparc64/defconfig |   10 +++++-----
 5 files changed, 31 insertions(+), 33 deletions(-)


diff -Nru a/sound/Kconfig b/sound/Kconfig
--- a/sound/Kconfig	Mon Jan 13 20:32:29 2003
+++ b/sound/Kconfig	Mon Jan 13 20:32:29 2003
@@ -1,20 +1,6 @@
 # sound/Config.in
 #
 
-menu "Open Sound System"
-	depends on SOUND!=n
-
-config SOUND_PRIME
-	tristate "Open Sound System"
-	depends on SOUND
-	help
-	  Say 'Y' or 'M' to enable Open Sound System drivers.
-
-source "sound/oss/Kconfig"
-
-endmenu
-
-
 menu "Advanced Linux Sound Architecture"
 	depends on SOUND!=n
 
@@ -42,3 +28,15 @@
 
 endmenu
 
+menu "Open Sound System"
+	depends on SOUND!=n
+
+config SOUND_PRIME
+	tristate "Open Sound System (DEPRECATED)"
+	depends on SOUND
+	help
+	  Say 'Y' or 'M' to enable Open Sound System drivers.
+
+source "sound/oss/Kconfig"
+
+endmenu
diff -Nru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	Mon Jan 13 20:32:29 2003
+++ b/arch/i386/defconfig	Mon Jan 13 20:32:29 2003
@@ -839,11 +839,6 @@
 CONFIG_SOUND=y
 
 #
-# Open Sound System
-#
-# CONFIG_SOUND_PRIME is not set
-
-#
 # Advanced Linux Sound Architecture
 #
 CONFIG_SND=y
@@ -922,6 +917,11 @@
 # ALSA USB devices
 #
 # CONFIG_SND_USB_AUDIO is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
 
 #
 # USB support
diff -Nru a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig	Mon Jan 13 20:32:29 2003
+++ b/arch/ia64/defconfig	Mon Jan 13 20:32:29 2003
@@ -657,6 +657,11 @@
 CONFIG_SOUND=y
 
 #
+# Advanced Linux Sound Architecture
+#
+# CONFIG_SND is not set
+
+#
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=y
@@ -679,11 +684,6 @@
 # CONFIG_SOUND_VIA82CXXX is not set
 # CONFIG_SOUND_OSS is not set
 # CONFIG_SOUND_TVMIXER is not set
-
-#
-# Advanced Linux Sound Architecture
-#
-# CONFIG_SND is not set
 
 #
 # USB support
diff -Nru a/arch/parisc/defconfig b/arch/parisc/defconfig
--- a/arch/parisc/defconfig	Mon Jan 13 20:32:29 2003
+++ b/arch/parisc/defconfig	Mon Jan 13 20:32:29 2003
@@ -643,14 +643,14 @@
 CONFIG_SOUND=y
 
 #
-# Open Sound System
+# Advanced Linux Sound Architecture
 #
-# CONFIG_SOUND_PRIME is not set
+# CONFIG_SND is not set
 
 #
-# Advanced Linux Sound Architecture
+# Open Sound System
 #
-# CONFIG_SND is not set
+# CONFIG_SOUND_PRIME is not set
 
 #
 # USB support
diff -Nru a/arch/sparc64/defconfig b/arch/sparc64/defconfig
--- a/arch/sparc64/defconfig	Mon Jan 13 20:32:29 2003
+++ b/arch/sparc64/defconfig	Mon Jan 13 20:32:29 2003
@@ -710,11 +710,6 @@
 CONFIG_SOUND=m
 
 #
-# Open Sound System
-#
-# CONFIG_SOUND_PRIME is not set
-
-#
 # Advanced Linux Sound Architecture
 #
 CONFIG_SND=m
@@ -777,6 +772,11 @@
 #
 CONFIG_SND_SUN_AMD7930=m
 CONFIG_SND_SUN_CS4231=m
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
 
 #
 # USB support

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


