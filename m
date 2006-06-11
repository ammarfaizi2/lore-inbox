Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWFKWFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWFKWFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWFKWFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 18:05:30 -0400
Received: from waste.org ([64.81.244.121]:46002 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751077AbWFKWF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 18:05:29 -0400
Date: Sun, 11 Jun 2006 16:55:30 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: [PATCH] x86 built-in command line
Message-ID: <20060611215530.GH24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows building in a kernel command line on x86 as is
possible on several other arches.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig	2006-05-26 16:18:13.000000000 -0500
+++ linux/arch/i386/Kconfig	2006-06-11 17:01:01.000000000 -0500
@@ -763,6 +763,20 @@ config HOTPLUG_CPU
 	  /sys/devices/system/cpu.
 
 
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments" if EMBEDDED
+
+config CMDLINE
+	string "Initial kernel command string" if EMBEDDED
+	depends on CMDLINE_BOOL
+	default "root=/dev/hda1 ro"
+	help
+	  On some systems, there is no way for the boot loader to pass
+	  arguments to the kernel. For these platforms, you can supply
+	  some command-line options at build time by entering them
+	  here. In most cases you will need to specify the root device
+	  here.
+
 endmenu
 
 
Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c	2006-05-26 16:18:13.000000000 -0500
+++ linux/arch/i386/kernel/setup.c	2006-06-11 16:23:51.000000000 -0500
@@ -713,6 +713,10 @@ static void __init parse_cmdline_early (
 	int len = 0;
 	int userdef = 0;
 
+#ifdef CONFIG_CMDLINE_BOOL
+	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+
 	/* Save unparsed command line copy for /proc/cmdline */
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 


-- 
Mathematics is the supreme nostalgia of our time.
