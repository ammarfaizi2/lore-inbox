Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUICQwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUICQwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICQqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:46:44 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:62336
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S269456AbUICQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:46:10 -0400
To: alan@lxorguk.ukuu.org.uk, apw@shadowen.org
Subject: Re: [PATCH] tidy AMD 768MPX fix
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1094225233.8102.16.camel@localhost.localdomain>
Message-Id: <E1C3HCK-0001aU-H4@localhost.localdomain>
From: Andy Whitcroft <apw@shadowen.org>
Date: Fri, 03 Sep 2004 17:46:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if we use a different software page size in some future x86 release
> the workaround is to reserve 4096 bytes. I don't think this change makes
> sense therefore.

I have always assumed that PAGE_SIZE in the bootmem allocator was
hardware page size; such that if software PAGE_SIZE was to change that
it would necessarily be replaced with two different constants.  But fair
enough.  In that case perhaps we should at least fix the code indent
etc.  Revised patch below.

-apw

=== 8< ===
Fix indentation and layout of AMD 768MPX errata #56 fix.

Revision: $Rev: 620 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 020-tidy-AMD-768MPX-fix
---
 setup.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/i386/kernel/setup.c current/arch/i386/kernel/setup.c
--- reference/arch/i386/kernel/setup.c	2004-09-02 18:05:57.000000000 +0100
+++ current/arch/i386/kernel/setup.c	2004-09-03 17:34:58.000000000 +0100
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
+		reserve_bootmem(0xa0000 - 4096, 4096);
 
 #ifdef CONFIG_SMP
 	/*
