Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162938AbWLBLCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162938AbWLBLCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162930AbWLBLA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759467AbWLBK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RFninT9gC5Ash09nwX7zjgvqP8k2QwmXmVgZ2MVngjceAZgaG8R3DO1wTIdsX+ZR7raKFVKZRUr4PwXVR3jvGJg2eXW5uaN0+QFE8FBxaCpMHtlJu86mbigQ7OvB7mRzcCc8xsokU5fLeNXzOuBW3ycEJqExyZPkF/WgMsxGv9g=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/26] Dynamic kernel command-line - m68knommu
Date: Sat, 2 Dec 2006 12:53:03 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021253.04285.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m68knommu/kernel/setup.c linux-2.6.19/arch/m68knommu/kernel/setup.c
--- linux-2.6.19.org/arch/m68knommu/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m68knommu/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -47,7 +47,7 @@ unsigned long memory_end;
 EXPORT_SYMBOL(memory_start);
 EXPORT_SYMBOL(memory_end);
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
@@ -234,8 +234,8 @@ void setup_arch(char **cmdline_p)
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p))
