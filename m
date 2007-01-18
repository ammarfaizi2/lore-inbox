Return-Path: <linux-kernel-owner+w=401wt.eu-S932403AbXARNGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbXARNGy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXARNFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:05:00 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54879 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403AbXARNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:19 -0500
Message-Id: <20070118130031.154878000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:12 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 23/26] Dynamic kernel command-line - um
Content-Disposition: inline; filename=dynamic-kernel-command-line-um.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

---
 arch/um/include/user_util.h |    2 +-
 arch/um/kernel/um_arch.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/um/include/user_util.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/um/include/user_util.h
+++ linux-2.6.20-rc4-mm1/arch/um/include/user_util.h
@@ -38,7 +38,7 @@ extern unsigned long long highmem;
 
 extern char host_info[];
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
 extern unsigned long _unprotected_end;
Index: linux-2.6.20-rc4-mm1/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/um/kernel/um_arch.c
+++ linux-2.6.20-rc4-mm1/arch/um/kernel/um_arch.c
@@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&panic_exit_notifier);
 	paging_init();
-        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }

-- 
