Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUCYAYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCYAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:22:33 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:46494 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262902AbUCYABi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:01:38 -0500
Subject: [patch 21/22] __early_param for v850
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040325000135.RGPI4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 19:01:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/v850/kernel/setup.c       |    5 +----
 linux-2.6-early_setup-trini/arch/v850/kernel/vmlinux.lds.S |    5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff -puN arch/v850/kernel/setup.c~v850 arch/v850/kernel/setup.c
--- linux-2.6-early_setup/arch/v850/kernel/setup.c~v850	2004-03-24 16:15:10.470829791 -0700
+++ linux-2.6-early_setup-trini/arch/v850/kernel/setup.c	2004-03-24 16:15:10.474828890 -0700
@@ -41,7 +41,6 @@ extern char _root_fs_image_end __attribu
 
 
 char command_line[512];
-char saved_command_line[512];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
@@ -61,10 +60,8 @@ void set_mem_root (void *addr, size_t le
 
 void __init setup_arch (char **cmdline)
 {
-	/* Keep a copy of command line */
 	*cmdline = command_line;
-	memcpy (saved_command_line, command_line, sizeof saved_command_line);
-	saved_command_line[sizeof saved_command_line - 1] = '\0';
+	parse_early_options(cmdline_p);
 
 	console_verbose ();
 
diff -puN arch/v850/kernel/vmlinux.lds.S~v850 arch/v850/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/v850/kernel/vmlinux.lds.S~v850	2004-03-24 16:15:10.472829340 -0700
+++ linux-2.6-early_setup-trini/arch/v850/kernel/vmlinux.lds.S	2004-03-24 16:15:10.474828890 -0700
@@ -109,6 +109,11 @@
 			*(.init.setup)	/* 2.5 convention */		      \
 			*(.setup.init)	/* 2.4 convention */		      \
 		___setup_end = . ;					      \
+
+		__early_begin = .;
+			*(__early_param)
+		__early_end = .;
+
 		___start___param = . ;					      \
 			*(__param)					      \
 		___stop___param = . ;					      \

_
