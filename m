Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVLATjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLATjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLATjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:39:19 -0500
Received: from fsmlabs.com ([168.103.115.128]:56718 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932417AbVLATjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:39:18 -0500
X-ASG-Debug-ID: 1133465951-589-51-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 1 Dec 2005 11:44:51 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
X-ASG-Orig-Subj: [PATCH] x86_64: Display HPET timer option
Subject: [PATCH] x86_64: Display HPET timer option
Message-ID: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5764
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the HPET timer option isn't visible in menuconfig.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

diff -r f425e4d22fe8 arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Fri Dec  2 03:00:04 2005
+++ b/arch/x86_64/Kconfig	Thu Dec  1 11:41:06 2005
@@ -317,7 +317,7 @@
 
 
 config HPET_TIMER
-	bool
+	bool "HPET timer"
 	default y
 	help
 	  Use the IA-PC HPET (High Precision Event Timer) to manage
@@ -326,6 +326,10 @@
 	  systems, unlike the TSC, but it is more expensive to access,
 	  as it is off-chip.  You can find the HPET spec at
 	  <http://www.intel.com/hardwaredesign/hpetspec.htm>.
+
+config HPET_EMULATE_RTC
+	bool "HPET provides RTC interrupt"
+	depends on HPET_TIMER && RTC=y
 
 config X86_PM_TIMER
 	bool "PM timer"
@@ -342,10 +346,6 @@
 	  The kernel selects the PM timer only as a last resort, so it is
 	  useful to enable just in case.
 
-config HPET_EMULATE_RTC
-	bool "Provide RTC interrupt"
-	depends on HPET_TIMER && RTC=y
-
 config GART_IOMMU
 	bool "IOMMU support"
 	default y
