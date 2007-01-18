Return-Path: <linux-kernel-owner+w=401wt.eu-S932432AbXARNE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXARNE4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbXARNEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:21 -0500
Received: from mail.suse.de ([195.135.220.2]:50513 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbXARNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:16 -0500
Message-Id: <20070118130029.169197000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:54 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [patch 05/26] Dynamic kernel command-line - avr32
Content-Disposition: inline; filename=dynamic-kernel-command-line-avr32.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---
 arch/avr32/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/avr32/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/avr32/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/avr32/kernel/setup.c
@@ -44,7 +44,7 @@ struct avr32_cpuinfo boot_cpu_data = {
 };
 EXPORT_SYMBOL(boot_cpu_data);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * Should be more than enough, but if you have a _really_ complex
@@ -202,7 +202,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
 
 static int __init parse_tag_cmdline(struct tag *tag)
 {
-	strlcpy(saved_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
 	return 0;
 }
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
@@ -294,7 +294,7 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	parse_early_param();
 

-- 
