Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVCYIDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVCYIDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVCYIDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:03:35 -0500
Received: from everest.2mbit.com ([24.123.221.2]:11692 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261534AbVCYIDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:03:32 -0500
Date: Fri, 25 Mar 2005 03:03:30 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch] remove CONFIG_PM_DISK
Message-ID: <20050325080330.GA1581@everest.sosdg.org>
Reply-To: coywolf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Pmdisk was merged in a few months ago. This removes CONFIG_PM_DISK
for conditional compilation.

	Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

diff -pruN 2.6.11-mm4/arch/i386/defconfig 2.6.11-mm4-cy/arch/i386/defconfig
--- 2.6.11-mm4/arch/i386/defconfig	2005-03-17 01:21:16.000000000 +0800
+++ 2.6.11-mm4-cy/arch/i386/defconfig	2005-03-20 02:24:48.000000000 +0800
@@ -126,7 +126,6 @@ CONFIG_HAVE_DEC_LOCK=y
 #
 CONFIG_PM=y
 CONFIG_SOFTWARE_SUSPEND=y
-# CONFIG_PM_DISK is not set
 
 #
 # ACPI (Advanced Configuration and Power Interface) Support
diff -pruN 2.6.11-mm4/arch/i386/mm/init.c 2.6.11-mm4-cy/arch/i386/mm/init.c
--- 2.6.11-mm4/arch/i386/mm/init.c	2005-03-17 01:21:17.000000000 +0800
+++ 2.6.11-mm4-cy/arch/i386/mm/init.c	2005-03-20 02:41:26.000000000 +0800
@@ -352,7 +352,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
diff -pruN 2.6.11-mm4/mm/page_io.c 2.6.11-mm4-cy/mm/page_io.c
--- 2.6.11-mm4/mm/page_io.c	2004-08-20 14:20:15.000000000 +0800
+++ 2.6.11-mm4-cy/mm/page_io.c	2005-03-20 02:36:54.000000000 +0800
@@ -127,7 +127,7 @@ out:
 	return ret;
 }
 
-#if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_PM_DISK)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * A scruffy utility function to read or write an arbitrary swap page
  * and wait on the I/O.  The caller must have a ref on the page.
