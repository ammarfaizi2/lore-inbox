Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUCHUet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUCHUel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:34:41 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:8381 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S261199AbUCHUdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:33:46 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200403082032.i28KWvuw082582@fsgi900.americas.sgi.com>
Subject: [2.6 PATCH] Altix - console driver calls console_initcall
To: davidm@napali.hpl.hp.com
Date: Mon, 8 Mar 2004 14:32:56 -0600 (CST)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small mod to have the console driver call console_initcall() to
register.




# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1692  -> 1.1693 
#	drivers/char/sn_serial.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/08	pfg@sgi.com	1.1693
# drivers/char/sn_serial.c
#     Make console_initcall() for proper registration.
# --------------------------------------------
#
diff -Nru a/drivers/char/sn_serial.c b/drivers/char/sn_serial.c
--- a/drivers/char/sn_serial.c	Mon Mar  8 14:28:53 2004
+++ b/drivers/char/sn_serial.c	Mon Mar  8 14:28:53 2004
@@ -82,7 +82,6 @@
 static unsigned long sn_interrupt_timeout;
 
 extern u64 master_node_bedrock_address;
-
 static int sn_debug_printf(const char *fmt, ...);
 
 #undef DEBUG
@@ -105,7 +104,7 @@
 static struct sn_sal_ops *sn_func;
 
 /* Prototypes */
-static void __init sn_sal_serial_console_init(void);
+int __init sn_sal_serial_console_init(void);
 static int snt_hw_puts(const char *, int);
 static int snt_poll_getc(void);
 static int snt_poll_input_pending(void);
@@ -921,9 +920,6 @@
 		printk(KERN_ERR "sn_serial: Unable to register tty driver\n");
 		return retval;
 	}
-#ifdef CONFIG_SGI_L1_SERIAL_CONSOLE
-	sn_sal_serial_console_init();
-#endif	/* CONFIG_SGI_L1_SERIAL_CONSOLE */
 	return 0;
 }
 
@@ -993,7 +989,7 @@
 	.index = -1
 };
 
-static void __init
+int __init
 sn_sal_serial_console_init(void)
 {
 	if (ia64_platform_is("sn2")) {
@@ -1001,6 +997,8 @@
 		sn_debug_printf("sn_sal_serial_console_init : register console\n");
 		register_console(&sal_console);
 	}
+	return 0;
 }
+console_initcall(sn_sal_serial_console_init);
 
 #endif /* CONFIG_SGI_L1_SERIAL_CONSOLE */
