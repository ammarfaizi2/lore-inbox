Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272612AbTG1CZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271006AbTG1AAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272949AbTG0XCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:19 -0400
Date: Sun, 27 Jul 2003 21:03:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272003.h6RK3ckm029604@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: mouse and keyboard by default if not embedded
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andi Kleen)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/Kconfig linux-2.6.0-test2-ac1/drivers/input/Kconfig
--- linux-2.6.0-test2/drivers/input/Kconfig	2003-07-10 21:04:59.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/input/Kconfig	2003-07-16 18:39:32.000000000 +0100
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)"
+	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -27,7 +27,7 @@
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
-	tristate "Mouse interface"
+	tristate "Mouse interface" if EMBEDDED
 	default y
 	depends on INPUT
 	---help---
@@ -45,7 +45,7 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device"
+	bool "Provide legacy /dev/psaux device" if EMBEDDED
 	default y
 	depends on INPUT_MOUSEDEV
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/input/keyboard/Kconfig linux-2.6.0-test2-ac1/drivers/input/keyboard/Kconfig
--- linux-2.6.0-test2/drivers/input/keyboard/Kconfig	2003-07-10 21:14:55.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/input/keyboard/Kconfig	2003-07-16 18:39:32.000000000 +0100
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards"
+	bool "Keyboards" if (X86 && EMBEDDED) || (!X86)
 	default y
 	depends on INPUT
 	help
@@ -12,7 +12,7 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support"
+	tristate "AT keyboard support" if (X86 && EMBEDDED) || (!X86) 
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
