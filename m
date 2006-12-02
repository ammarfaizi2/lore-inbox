Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162222AbWLBLJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162222AbWLBLJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162223AbWLBLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:09:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162127AbWLBK7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ddBo5RjD07QJvhGyNvTAITEJktWBM0SeBCTue0yUQ+79Z404eHhe/d/h1PX5ZkBvrHQ+/UI5INwCbrw8BNaAVZpthSqxprJzWavrwC+REwPns3urd9yQA2lFyO7KgLctWo+BjFbpsuJh7nywd99mgyPWai8Y8frcj9WsSRCuGAU=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/26] Dynamic kernel command-line - cris
Date: Sat, 2 Dec 2006 12:50:13 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021250.14013.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set cris_command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/cris/kernel/setup.c linux-2.6.19/arch/cris/kernel/setup.c
--- linux-2.6.19.org/arch/cris/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/cris/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -29,7 +29,7 @@ struct screen_info screen_info;
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
-char cris_command_line[COMMAND_LINE_SIZE] = { 0, };
+char __initdata cris_command_line[COMMAND_LINE_SIZE] = { 0, };
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
@@ -153,8 +153,8 @@ setup_arch(char **cmdline_p)
 #endif
 
 	/* Save command line for future references. */
-	memcpy(saved_command_line, cris_command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy(boot_command_line, cris_command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	/* give credit for the CRIS port */
 	show_etrax_copyright();
