Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbTIFOiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTIFOiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 10:38:10 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:50915 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S261211AbTIFOiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 10:38:06 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U}
To: linux-kernel@vger.kernel.org
Subject: [PATCH] move MODULE_ALIAS_LDISC definition to include/linux/termio.h
Date: Sat, 6 Sep 2003 16:24:11 +0200
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, torvalds@osdl.org
X-Face: xyzzy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061624.15647@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't add non-machine-specific macros to machine-specific include files.

Thank you.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1105  -> 1.1106 
#	include/asm-i386/termios.h	1.4     -> 1.5    
#	include/linux/termios.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/06	smurf@smurf.noris.de	1.1106
# Move MODULE_ALIAS_LDISC declaration to include/linux/termios.h
# --------------------------------------------
#
diff -Nru a/include/asm-i386/termios.h b/include/asm-i386/termios.h
--- a/include/asm-i386/termios.h	Sat Sep  6 16:19:44 2003
+++ b/include/asm-i386/termios.h	Sat Sep  6 16:19:44 2003
@@ -58,7 +58,6 @@
 #define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
-#include <linux/module.h>
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
@@ -102,8 +101,6 @@
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
-#define MODULE_ALIAS_LDISC(ldisc) \
-	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 #endif	/* __KERNEL__ */
 
 #endif	/* _I386_TERMIOS_H */
diff -Nru a/include/linux/termios.h b/include/linux/termios.h
--- a/include/linux/termios.h	Sat Sep  6 16:19:44 2003
+++ b/include/linux/termios.h	Sat Sep  6 16:19:44 2003
@@ -4,4 +4,11 @@
 #include <linux/types.h>
 #include <asm/termios.h>
 
+#ifdef __KERNEL__
+#include <linux/module.h>
+
+#define MODULE_ALIAS_LDISC(ldisc) \
+	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
+#endif	/* __KERNEL__ */
+
 #endif

