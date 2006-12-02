Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWLBLGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWLBLGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161830AbWLBK76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:61385 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759479AbWLBK7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=omNxds3v84sCppimFydjeEm+/OfN7m2Kmnfm2eOmsEejD/EuU35e9aKR4irEBLJ+2cvXWqCdH2pbhGz++rZMAQ2ZKRSHeWfzIWv1ZGsw2+sQxzk+pY6RGFWAhp9J5V7wHC9AyTjztKv7rYkW/ZrFtcCekna6uvx9H8/dGk/uqJ0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/26] Dynamic kernel command-line - sh
Date: Sat, 2 Dec 2006 12:55:18 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.19181.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---

diff -urNp linux-2.6.19.org/arch/sh/kernel/setup.c linux-2.6.19/arch/sh/kernel/setup.c
--- linux-2.6.19.org/arch/sh/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sh/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -75,7 +75,7 @@ static struct sh_machine_vector* __init 
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 
 static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
@@ -91,8 +91,8 @@ static inline void parse_cmdline (char *
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)PAGE_OFFSET+__MEMORY_START;
 	memory_end = memory_start + __MEMORY_SIZE;
