Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTHJO5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTHJO5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:57:07 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:18948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269664AbTHJO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:56:55 -0400
Date: Sun, 10 Aug 2003 15:56:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: 2.6.0-test3 issue
Message-ID: <20030810155651.D18400@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0308101523120.714-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308101523120.714-100000@serv>; from zippel@linux-m68k.org on Sun, Aug 10, 2003 at 04:12:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 04:12:00PM +0200, Roman Zippel wrote:
> 3. remove the excessive use of EMBEDDED, only INPUT needed fixing, 
> everything else had reasonable defaults.

Patch below.  I though I sent this already but it didn't appear on
lkml yet.

--- 1.15/drivers/char/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/char/Kconfig	Sun Aug 10 11:17:02 2003
@@ -5,8 +5,8 @@
 menu "Character devices"
 
 config VT
-	bool "Virtual terminal" if EMBEDDED
-	requires INPUT=y
+	bool "Virtual terminal"
+	select INPUT
 	default y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
@@ -36,7 +36,7 @@
 	  shiny Linux system :-)
 
 config VT_CONSOLE
-	bool "Support for console on virtual terminal" if EMBEDDED
+	bool "Support for console on virtual terminal"
 	depends on VT
 	default y
 	---help---
--- 1.5/drivers/input/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/Kconfig	Sun Aug 10 11:15:19 2003
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Input devices (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Input devices (needed for keyboard, mouse, ...)"
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
@@ -27,8 +27,8 @@
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
-	tristate "Mouse interface" if EMBEDDED
+	tristate "Mouse interface"
 	default y
 	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
@@ -45,8 +45,8 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_SCREEN_X
===== drivers/input/keyboard/Kconfig 1.6 vs edited =====
--- 1.6/drivers/input/keyboard/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/keyboard/Kconfig	Sun Aug 10 11:15:49 2003
@@ -2,7 +2,7 @@
 # Input core configuration
 #
 config INPUT_KEYBOARD
-	bool "Keyboards" if EMBEDDED || !X86
+	bool "Keyboards"
 	default y
 	depends on INPUT
 	help
@@ -12,8 +12,8 @@
 	  If unsure, say Y.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard support" if EMBEDDED || !X86 
+	tristate "AT keyboard support"
 	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
===== drivers/input/serio/Kconfig 1.9 vs edited =====
--- 1.9/drivers/input/serio/Kconfig	Wed Jul 16 13:39:32 2003
+++ edited/drivers/input/serio/Kconfig	Sun Aug 10 11:16:08 2003
@@ -19,8 +19,8 @@
 	  as a module, say M here and read <file:Documentation/modules.txt>.
 
 config SERIO_I8042
-	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
+	tristate "i8042 PC Keyboard controller"
 	default y
 	depends on SERIO
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
