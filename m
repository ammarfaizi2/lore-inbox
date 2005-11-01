Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVKAWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVKAWcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKAWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:32:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30372 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751367AbVKAWcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:32:17 -0500
Subject: [RFC][PATCH 8/12] generic timeofday i386 arch specific changes,
	part 4
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130884288.27168.472.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
	 <1130883935.27168.461.camel@cog.beaverton.ibm.com>
	 <1130884000.27168.462.camel@cog.beaverton.ibm.com>
	 <1130884065.27168.464.camel@cog.beaverton.ibm.com>
	 <1130884141.27168.467.camel@cog.beaverton.ibm.com>
	 <1130884206.27168.469.camel@cog.beaverton.ibm.com>
	 <1130884288.27168.472.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:32:14 -0800
Message-Id: <1130884334.27168.473.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
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

 boot.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-arch-i386-part4_B9.patch
============================================
diff -ruN linux-2.6-mmtod/arch/i386/kernel/acpi/boot.c mm-fixups/arch/i386/kernel/acpi/boot.c
--- linux-2.6-mmtod/arch/i386/kernel/acpi/boot.c	2005-10-31 17:22:37.000000000 -0800
+++ mm-fixups/arch/i386/kernel/acpi/boot.c	2005-10-31 18:02:44.000000000 -0800
@@ -615,7 +615,8 @@
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -643,21 +644,21 @@
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
+	if (acpi_pmtmr_ioport)
 		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
-		       pmtmr_ioport);
+		       acpi_pmtmr_ioport);
 #endif
 	return 0;
 }


