Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUCYAih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCYAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:38:37 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:53755 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262900AbUCYABY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:01:24 -0500
Subject: [patch 20/22] __early_param for UM
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000124.FKSL2430.fed1mtao02.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:01:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/um/kernel/um_arch.c    |    1 +
 linux-2.6-early_setup-trini/arch/um/kernel/user_util.c  |    1 -
 linux-2.6-early_setup-trini/include/asm-um/common.lds.S |    4 ++++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/um_arch.c~um arch/um/kernel/um_arch.c
--- linux-2.6-early_setup/arch/um/kernel/um_arch.c~um	2004-03-24 16:15:10.165898466 -0700
+++ linux-2.6-early_setup-trini/arch/um/kernel/um_arch.c	2004-03-24 16:15:10.171897115 -0700
@@ -395,6 +395,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
  	strcpy(command_line, saved_command_line);
  	*cmdline_p = command_line;
+	parse_early_options(cmdline_p);
 	setup_hostinfo();
 }
 
diff -puN arch/um/kernel/user_util.c~um arch/um/kernel/user_util.c
--- linux-2.6-early_setup/arch/um/kernel/user_util.c~um	2004-03-24 16:15:10.167898016 -0700
+++ linux-2.6-early_setup-trini/arch/um/kernel/user_util.c	2004-03-24 16:15:10.172896890 -0700
@@ -34,7 +34,6 @@
 #define COMMAND_LINE_SIZE _POSIX_ARG_MAX
 
 /* Changed in linux_main and setup_arch, which run before SMP is started */
-char saved_command_line[COMMAND_LINE_SIZE] = { 0 };
 char command_line[COMMAND_LINE_SIZE] = { 0 };
 
 void add_arg(char *cmd_line, char *arg)
diff -puN include/asm-um/common.lds.S~um include/asm-um/common.lds.S
--- linux-2.6-early_setup/include/asm-um/common.lds.S~um	2004-03-24 16:15:10.169897565 -0700
+++ linux-2.6-early_setup-trini/include/asm-um/common.lds.S	2004-03-24 16:15:10.172896890 -0700
@@ -46,6 +46,10 @@
   .init.setup : { *(.init.setup) }
   __setup_end = .;
 
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
+
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;

_
