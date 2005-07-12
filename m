Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVGLRbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVGLRbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGLRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:30:57 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:1968 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261780AbVGLR2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:28:46 -0400
Message-ID: <42D3FD10.7050707@inwind.it>
Date: Tue, 12 Jul 2005 19:25:36 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [update] Re: [PATCH] ability to change SysRq scancode
References: <42D03731.9060809@inwind.it>
In-Reply-To: <42D03731.9060809@inwind.it>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090604060504030408050108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604060504030408050108
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

federico ha scritto:

>i release this patch because my keyboard ("Mitsumi Electric Apple
>Extended USB Keyboard" Bus=0003 Vendor=05ac Product=0205 Version=0122)
>doesn't have a PrintScr key, so cannot send the right scancode, and
>KEY_SYSRQ needs to be modified.
>
>i hope that i've done in the right way ;)
>it's tested by me, and it's working, yeah i'm pressing the SAK with F13 :P
>  
>

fixed some typos in Kconfig and cleaned up the code.

this should be that last release of this patch.
it's tested and working (it's nothing else a simple one-line hack)

if someone wants to try please report results :)
ciao!
Federico


--------------090604060504030408050108
Content-Type: text/x-patch;
 name="sysrq_keycode_r5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq_keycode_r5.patch"

diff -uprN linux.orig/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- linux.orig/drivers/char/keyboard.c	2005-07-09 21:47:50.000000000 +0200
+++ linux/drivers/char/keyboard.c	2005-07-10 14:42:34.000000000 +0200
@@ -1081,7 +1087,7 @@ static void kbd_keycode(unsigned int key
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+	if (keycode == CONFIG_MAGIC_SYSRQ_KEYCODE && (sysrq_down || (down == 1 && sysrq_alt))) {
 		sysrq_down = down;
 		return;
 	}
diff -uprN linux.orig/lib/Kconfig.debug linux/lib/Kconfig.debug
--- linux.orig/lib/Kconfig.debug	2005-07-09 21:47:22.000000000 +0200
+++ linux/lib/Kconfig.debug	2005-07-09 21:50:44.000000000 +0200
@@ -28,6 +28,16 @@ config MAGIC_SYSRQ
 	  send a BREAK and then within 5 seconds a command keypress. The
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
+	  
+config MAGIC_SYSRQ_KEYCODE
+	int
+	prompt "Change SysRq key-code" if MAGIC_SYSRQ
+	default 99
+	depends on MAGIC_SYSRQ
+	help
+	  If your keyboard doesn't have a SysRq key (also labeled PrintScr),
+	  you can specify another keycode which should act as SysRq.
+	  Default is 99 (KEY_SYSRQ).
+	  You can find this number using programs like evtest, or (maybe)
+	  showkey.
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL


--------------090604060504030408050108--
