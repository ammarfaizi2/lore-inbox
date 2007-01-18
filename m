Return-Path: <linux-kernel-owner+w=401wt.eu-S932440AbXARNGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbXARNGy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbXARNFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:05:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:54880 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404AbXARNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:19 -0500
Message-Id: <20070118130031.251379000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:13 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 24/26] Dynamic kernel command-line - v850
Content-Disposition: inline; filename=dynamic-kernel-command-line-v850.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

---
 arch/v850/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/v850/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/v850/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/v850/kernel/setup.c
@@ -42,7 +42,7 @@ extern char _root_fs_image_start __attri
 extern char _root_fs_image_end __attribute__ ((__weak__));
 
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
@@ -64,8 +64,8 @@ void __init setup_arch (char **cmdline)
 {
 	/* Keep a copy of command line */
 	*cmdline = command_line;
-	memcpy (saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy (boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	console_verbose ();
 

-- 
