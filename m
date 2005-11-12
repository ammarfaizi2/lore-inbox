Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbVKLEvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVKLEvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVKLEu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:50:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:51617 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751337AbVKLEtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:49:46 -0500
Date: Fri, 11 Nov 2005 21:49:45 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Message-Id: <20051112044944.8240.2373.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
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

linux-2.6.14_timeofday-arch-i386-part4_B10.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index bb9ecdc..6d4bd42 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -612,7 +612,8 @@ static int __init acpi_parse_hpet(unsign
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -640,21 +641,22 @@ static int __init acpi_parse_fadt(unsign
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
