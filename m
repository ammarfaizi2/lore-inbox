Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCYAmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUCYAkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:40:11 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:54169 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262589AbUCXX6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:58:20 -0500
Subject: [patch 5/22] __early_param for alpha
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235818.RFEO4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:58:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/alpha/kernel/setup.c       |    3 +--
 linux-2.6-early_setup-trini/arch/alpha/kernel/vmlinux.lds.S |    5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff -puN arch/alpha/kernel/setup.c~alpha arch/alpha/kernel/setup.c
--- linux-2.6-early_setup/arch/alpha/kernel/setup.c~alpha	2004-03-24 16:15:06.043826820 -0700
+++ linux-2.6-early_setup-trini/arch/alpha/kernel/setup.c	2004-03-24 16:15:06.048825694 -0700
@@ -115,7 +115,6 @@ static void get_sysnames(unsigned long, 
 			 char **, char **);
 
 static char command_line[COMMAND_LINE_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
@@ -527,8 +526,8 @@ setup_arch(char **cmdline_p)
 	} else {
 		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
-	strcpy(saved_command_line, command_line);
 	*cmdline_p = command_line;
+	parse_early_options(cmdline_p);
 
 	/* 
 	 * Process command-line arguments.
diff -puN arch/alpha/kernel/vmlinux.lds.S~alpha arch/alpha/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/alpha/kernel/vmlinux.lds.S~alpha	2004-03-24 16:15:06.045826370 -0700
+++ linux-2.6-early_setup-trini/arch/alpha/kernel/vmlinux.lds.S	2004-03-24 16:15:06.049825469 -0700
@@ -45,6 +45,11 @@ SECTIONS
   __setup_end = .;
 
   . = ALIGN(8);
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
+
+  . = ALIGN(8);
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;

_
