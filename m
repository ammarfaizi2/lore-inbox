Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUCYAVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUCYADP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:15 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:34435 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262881AbUCYABB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:01:01 -0500
Subject: [patch 18/22] __early_param for sparc
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000101.QEZB23486.fed1mtao04.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:01:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/sparc/kernel/setup.c       |    3 +--
 linux-2.6-early_setup-trini/arch/sparc/kernel/vmlinux.lds.S |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/sparc/kernel/setup.c~sparc arch/sparc/kernel/setup.c
--- linux-2.6-early_setup/arch/sparc/kernel/setup.c~sparc	2004-03-24 16:15:09.571032439 -0700
+++ linux-2.6-early_setup-trini/arch/sparc/kernel/setup.c	2004-03-24 16:15:09.577031088 -0700
@@ -244,7 +244,6 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char saved_command_line[256];
 char reboot_command[256];
 enum sparc_cpu sparc_cpu_model;
 
@@ -263,7 +262,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	parse_early_options(cmdline_p);
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
diff -puN arch/sparc/kernel/vmlinux.lds.S~sparc arch/sparc/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/sparc/kernel/vmlinux.lds.S~sparc	2004-03-24 16:15:09.573031989 -0700
+++ linux-2.6-early_setup-trini/arch/sparc/kernel/vmlinux.lds.S	2004-03-24 16:15:09.577031088 -0700
@@ -45,6 +45,9 @@ SECTIONS
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
