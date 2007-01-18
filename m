Return-Path: <linux-kernel-owner+w=401wt.eu-S932294AbXARNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbXARNEw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbXARNEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:54872 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130029.702378000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:58 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 09/26] Dynamic kernel command-line - i386
Content-Disposition: inline; filename=dynamic-kernel-command-line-i386.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/i386/kernel/head.S  |    2 +-
 arch/i386/kernel/setup.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/i386/kernel/head.S
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/i386/kernel/head.S
+++ linux-2.6.20-rc4-mm1/arch/i386/kernel/head.S
@@ -104,7 +104,7 @@ ENTRY(startup_32)
 	movzwl OLD_CL_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
-	movl $(saved_command_line - __PAGE_OFFSET),%edi
+	movl $(boot_command_line - __PAGE_OFFSET),%edi
 	movl $(COMMAND_LINE_SIZE/4),%ecx
 	rep
 	movsl
Index: linux-2.6.20-rc4-mm1/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/i386/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/i386/kernel/setup.c
@@ -133,7 +133,7 @@ unsigned long saved_videomode;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
@@ -577,7 +577,7 @@ void __init setup_arch(char **cmdline_p)
 		print_memory_map("user");
 	}
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	max_low_pfn = setup_memory();

-- 
