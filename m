Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTHYSXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbTHYSXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:23:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:26030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262136AbTHYSXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:23:39 -0400
Date: Mon, 25 Aug 2003 11:18:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] limit some config options per arch.
Message-Id: <20030825111854.5c4afdac.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building on ia64 allowed too many options that shouldn't be allowed
there.  This patch limits some of them.

Comments?  Please apply to 2.6.0-test4.

--
~Randy


patch_name:	it_configs.patch
patch_version:	2003-08-25.11:17:21
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	restrict some config options based on architecture
product:	Linux
product_versions: 260-test4
diffstat:	=
 drivers/block/Kconfig |    2 +-
 drivers/char/Kconfig  |    2 ++
 drivers/pnp/Kconfig   |    3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)


diff -Naur ./drivers/char/Kconfig~itcfg ./drivers/char/Kconfig
--- ./drivers/char/Kconfig~itcfg	Fri Aug 22 16:51:02 2003
+++ ./drivers/char/Kconfig	Mon Aug 25 10:48:21 2003
@@ -744,6 +744,7 @@
 
 config NVRAM
 	tristate "/dev/nvram support"
+	depends on !IA64
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
@@ -1000,6 +1001,7 @@
 
 config HANGCHECK_TIMER
 	tristate "Hangcheck timer"
+	depends on X86
 	help
 	  The hangcheck-timer module detects when the system has gone
 	  out to lunch past a certain margin.  It can reboot the system
diff -Naur ./drivers/block/Kconfig~itcfg ./drivers/block/Kconfig
--- ./drivers/block/Kconfig~itcfg	Fri Aug 22 16:53:09 2003
+++ ./drivers/block/Kconfig	Mon Aug 25 10:48:21 2003
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on !X86_PC9800
+	depends on !X86_PC9800 && !IA64
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
diff -Naur ./drivers/pnp/Kconfig~itcfg ./drivers/pnp/Kconfig
--- ./drivers/pnp/Kconfig~itcfg	Fri Aug 22 16:56:13 2003
+++ ./drivers/pnp/Kconfig	Mon Aug 25 11:15:37 2003
@@ -2,6 +2,8 @@
 # Plug and Play configuration
 #
 
+if X86 && !X86_64
+
 menu "Plug and Play support"
 
 config PNP
@@ -60,3 +62,4 @@
 
 endmenu
 
+endif
