Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162916AbWLBK7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162916AbWLBK7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbWLBK73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162028AbWLBK7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aBgQL8iMjmY6tfaoMdommYiUARL//6nIqkzaHffbaBsNl4mmcefv0SmQNRCqafwM+cxuR9QNaSjvnxlRJOXO9HADbpY92J1cNIyOeM1yHw6n8ILk/ZORwjQ1WftN0GWrbYus5ZR8rWYcKSS6DNBGQtEujlnvgU28X5UohbnJcmI=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/26] Dynamic kernel command-line - avr32
Date: Sat, 2 Dec 2006 12:49:54 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021249.55192.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---

diff -urNp linux-2.6.19.org/arch/avr32/kernel/setup.c linux-2.6.19/arch/avr32/kernel/setup.c
--- linux-2.6.19.org/arch/avr32/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/avr32/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -44,7 +44,7 @@ struct avr32_cpuinfo boot_cpu_data = {
 };
 EXPORT_SYMBOL(boot_cpu_data);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * Should be more than enough, but if you have a _really_ complex
@@ -202,7 +202,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
 
 static int __init parse_tag_cmdline(struct tag *tag)
 {
-	strlcpy(saved_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
 	return 0;
 }
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
@@ -318,7 +318,7 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	parse_early_param();
 
