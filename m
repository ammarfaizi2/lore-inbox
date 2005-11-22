Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVKVBgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVKVBgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVKVBgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:36:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:7143 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964832AbVKVBgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:36:10 -0500
Date: Mon, 21 Nov 2005 18:36:08 -0700
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
Message-Id: <20051122013608.18537.15969.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
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

linux-2.6.15-rc1-mm2_timeofday-arch-i386-part4_B11.patch
============================================
diff -ruN tod-mm_1/arch/i386/kernel/acpi/boot.c tod-mm_2/arch/i386/kernel/acpi/boot.c
--- tod-mm_1/arch/i386/kernel/acpi/boot.c	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/acpi/boot.c	2005-11-21 16:52:07.000000000 -0800
@@ -607,7 +607,8 @@
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -635,21 +636,22 @@
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
