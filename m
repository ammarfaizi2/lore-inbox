Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVDULTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVDULTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVDULSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:18:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20101 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261293AbVDULRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:17:25 -0400
Date: Thu, 21 Apr 2005 13:07:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: kill config_pm_disk
Message-ID: <20050421110724.GA14328@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_PM_DISK is long gone, but it still managed to survived at few
places.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/arch/i386/mm/init.c	2005-03-19 00:31:06.000000000 +0100
+++ linux/arch/i386/mm/init.c	2005-03-25 09:08:37.000000000 +0100
@@ -352,7 +352,7 @@
 #endif
 }
 
-#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
--- clean/mm/page_io.c	2005-04-05 10:55:35.000000000 +0200
+++ linux/mm/page_io.c	2005-04-05 10:57:21.000000000 +0200
@@ -127,7 +127,7 @@
 	return ret;
 }
 
-#if defined(CONFIG_SOFTWARE_SUSPEND) || defined(CONFIG_PM_DISK)
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * A scruffy utility function to read or write an arbitrary swap page
  * and wait on the I/O.  The caller must have a ref on the page.
--- clean/arch/i386/defconfig	2005-03-19 00:31:05.000000000 +0100
+++ linux/arch/i386/defconfig	2005-03-25 09:08:37.000000000 +0100
@@ -126,7 +126,6 @@
 #
 CONFIG_PM=y
 CONFIG_SOFTWARE_SUSPEND=y
-# CONFIG_PM_DISK is not set
 
 #
 # ACPI (Advanced Configuration and Power Interface) Support

-- 
Boycott Kodak -- for their patent abuse against Java.
