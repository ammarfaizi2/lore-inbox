Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUCYAEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCYADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:48 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:54172 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262773AbUCYAA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:00:26 -0500
Subject: [patch 15/22] __early_param for ppc64
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, paulus@samba.org
From: trini@kernel.crashing.org
Message-Id: <20040325000024.RGAG4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:00:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Paul Mackerras <paulus@samba.org>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 include/asm-ppc64/setup.h                                   |    0 
 linux-2.6-early_setup-trini/arch/ppc64/kernel/setup.c       |    4 +---
 linux-2.6-early_setup-trini/arch/ppc64/kernel/vmlinux.lds.S |    5 +++++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/kernel/setup.c~ppc64 arch/ppc64/kernel/setup.c
--- linux-2.6-early_setup/arch/ppc64/kernel/setup.c~ppc64	2004-03-24 16:15:08.671235087 -0700
+++ linux-2.6-early_setup-trini/arch/ppc64/kernel/setup.c	2004-03-24 16:15:08.679233286 -0700
@@ -80,7 +80,6 @@ unsigned long decr_overclock_proc0_set =
 
 int powersave_nap;
 
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 
 void parse_cmd_line(unsigned long r3, unsigned long r4, unsigned long r5,
@@ -619,9 +618,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 	
-	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
 	*cmdline_p = cmd_line;
+	parse_early_options(cmdline_p);
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
diff -puN arch/ppc64/kernel/vmlinux.lds.S~ppc64 arch/ppc64/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/ppc64/kernel/vmlinux.lds.S~ppc64	2004-03-24 16:15:08.673234637 -0700
+++ linux-2.6-early_setup-trini/arch/ppc64/kernel/vmlinux.lds.S	2004-03-24 16:15:08.680233061 -0700
@@ -59,6 +59,11 @@ SECTIONS
 	*(.init.setup)
 	__setup_end = .;
 	}
+  __early_param : {
+	__early_begin = .;
+	*(__early_param)
+	__early_end = .;
+	}
 
   __param : {
 	__start___param = .;
diff -puN include/asm-ppc64/machdep.h~ppc64 include/asm-ppc64/machdep.h
diff -puN include/asm-ppc64/setup.h~ppc64 include/asm-ppc64/setup.h

_
