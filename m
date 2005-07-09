Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVGIVn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVGIVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGIVn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:43:58 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:65201 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S261751AbVGIVmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:42:44 -0400
Message-ID: <42D04414.6070804@inwind.it>
Date: Sat, 09 Jul 2005 23:39:32 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ability to change SysRq scancode
References: <42D03731.9060809@inwind.it> <200507100128.46959.adobriyan@gmail.com>
In-Reply-To: <200507100128.46959.adobriyan@gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050301040908080300080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301040908080300080500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Alexey Dobriyan ha scritto:

>On Sunday 10 July 2005 00:44, federico wrote:
>  
>
>>i release this patch because my keyboard ("Mitsumi Electric Apple
>>Extended USB Keyboard" Bus=0003 Vendor=05ac Product=0205 Version=0122)
>>doesn't have a PrintScr key, so cannot send the right scancode, and
>>KEY_SYSRQ needs to be modified.
>>
>>i hope that i've done in the right way ;)
>>    
>>
>
>diff -uprN please.
>  
>
here it is

--------------050301040908080300080500
Content-Type: text/x-patch;
 name="sysrq_scancode2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq_scancode2.patch"

diff -uprN linux.orig/include/linux/input.h linux/include/linux/input.h
--- linux.orig/include/linux/input.h	2005-07-09 21:48:19.000000000 +0200
+++ linux/include/linux/input.h	2005-07-09 21:50:14.000000000 +0200
@@ -204,7 +204,13 @@ struct input_absinfo {
 #define KEY_KPENTER		96
 #define KEY_RIGHTCTRL		97
 #define KEY_KPSLASH		98
+
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_MAGIC_SYSRQ_SCANCODE)
+#define KEY_SYSRQ		CONFIG_MAGIC_SYSRQ_SCANCODE
+#else
 #define KEY_SYSRQ		99
+#endif
+
 #define KEY_RIGHTALT		100
 #define KEY_LINEFEED		101
 #define KEY_HOME		102
diff -uprN linux.orig/lib/Kconfig.debug linux/lib/Kconfig.debug
--- linux.orig/lib/Kconfig.debug	2005-07-09 21:47:22.000000000 +0200
+++ linux/lib/Kconfig.debug	2005-07-09 21:50:44.000000000 +0200
@@ -28,6 +28,16 @@ config MAGIC_SYSRQ
 	  send a BREAK and then within 5 seconds a command keypress. The
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
+	  
+config MAGIC_SYSRQ_SCANCODE
+	int
+	prompt "Change default scancode of SysRq key" if MAGIC_SYSRQ
+	default 99
+	depends on MAGIC_SYSRQ
+	help
+	  If your keyboard hasn't a SysRq key, you can specify another key
+	  which should act as SysRq. You can find the scancode on your
+	  keyboard with programs like showkey or evtest.
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL

--------------050301040908080300080500--
