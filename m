Return-Path: <linux-kernel-owner+w=401wt.eu-S932344AbXARNER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXARNER (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXARNEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:54867 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbXARNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:16 -0500
Message-Id: <20070118130028.492492000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:51 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 02/26] Dynamic kernel command-line - alpha
Content-Disposition: inline; filename=dynamic-kernel-command-line-alpha.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/alpha/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/alpha/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/alpha/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/alpha/kernel/setup.c
@@ -122,7 +122,7 @@ static void get_sysnames(unsigned long, 
 			 char **, char **);
 static void determine_cpu_caches (unsigned int);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
@@ -547,7 +547,7 @@ setup_arch(char **cmdline_p)
 	} else {
 		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
-	strcpy(saved_command_line, command_line);
+	strcpy(boot_command_line, command_line);
 	*cmdline_p = command_line;
 
 	/* 
@@ -589,7 +589,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {

-- 
