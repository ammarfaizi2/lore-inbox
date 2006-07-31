Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWGaROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWGaROL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWGaROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:14:11 -0400
Received: from waste.org ([66.93.16.53]:23747 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030260AbWGaROJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:14:09 -0400
Date: Mon, 31 Jul 2006 12:13:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] x86 built-in command line (resend)
Message-ID: <20060731171259.GH6908@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending this as-is because the earlier thread petered out
without any strong arguments against this approach. x86_64 patch to
follow.

Allow setting the kernel command line at compile time on x86.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig	2006-07-26 18:08:28.000000000 -0500
+++ linux/arch/i386/Kconfig	2006-07-27 16:09:13.000000000 -0500
@@ -830,6 +830,20 @@ config COMPAT_VDSO
 
 	  If unsure, say Y.
 
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
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c	2006-07-26 18:08:28.000000000 -0500
+++ linux/arch/i386/kernel/setup.c	2006-07-27 16:09:13.000000000 -0500
@@ -723,6 +723,10 @@ static void __init parse_cmdline_early (
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
