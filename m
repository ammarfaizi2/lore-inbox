Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbULMXlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbULMXlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbULMXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:41:36 -0500
Received: from terminus.zytor.com ([209.128.68.124]:35461 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261338AbULMXld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:41:33 -0500
Message-ID: <41BE28A0.7050301@zytor.com>
Date: Mon, 13 Dec 2004 15:41:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Trivial cleanup in arch/i386/kernel/head.S
Content-Type: multipart/mixed;
 boundary="------------090201010108090007000409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201010108090007000409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Trivial cleanup in arch/i386/kernel/head.S

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>

--------------090201010108090007000409
Content-Type: text/x-patch;
 name="head-ebx-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="head-ebx-cleanup.patch"

Index: linux-2.5/arch/i386/kernel/head.S
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/head.S,v
retrieving revision 1.36
diff -u -r1.36 head.S
--- linux-2.5/arch/i386/kernel/head.S	23 Aug 2004 19:41:58 -0000	1.36
+++ linux-2.5/arch/i386/kernel/head.S	13 Dec 2004 23:37:05 -0000
@@ -128,9 +128,6 @@
 	movl %eax,%fs
 	movl %eax,%gs
 
-	xorl %ebx,%ebx
-	incl %ebx				/* This is a secondary processor (AP) */
-
 /*
  *	New page tables may be in 4Mbyte page mode and may
  *	be using the global pages. 
@@ -148,7 +145,7 @@
 #define cr4_bits mmu_cr4_features-__PAGE_OFFSET
 	movl cr4_bits,%edx
 	andl %edx,%edx
-	jz 3f
+	jz 6f
 	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
 	orl %edx,%eax
 	movl %eax,%cr4
@@ -176,9 +173,10 @@
 	wrmsr
 
 6:
-	/* cpuid clobbered ebx, set it up again: */
+	/* This is a secondary processor (AP) */
 	xorl %ebx,%ebx
 	incl %ebx
+
 3:
 #endif /* CONFIG_SMP */
 

--------------090201010108090007000409--
