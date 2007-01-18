Return-Path: <linux-kernel-owner+w=401wt.eu-S932464AbXARNIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbXARNIW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXARNE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:56 -0500
Received: from mail.suse.de ([195.135.220.2]:50523 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbXARNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:19 -0500
Message-Id: <20070118130030.858906000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:09 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Paul Mundt <lethal@linux-sh.org>
Subject: [patch 20/26] Dynamic kernel command-line - sh64
Content-Disposition: inline; filename=dynamic-kernel-command-line-sh64.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---
 arch/sh64/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/sh64/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sh64/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/sh64/kernel/setup.c
@@ -83,7 +83,7 @@ extern int sh64_tlb_init(void);
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 unsigned long long memory_start = CONFIG_MEMORY_START;
 unsigned long long memory_end = CONFIG_MEMORY_START + (CONFIG_MEMORY_SIZE_IN_MB * 1024 * 1024);
 
@@ -95,8 +95,8 @@ static inline void parse_mem_cmdline (ch
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
 	  /*

-- 
