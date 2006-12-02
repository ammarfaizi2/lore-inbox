Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162441AbWLBLAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162441AbWLBLAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbWLBK71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759461AbWLBK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FOm6v4WPpuEUNVSd20QRakcOL9DcINaL8tMPXCWPo38p7186YbPftGpuilFX2cK0TY2HlHmWika4kT9ucW2B+koZ1xJ98f9gEGsu315Ipy/p8CfHa1mO4wISKZLyer9B5ZwexlGd2TI6H6UkljdmD8wdC0M1SxyIvc36KT+IQYM=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/26] Dynamic kernel command-line - arm26
Date: Sat, 2 Dec 2006 12:49:34 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021249.35159.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/arm26/kernel/setup.c linux-2.6.19/arch/arm26/kernel/setup.c
--- linux-2.6.19.org/arch/arm26/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/arm26/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -80,7 +80,7 @@ unsigned long phys_initrd_size __initdat
 static struct meminfo meminfo __initdata = { 0, };
 static struct proc_info_item proc_info;
 static const char *machine_name;
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
@@ -492,8 +492,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) &_edata;
 	init_mm.brk	   = (unsigned long) &_end;
 
-	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	parse_cmdline(&meminfo, cmdline_p, from);
 	bootmem_init(&meminfo);
 	paging_init(&meminfo);
