Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162939AbWLBLCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162939AbWLBLCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162028AbWLBLAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:56806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759461AbWLBK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XdyrvqQn/74Eo0EFGyu4aT4fVszF58oxbBTKIbtouJHG/G9Z1Lb1SthFeKTFv6OKnvIUorMvjVhxLx2Bi3XxzKWM4Th1qVGrDkKH3V0ZjoGRAn4kiDjx8+VbbqqeH0p1SESBDhyAD2Gpe9rlVU75oEJH3X40KUK1HWRomAlIxKc=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/26] Dynamic kernel command-line - m32r
Date: Sat, 2 Dec 2006 12:52:13 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021252.14464.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m32r/kernel/setup.c linux-2.6.19/arch/m32r/kernel/setup.c
--- linux-2.6.19.org/arch/m32r/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m32r/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -64,7 +64,7 @@ struct screen_info screen_info = {
 
 extern int root_mountflags;
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static struct resource data_resource = {
 	.name   = "Kernel data",
@@ -95,8 +95,8 @@ static __inline__ void parse_mem_cmdline
 	int usermem = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)CONFIG_MEMORY_START+PAGE_OFFSET;
 	memory_end = memory_start+(unsigned long)CONFIG_MEMORY_SIZE;
