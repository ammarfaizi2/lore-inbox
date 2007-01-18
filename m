Return-Path: <linux-kernel-owner+w=401wt.eu-S932332AbXARNEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXARNEy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXARNEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.461808000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:05 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 16/26] Dynamic kernel command-line - powerpc
Content-Disposition: inline; filename=dynamic-kernel-command-line-powerpc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/powerpc/kernel/legacy_serial.c     |    2 +-
 arch/powerpc/kernel/prom.c              |    2 +-
 arch/powerpc/kernel/udbg.c              |    2 +-
 arch/powerpc/platforms/powermac/setup.c |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6.20-rc4-mm1/arch/powerpc/kernel/legacy_serial.c
@@ -498,7 +498,7 @@ static int __init check_legacy_serial_co
 	DBG(" -> check_legacy_serial_console()\n");
 
 	/* The user has requested a console so this is already set up. */
-	if (strstr(saved_command_line, "console=")) {
+	if (strstr(boot_command_line, "console=")) {
 		DBG(" console was specified !\n");
 		return -EBUSY;
 	}
Index: linux-2.6.20-rc4-mm1/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6.20-rc4-mm1/arch/powerpc/kernel/prom.c
@@ -991,7 +991,7 @@ void __init early_init_devtree(void *par
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
Index: linux-2.6.20-rc4-mm1/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/powerpc/kernel/udbg.c
+++ linux-2.6.20-rc4-mm1/arch/powerpc/kernel/udbg.c
@@ -146,7 +146,7 @@ void __init disable_early_printk(void)
 {
 	if (!early_console_initialized)
 		return;
-	if (strstr(saved_command_line, "udbg-immortal")) {
+	if (strstr(boot_command_line, "udbg-immortal")) {
 		printk(KERN_INFO "early console immortal !\n");
 		return;
 	}
Index: linux-2.6.20-rc4-mm1/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/powerpc/platforms/powermac/setup.c
+++ linux-2.6.20-rc4-mm1/arch/powerpc/platforms/powermac/setup.c
@@ -506,8 +506,8 @@ void note_bootable_part(dev_t dev, int p
 	if ((goodness <= current_root_goodness) &&
 	    ROOT_DEV != DEFAULT_ROOT_DEVICE)
 		return;
-	p = strstr(saved_command_line, "root=");
-	if (p != NULL && (p == saved_command_line || p[-1] == ' '))
+	p = strstr(boot_command_line, "root=");
+	if (p != NULL && (p == boot_command_line || p[-1] == ' '))
 		return;
 
 	if (!found_boot) {

-- 
