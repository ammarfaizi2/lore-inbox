Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWGaRQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWGaRQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWGaRQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:16:04 -0400
Received: from waste.org ([66.93.16.53]:53187 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030261AbWGaRQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:16:03 -0400
Date: Mon, 31 Jul 2006 12:14:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de
Subject: [PATCH] x86_64 built-in command line
Message-ID: <20060731171442.GI6908@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow setting a command line at build time on x86_64. Compiled but not
tested.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig	2006-07-26 18:08:29.000000000 -0500
+++ linux/arch/x86_64/Kconfig	2006-07-27 17:19:50.000000000 -0500
@@ -558,6 +558,20 @@ config K8_NB
 	def_bool y
 	depends on AGP_AMD64 || IOMMU || (PCI && NUMA)
 
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
 
 #
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c	2006-07-26 18:08:29.000000000 -0500
+++ linux/arch/x86_64/kernel/setup.c	2006-07-27 17:26:51.000000000 -0500
@@ -289,6 +289,10 @@ static __init void parse_cmdline_early (
 	int len = 0;
 	int userdef = 0;
 
+#ifdef CONFIG_CMDLINE_BOOL
+	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+
 	for (;;) {
 		if (c != ' ') 
 			goto next_char; 

-- 
Mathematics is the supreme nostalgia of our time.
