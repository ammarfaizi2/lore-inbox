Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUCYAHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUCYAF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:05:57 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:41626 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262424AbUCXX6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:58:55 -0500
Subject: [patch 8/22] __early_param for h8300
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235853.RFJZ4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:58:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/h8300/kernel/setup.c       |    4 +---
 linux-2.6-early_setup-trini/arch/h8300/kernel/vmlinux.lds.S |    5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/h8300/kernel/setup.c~h8300 arch/h8300/kernel/setup.c
--- linux-2.6-early_setup/arch/h8300/kernel/setup.c~h8300	2004-03-24 16:15:06.866641509 -0700
+++ linux-2.6-early_setup-trini/arch/h8300/kernel/setup.c	2004-03-24 16:15:06.870640609 -0700
@@ -61,7 +61,6 @@ unsigned long memory_end;
 struct task_struct *_current_task;
 
 char command_line[512];
-char saved_command_line[512];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
@@ -166,8 +165,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, sizeof(saved_command_line));
-	saved_command_line[sizeof(saved_command_line)-1] = 0;
+	parse_early_options(cmdline_p);
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
diff -puN arch/h8300/kernel/vmlinux.lds.S~h8300 arch/h8300/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/h8300/kernel/vmlinux.lds.S~h8300	2004-03-24 16:15:06.868641059 -0700
+++ linux-2.6-early_setup-trini/arch/h8300/kernel/vmlinux.lds.S	2004-03-24 16:15:06.870640609 -0700
@@ -131,6 +131,11 @@ SECTIONS
 		*(.init.setup)
 	. = ALIGN(0x4) ;
 	___setup_end = .;
+
+	__early_begin = .;
+		*(__early_param)
+	__early_end = .;
+
 	___start___param = .;
 		*(__param)
 	___stop___param = .;

_
