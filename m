Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTDLVgl (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDLVgl (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:36:41 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13828 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S261809AbTDLVgj (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:36:39 -0400
Date: Sat, 12 Apr 2003 23:47:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: APIC is not properly suspending in 2.5.67 on UP
Message-ID: <20030412214701.GA11568@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is needed otherwise APIC thinks it is not active, does not
suspend properly, and kills machine. Extra whitespace killed (looks
ugly). Please apply,
								Pavel

%patch
Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c	2003-04-08 13:19:44.000000000 +0200
+++ linux/arch/i386/kernel/apic.c	2003-04-12 23:38:21.000000000 +0200
@@ -449,6 +449,7 @@
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
+	apic_pm_activate();
 }
 
 #ifdef CONFIG_PM
@@ -652,9 +653,7 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
 	apic_pm_activate();
-
 	return 0;
 
 no_apic:
@@ -1133,11 +1132,8 @@
 	}
 
 	verify_local_APIC();
-
 	connect_bsp_APIC();
-
 	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -1148,6 +1144,5 @@
 			setup_IO_APIC();
 #endif
 	setup_boot_APIC_clock();
-
 	return 0;
 }

%diffstat
 apic.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
