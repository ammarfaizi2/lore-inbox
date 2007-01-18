Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbXARNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXARNEx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXARNEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:30 -0500
Received: from ns.suse.de ([195.135.220.2]:50519 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.139166000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:02 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 13/26] Dynamic kernel command-line - m68knommu
Content-Disposition: inline; filename=dynamic-kernel-command-line-m68knommu.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/m68knommu/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/m68knommu/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/m68knommu/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/m68knommu/kernel/setup.c
@@ -44,7 +44,7 @@ unsigned long memory_end;
 EXPORT_SYMBOL(memory_start);
 EXPORT_SYMBOL(memory_end);
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
@@ -231,8 +231,8 @@ void setup_arch(char **cmdline_p)
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p))

-- 
