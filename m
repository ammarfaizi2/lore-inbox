Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759486AbWLBK7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759486AbWLBK7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162917AbWLBK7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759489AbWLBK7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D2Kd/aO3xyqttsjsB114/GDR/Njwslbl2lzL3DqepA6jgHuPGxMJzFG6Cy3awQkgHc90p3au6kB0roFqOE+uC4QOfiLxRsrJptIasjVdeiq6rr395s0dyQ4lE4U5HiEVhHanB+/bc1gmtJutOgi16mTeXGbGuYBQgPojUCjaSB0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/26] Dynamic kernel command-line - v850
Date: Sat, 2 Dec 2006 12:56:59 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021257.00265.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/v850/kernel/setup.c linux-2.6.19/arch/v850/kernel/setup.c
--- linux-2.6.19.org/arch/v850/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/v850/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -42,7 +42,7 @@ extern char _root_fs_image_start __attri
 extern char _root_fs_image_end __attribute__ ((__weak__));
 
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
@@ -64,8 +64,8 @@ void __init setup_arch (char **cmdline)
 {
 	/* Keep a copy of command line */
 	*cmdline = command_line;
-	memcpy (saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy (boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	console_verbose ();
 
