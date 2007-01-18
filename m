Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbXARNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbXARNEx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbXARNE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:26 -0500
Received: from ns.suse.de ([195.135.220.2]:50515 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130029.586711000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:57 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 08/26] Dynamic kernel command-line - h8300
Content-Disposition: inline; filename=dynamic-kernel-command-line-h8300.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/h8300/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/h8300/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/h8300/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/h8300/kernel/setup.c
@@ -54,7 +54,7 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
@@ -154,8 +154,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 

-- 
