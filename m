Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759491AbWLBK7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759491AbWLBK7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162223AbWLBK70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:56806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759457AbWLBK7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QBkbvIAia1o0dcf2jF1juIDhdQzUlTf/dkA9kCuGrbV4E3LO06uYLT2j2lb7Vn3Wiy/10KdLSFXtuGq1VtgAttbGVjXbuxQaox5fwuMNTVbqb059dKeNMrEX04gIRTQuEK6oLlHxVZjeRwo9XvQXZE9dpW9ZKeERfkjSLcLdXqY=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/26] Dynamic kernel command-line - arm
Date: Sat, 2 Dec 2006 12:49:14 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021249.15662.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/arm/kernel/setup.c linux-2.6.19/arch/arm/kernel/setup.c
--- linux-2.6.19.org/arch/arm/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/arm/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -106,7 +106,7 @@ unsigned long phys_initrd_size __initdat
 static struct meminfo meminfo __initdata = { 0, };
 static const char *cpu_name;
 static const char *machine_name;
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -806,8 +806,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) &_edata;
 	init_mm.brk	   = (unsigned long) &_end;
 
-	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	parse_cmdline(cmdline_p, from);
 	paging_init(&meminfo, mdesc);
 	request_standard_resources(&meminfo, mdesc);
