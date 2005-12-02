Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVLBD3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVLBD3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLBD3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:29:47 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:27563 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964829AbVLBD0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:26:53 -0500
Date: Thu, 1 Dec 2005 20:26:50 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051202032649.19357.80508.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
References: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 8/13] Time: i386 Conversion - part 4: ACPI PM variable renaming
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the fourth of six, renames some ACPI PM
variables. 

It applies on top of my timeofday-arch-i386-part3 patch. This patch is
part the timeofday-arch-i386 patchset, so without the following parts it
is not expected to compile.
	
thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 boot.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

linux-2.6.15-rc3-mm1_timeofday-arch-i386-part4_B12.patch
==========================
diff -ruN tod-mm1/arch/i386/kernel/acpi/boot.c tod-mm2/arch/i386/kernel/acpi/boot.c
--- tod-mm1/arch/i386/kernel/acpi/boot.c	2005-12-01 18:12:56.000000000 -0800
+++ tod-mm2/arch/i386/kernel/acpi/boot.c	2005-12-01 18:25:30.000000000 -0800
@@ -609,7 +609,8 @@
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -637,21 +638,22 @@
 		    ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		acpi_pmtmr_ioport = fadt->xpm_tmr_blk.address;
 		/*
 		 * "X" fields are optional extensions to the original V1.0
 		 * fields, so we must selectively expand V1.0 fields if the
 		 * corresponding X field is zero.
 	 	 */
-		if (!pmtmr_ioport)
-			pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		if (!acpi_pmtmr_ioport)
+			acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	}
-	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
-		       pmtmr_ioport);
+
+	if (acpi_pmtmr_ioport)
+		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", acpi_pmtmr_ioport);
+
 #endif
 	return 0;
 }
