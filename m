Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162921AbWLBLEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162921AbWLBLEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162924AbWLBLAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:17093 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1162422AbWLBK7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BVSn6kZthTbWpGqlGPyLbLswP8mV0P8sfj6qBz5dQyLXUaMUUZriFq7/OTj/K7fFDak34gPRMDwMZd4vVykISBYSbOMMt+OPUqSjhmMKqV4d2oIraAwwIXFLuA3bs1inOZr1pQ095W9X8Z56Or3a3F3iJnyXSlFMPBluvZsLwYk=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/26] Dynamic kernel command-line - xtensa
Date: Sat, 2 Dec 2006 12:58:02 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021258.03303.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/xtensa/kernel/setup.c linux-2.6.19/arch/xtensa/kernel/setup.c
--- linux-2.6.19.org/arch/xtensa/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/xtensa/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -80,7 +80,7 @@ extern unsigned long loops_per_jiffy;
 
 /* Command line specified as configuration option. */
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_CMDLINE_BOOL
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
@@ -255,8 +255,8 @@ void __init setup_arch(char **cmdline_p)
 	extern int mem_reserve(unsigned long, unsigned long, int);
 	extern void bootmem_init(void);
 
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	*cmdline_p = command_line;
 
 	/* Reserve some memory regions */
