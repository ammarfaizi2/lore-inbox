Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVA2Wb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVA2Wb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVA2WZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:25:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27311 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261584AbVA2WUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:20:41 -0500
Date: Sat, 29 Jan 2005 23:20:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH 6/8] Kconfig: cleanup input menu
Message-ID: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the input menu.
Move SOUND_GAMEPORT to its user, so it's easier to set it to y, even if GAMEPORT is n.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/input/Kconfig          |    3 +++
 drivers/input/gameport/Kconfig |   21 +--------------------
 drivers/input/serio/Kconfig    |    3 ++-
 sound/oss/Kconfig              |   22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 21 deletions(-)

Index: linux-2.6.11/sound/oss/Kconfig
===================================================================
--- linux-2.6.11.orig/sound/oss/Kconfig	2005-01-29 22:50:43.404946203 +0100
+++ linux-2.6.11/sound/oss/Kconfig	2005-01-29 22:56:42.549085439 +0100
@@ -3,6 +3,28 @@
 # 18 Apr 1998, Michael Elizabeth Chastain, <mailto:mec@shout.net>
 # More hacking for modularisation.
 #
+
+# Yes, SOUND_GAMEPORT looks a bit odd. Yes, it ends up being turned on
+# in every .config. Please don't touch it. It is here to handle an
+# unusual dependency between GAMEPORT and sound drivers.
+#
+# Some sound drivers call gameport functions. If GAMEPORT is
+# not selected, empty stubs are provided for the functions and all is
+# well.
+# If GAMEPORT is built in, everything is fine.
+# If GAMEPORT is a module, however, it would need to be loaded for the
+# sound driver to be able to link properly. Therefore, the sound
+# driver must be a module as well in that case. Since there's no way
+# to express that directly in Kconfig, we use SOUND_GAMEPORT to
+# express it. SOUND_GAMEPORT boils down to "if GAMEPORT is 'm',
+# anything that depends on SOUND_GAMEPORT must be 'm' as well. if
+# GAMEPORT is 'y' or 'n', it can be anything".
+config SOUND_GAMEPORT
+	tristate
+	depends on SOUND_PRIME
+	default m if GAMEPORT=m
+	default y
+
 # Prompt user for primary drivers.
 config SOUND_BT878
 	tristate "BT878 audio dma"
Index: linux-2.6.11/drivers/input/serio/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/serio/Kconfig	2005-01-29 22:50:43.404946203 +0100
+++ linux-2.6.11/drivers/input/serio/Kconfig	2005-01-29 22:56:42.549085439 +0100
@@ -3,6 +3,7 @@
 #
 config SERIO
 	tristate "Serial i/o support" if EMBEDDED || !X86
+	depends on INPUT
 	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
@@ -19,7 +20,7 @@ config SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	select SERIO
+	depends on SERIO
 	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
Index: linux-2.6.11/drivers/input/gameport/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/gameport/Kconfig	2005-01-29 22:50:43.404946203 +0100
+++ linux-2.6.11/drivers/input/gameport/Kconfig	2005-01-29 22:56:42.549085439 +0100
@@ -3,6 +3,7 @@
 #
 config GAMEPORT
 	tristate "Gameport support"
+	depends on INPUT
 	---help---
 	  Gameport support is for the standard 15-pin PC gameport. If you
 	  have a joystick, gamepad, gameport card, a soundcard with a gameport
@@ -20,26 +21,6 @@ config GAMEPORT
 	  module will be called gameport.
 
 
-# Yes, SOUND_GAMEPORT looks a bit odd. Yes, it ends up being turned on
-# in every .config. Please don't touch it. It is here to handle an
-# unusual dependency between GAMEPORT and sound drivers.
-#
-# Some sound drivers call gameport functions. If GAMEPORT is
-# not selected, empty stubs are provided for the functions and all is
-# well.
-# If GAMEPORT is built in, everything is fine.
-# If GAMEPORT is a module, however, it would need to be loaded for the
-# sound driver to be able to link properly. Therefore, the sound
-# driver must be a module as well in that case. Since there's no way
-# to express that directly in Kconfig, we use SOUND_GAMEPORT to
-# express it. SOUND_GAMEPORT boils down to "if GAMEPORT is 'm',
-# anything that depends on SOUND_GAMEPORT must be 'm' as well. if
-# GAMEPORT is 'y' or 'n', it can be anything".
-config SOUND_GAMEPORT
-	tristate
-	default y if GAMEPORT!=m
-	default m if GAMEPORT=m
-
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
 	depends on GAMEPORT
Index: linux-2.6.11/drivers/input/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/input/Kconfig	2005-01-29 22:50:43.404946203 +0100
+++ linux-2.6.11/drivers/input/Kconfig	2005-01-29 22:56:42.549085439 +0100
@@ -23,6 +23,7 @@ config INPUT
 	  module will be called input.
 
 comment "Userland interfaces"
+	depends on INPUT
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface" if EMBEDDED
@@ -135,12 +136,14 @@ config INPUT_EVBUG
 	  module will be called evbug.
 
 comment "Input I/O drivers"
+	depends on INPUT
 
 source "drivers/input/gameport/Kconfig"
 
 source "drivers/input/serio/Kconfig"
 
 comment "Input Device Drivers"
+	depends on INPUT
 
 source "drivers/input/keyboard/Kconfig"
 
