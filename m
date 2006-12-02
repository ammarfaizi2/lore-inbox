Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWLBLJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWLBLJM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162222AbWLBLIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:08:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:17093 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162219AbWLBK7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EOYC/iNcyp9OJMgGsPqoRmXiar0yVYe0xjZDf898XFcve7BxbkCx6+a+Q7/NicuLfi7YXEKsqO0BWIlhWA6PKyWepwu5WflgivD2Kl/wXeJgESgsE2Opm92q/o+Mvpz7xPdpqUWcsajQCxE07aZw7HQMFeTuUXNnbZTK66ynLM8=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/26] Dynamic kernel command-line - frv
Date: Sat, 2 Dec 2006 12:50:34 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021250.35481.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/frv/kernel/setup.c linux-2.6.19/arch/frv/kernel/setup.c
--- linux-2.6.19.org/arch/frv/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/frv/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -110,7 +110,7 @@ unsigned long __initdata num_mappedpages
 
 struct cpuinfo_frv __nongprelbss boot_cpu_data;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata redboot_command_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_PM
@@ -762,7 +762,7 @@ void __init setup_arch(char **cmdline_p)
 	printk("uClinux FR-V port done by Red Hat Inc <dhowells@redhat.com>\n");
 #endif
 
-	memcpy(saved_command_line, redboot_command_line, COMMAND_LINE_SIZE);
+	memcpy(boot_command_line, redboot_command_line, COMMAND_LINE_SIZE);
 
 	determine_cpu();
 	determine_clocks(1);
@@ -803,7 +803,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/* deal with the command line - RedBoot may have passed one to the kernel */
-	memcpy(command_line, saved_command_line, sizeof(command_line));
+	memcpy(command_line, boot_command_line, sizeof(command_line));
 	*cmdline_p = &command_line[0];
 	parse_cmdline_early(command_line);
 
