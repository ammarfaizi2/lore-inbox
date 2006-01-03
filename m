Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWACOeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWACOeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWACOeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:34:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932373AbWACOeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:34:01 -0500
Date: Tue, 3 Jan 2006 09:33:52 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Make apm buildable without legacy pm.
Message-ID: <20060103143352.GA24937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APM doesn't _need_ the PM_LEGACY junk, so remove it's dependancy
from Kconfig, and ifdef the junk in the code.
Whilst the ifdefs are ugly, when the legacy stuff gets ripped out
so will the ifdefs.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/arch/i386/Kconfig~	2005-12-22 22:06:10.000000000 -0500
+++ linux-2.6.14/arch/i386/Kconfig	2005-12-22 22:06:16.000000000 -0500
@@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM && PM_LEGACY
+	depends on PM
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
--- linux-2.6.14/arch/i386/kernel/apm.c~	2005-12-22 21:53:43.000000000 -0500
+++ linux-2.6.14/arch/i386/kernel/apm.c	2005-12-22 21:54:02.000000000 -0500
@@ -2301,7 +2301,9 @@ static int __init apm_init(void)
 		apm_info.disabled = 1;
 		return -ENODEV;
 	}
+#ifdef CONFIG_PM_LEGACY
 	pm_active = 1;
+#endif
 
 	/*
 	 * Set up a segment that references the real mode segment 0x40
@@ -2407,7 +2409,9 @@ static void __exit apm_exit(void)
 	exit_kapmd = 1;
 	while (kapmd_running)
 		schedule();
+#ifdef CONFIG_PM_LEGACY
 	pm_active = 0;
+#endif
 }
 
 module_init(apm_init);
