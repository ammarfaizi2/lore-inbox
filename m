Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269147AbUICQOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269147AbUICQOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUICQOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:14:09 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:60544
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S269147AbUICQOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:14:04 -0400
To: akpm@osdl.org
Subject: [PATCH] tidy AMD 768MPX fix
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Message-Id: <E1C3GhJ-0001YB-7N@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Fri, 03 Sep 2004 17:13:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AMD 768MPX errata #56 fix to use PAGE_SIZE instead of using
4096 in line with other declarations in this file.  Also take the
oppotunity to match indentation.

Revision: $Rev: 612 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 020-tidy-AMD-768MPX-fix
---
 setup.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/setup.c current/arch/i386/kernel/setup.c
--- reference/arch/i386/kernel/setup.c	2004-09-02 18:05:57.000000000 +0100
+++ current/arch/i386/kernel/setup.c	2004-09-03 16:59:45.000000000 +0100
@@ -1052,12 +1052,14 @@ static unsigned long __init setup_memory
 	/* reserve EBDA region, it's a 4K region */
 	reserve_ebda_region();
 
-    /* could be an AMD 768MPX chipset. Reserve a page  before VGA to prevent
-       PCI prefetch into it (errata #56). Usually the page is reserved anyways,
-       unless you have no PS/2 mouse plugged in. */
+	/*
+	 * could be an AMD 768MPX chipset. Reserve a page before VGA to
+	 * prevent PCI prefetch into it (errata #56). Usually the page is
+	 * reserved anyways, unless you have no PS/2 mouse plugged in.
+	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 == 6)
-	     reserve_bootmem(0xa0000 - 4096, 4096);
+		reserve_bootmem(0xa0000 - PAGE_SIZE, PAGE_SIZE);
 
 #ifdef CONFIG_SMP
 	/*
