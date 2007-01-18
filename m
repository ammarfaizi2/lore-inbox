Return-Path: <linux-kernel-owner+w=401wt.eu-S932410AbXARNLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbXARNLE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbXARNEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: from ns2.suse.de ([195.135.220.15]:54875 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.350016000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:04 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 15/26] Dynamic kernel command-line - parisc
Content-Disposition: inline; filename=dynamic-kernel-command-line-parisc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/parisc/kernel/setup.c |    8 ++++----
 arch/parisc/mm/init.c      |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/parisc/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/parisc/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/parisc/kernel/setup.c
@@ -45,7 +45,7 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-char	command_line[COMMAND_LINE_SIZE] __read_mostly;
+char	__initdata command_line[COMMAND_LINE_SIZE] __read_mostly;
 
 /* Intended for ccio/sba/cpu statistics under /proc/bus/{runway|gsc} */
 struct proc_dir_entry * proc_runway_root __read_mostly = NULL;
@@ -71,9 +71,9 @@ void __init setup_cmdline(char **cmdline
 	/* boot_args[0] is free-mem start, boot_args[1] is ptr to command line */
 	if (boot_args[0] < 64) {
 		/* called from hpux boot loader */
-		saved_command_line[0] = '\0';
+		boot_command_line[0] = '\0';
 	} else {
-		strcpy(saved_command_line, (char *)__va(boot_args[1]));
+		strcpy(boot_command_line, (char *)__va(boot_args[1]));
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
@@ -84,7 +84,7 @@ void __init setup_cmdline(char **cmdline
 #endif
 	}
 
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 	*cmdline_p = command_line;
 }
 
Index: linux-2.6.20-rc4-mm1/arch/parisc/mm/init.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/parisc/mm/init.c
+++ linux-2.6.20-rc4-mm1/arch/parisc/mm/init.c
@@ -77,12 +77,12 @@ static void __init mem_limit_func(void)
 {
 	char *cp, *end;
 	unsigned long limit;
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 
 	/* We need this before __setup() functions are called */
 
 	limit = MAX_MEM;
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
 			cp += 4;
 			limit = memparse(cp, &end);

-- 
