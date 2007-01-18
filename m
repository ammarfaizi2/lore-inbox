Return-Path: <linux-kernel-owner+w=401wt.eu-S932367AbXARNEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXARNEz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXARNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:35 -0500
Received: from mail.suse.de ([195.135.220.2]:50522 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.759364000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:08 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Paul Mundt <lethal@linux-sh.org>
Subject: [patch 19/26] Dynamic kernel command-line - sh
Content-Disposition: inline; filename=dynamic-kernel-command-line-sh.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---
 arch/sh/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/sh/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sh/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/sh/kernel/setup.c
@@ -75,7 +75,7 @@ static struct sh_machine_vector* __init 
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 
 static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
@@ -90,8 +90,8 @@ static inline void parse_cmdline (char *
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)PAGE_OFFSET+__MEMORY_START;
 	memory_end = memory_start + __MEMORY_SIZE;

-- 
