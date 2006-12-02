Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWLBLGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWLBLGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162415AbWLBK7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759477AbWLBK7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BGeTT9PG3N8agmE0fklQ14dYxNom13vDp6rpCYTfnMngQeB0l43sZNtmYIDlfJeoNsWjGB1zvYnMfXOAAQDQoqRGX2ySo57uZsuUVoIEmdmLlD9DHb7thCYp6ZpH6GSQeIQV3q9TXNU3pZlrXHaLbYUeEaosppleoUj5sDUFvbk=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/26] Dynamic kernel command-line - sh64
Date: Sat, 2 Dec 2006 12:55:41 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.42342.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---

diff -urNp linux-2.6.19.org/arch/sh64/kernel/setup.c linux-2.6.19/arch/sh64/kernel/setup.c
--- linux-2.6.19.org/arch/sh64/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sh64/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -83,7 +83,7 @@ extern int sh64_tlb_init(void);
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 unsigned long long memory_start = CONFIG_MEMORY_START;
 unsigned long long memory_end = CONFIG_MEMORY_START + (CONFIG_MEMORY_SIZE_IN_MB * 1024 * 1024);
 
@@ -95,8 +95,8 @@ static inline void parse_mem_cmdline (ch
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
 	  /*
