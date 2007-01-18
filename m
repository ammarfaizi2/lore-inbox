Return-Path: <linux-kernel-owner+w=401wt.eu-S932378AbXARNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXARNEw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXARNEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54870 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130029.490101000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:56 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 07/26] Dynamic kernel command-line - frv
Content-Disposition: inline; filename=dynamic-kernel-command-line-frv.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/frv/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/frv/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/frv/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/frv/kernel/setup.c
@@ -110,7 +110,7 @@ unsigned long __initdata num_mappedpages
 
 struct cpuinfo_frv __nongprelbss boot_cpu_data;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata redboot_command_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_PM
@@ -762,7 +762,7 @@ void __init setup_arch(char **cmdline_p)
 	printk("uClinux FR-V port done by Red Hat Inc <dhowells@redhat.com>\n");
 #endif
 
-	memcpy(saved_command_line, redboot_command_line, COMMAND_LINE_SIZE);
+	memcpy(boot_command_line, redboot_command_line, COMMAND_LINE_SIZE);
 
 	determine_cpu();
 	determine_clocks(1);
@@ -803,7 +803,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/* deal with the command line - RedBoot may have passed one to the kernel */
-	memcpy(command_line, saved_command_line, sizeof(command_line));
+	memcpy(command_line, boot_command_line, sizeof(command_line));
 	*cmdline_p = &command_line[0];
 	parse_cmdline_early(command_line);
 

-- 
