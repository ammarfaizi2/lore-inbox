Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVLOLOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVLOLOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVLOLOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:14:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31116 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965058AbVLOLOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:14:37 -0500
Message-ID: <43A1500E.1080606@suse.de>
Date: Thu, 15 Dec 2005 12:14:22 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] uml: Framebuffer driver for UML
References: <439EE38C.6020602@suse.de> <439EE5B0.2030709@suse.de> <20051213221548.GB9769@ccure.user-mode-linux.org> <43A13206.3080704@suse.de>
In-Reply-To: <43A13206.3080704@suse.de>
Content-Type: multipart/mixed;
 boundary="------------070407060307060200020704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407060307060200020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>> drivers/built-in.o(.text+0x18b): In function `vgacon_deinit':
>> /home/jdike/linux/2.6/linux-2.6.15/drivers/video/console/vgacon.c:151: 
>> undefined reference to `outw'

> Should be trivially fixable with some Kconfig tweaks, I'll have a look.

Here we go, this patch disables vga console and the mouse/kbd hardware 
drivers on UML.  Running a "allmodconfig" testbuild right now, but I 
hope that everything else is catched by PCI + ISA dependencies ...

cheers,

   Gerd


--------------070407060307060200020704
Content-Type: text/plain;
 name="uml-kconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-kconfig"

Index: linux-2.6.14/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/keyboard/Kconfig	2005-12-12 18:24:51.000000000 +0100
+++ linux-2.6.14/drivers/input/keyboard/Kconfig	2005-12-15 12:07:26.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_KEYBOARD
 
 	  If unsure, say Y.
 
-if INPUT_KEYBOARD
+if INPUT_KEYBOARD && !UML
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard" if !X86_PC
Index: linux-2.6.14/drivers/input/mouse/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/mouse/Kconfig	2005-12-12 18:24:51.000000000 +0100
+++ linux-2.6.14/drivers/input/mouse/Kconfig	2005-12-15 12:06:59.000000000 +0100
@@ -10,7 +10,7 @@ menuconfig INPUT_MOUSE
 
 	  If unsure, say Y.
 
-if INPUT_MOUSE
+if INPUT_MOUSE && !UML
 
 config MOUSE_PS2
 	tristate "PS/2 mouse"
Index: linux-2.6.14/drivers/input/serio/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/input/serio/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/input/serio/Kconfig	2005-12-15 12:06:11.000000000 +0100
@@ -21,7 +21,7 @@ if SERIO
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K && !UML
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
Index: linux-2.6.14/drivers/video/console/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/video/console/Kconfig	2005-12-12 18:25:03.000000000 +0100
+++ linux-2.6.14/drivers/video/console/Kconfig	2005-12-15 12:01:31.000000000 +0100
@@ -6,7 +6,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE && !UML
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a

--------------070407060307060200020704--
