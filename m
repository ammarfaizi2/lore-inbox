Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUCYAs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUCYAjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:39:03 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:55740 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262704AbUCYABR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:01:17 -0500
Subject: [patch 19/22] __early_param for sparc64
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000109.YGMO19401.fed1mtao06.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:01:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/sparc64/kernel/setup.c       |    3 +--
 linux-2.6-early_setup-trini/arch/sparc64/kernel/vmlinux.lds.S |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/sparc64/kernel/setup.c~sparc64 arch/sparc64/kernel/setup.c
--- linux-2.6-early_setup/arch/sparc64/kernel/setup.c~sparc64	2004-03-24 16:15:09.878963088 -0700
+++ linux-2.6-early_setup-trini/arch/sparc64/kernel/setup.c	2004-03-24 16:15:09.883961962 -0700
@@ -451,7 +451,6 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char saved_command_line[256];
 char reboot_command[256];
 
 static struct pt_regs fake_swapper_regs = { { 0, }, 0, 0, 0, 0 };
@@ -476,7 +475,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	parse_early_options(cmdline_p);
 
 	printk("ARCH: SUN4U\n");
 
diff -puN arch/sparc64/kernel/vmlinux.lds.S~sparc64 arch/sparc64/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/sparc64/kernel/vmlinux.lds.S~sparc64	2004-03-24 16:15:09.880962638 -0700
+++ linux-2.6-early_setup-trini/arch/sparc64/kernel/vmlinux.lds.S	2004-03-24 16:15:09.883961962 -0700
@@ -51,6 +51,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;

_
