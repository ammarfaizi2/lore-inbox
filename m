Return-Path: <linux-kernel-owner+w=401wt.eu-S932405AbXARNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbXARNFa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXARNFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:05:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407AbXARNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:20 -0500
Message-Id: <20070118130031.447103000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:15 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 26/26] Dynamic kernel command-line - xtensa
Content-Disposition: inline; filename=dynamic-kernel-command-line-xtensa.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

---
 arch/xtensa/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/xtensa/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/xtensa/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/xtensa/kernel/setup.c
@@ -78,7 +78,7 @@ extern unsigned long loops_per_jiffy;
 
 /* Command line specified as configuration option. */
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_CMDLINE_BOOL
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
@@ -253,8 +253,8 @@ void __init setup_arch(char **cmdline_p)
 	extern int mem_reserve(unsigned long, unsigned long, int);
 	extern void bootmem_init(void);
 
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	*cmdline_p = command_line;
 
 	/* Reserve some memory regions */

-- 
