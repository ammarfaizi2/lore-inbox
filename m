Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272139AbTG1Bul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTG1ABc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272935AbTG0XBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:38 -0400
Date: Sun, 27 Jul 2003 20:58:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307271958.h6RJwRn3029545@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: dont assume newer cpus have the same magic registers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Venkatesh Pallipadi@intel)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/i386/kernel/nmi.c linux-2.6.0-test2-ac1/arch/i386/kernel/nmi.c
--- linux-2.6.0-test2/arch/i386/kernel/nmi.c	2003-07-10 21:10:49.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/i386/kernel/nmi.c	2003-07-16 18:28:14.000000000 +0100
@@ -162,9 +162,15 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				break;
+
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				break;
+
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
 			break;
@@ -348,9 +354,15 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				return;
+
 			setup_p6_watchdog();
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				return;
+
 			if (!setup_p4_watchdog())
 				return;
 			break;
