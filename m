Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCHXV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCHXV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:21:28 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:37521 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261204AbUCHXVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:21:11 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200403082320.i28NKGsk066877@fsgi900.americas.sgi.com>
Subject: Re: [2.6 PATCH] Altix - console driver calls console_initcall
To: bjorn.helgaas@hp.com, davidm@napali.hpl.hp.com
Date: Mon, 8 Mar 2004 17:20:16 -0600 (CST)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 08 March 2004 1:32 pm, Pat Gefre wrote:
> > -static void __init sn_sal_serial_console_init(void);
> > +int __init sn_sal_serial_console_init(void);
> 
> I don't see any callers other than the console_initcall(), so
> you could lose the declaration altogether.
> 
> > -static void __init
> > +int __init
> >  sn_sal_serial_console_init(void)
> 
> console_initcall() works fine with static functions, so you should
> be able to keep this static.
> 
> Bjorn

You're right.....

Here's a new mod which goes against 1.1698 too (the 'staircase' mod) -
so it'll have the correct line numbers - in other words it'll apply
cleanly if 1.1698 has already been applied.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1693  -> 1.1694 
#	drivers/char/sn_serial.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/08	pfg@sgi.com	1.1694
# drivers/char/sn_serial.c
#     Make console_initcall() for proper registration.
# --------------------------------------------
#
diff -Nru a/drivers/char/sn_serial.c b/drivers/char/sn_serial.c
--- a/drivers/char/sn_serial.c	Mon Mar  8 17:15:51 2004
+++ b/drivers/char/sn_serial.c	Mon Mar  8 17:15:51 2004
@@ -105,7 +105,6 @@
 static struct sn_sal_ops *sn_func;
 
 /* Prototypes */
-static void __init sn_sal_serial_console_init(void);
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
 
@@ -1015,7 +1011,7 @@
 	.index = -1
 };
 
-static void __init
+static int __init
 sn_sal_serial_console_init(void)
 {
 	if (ia64_platform_is("sn2")) {
@@ -1023,6 +1019,8 @@
 		sn_debug_printf("sn_sal_serial_console_init : register console\n");
 		register_console(&sal_console);
 	}
+	return 0;
 }
+console_initcall(sn_sal_serial_console_init);
 
 #endif /* CONFIG_SGI_L1_SERIAL_CONSOLE */
