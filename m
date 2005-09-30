Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVI3Aup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVI3Aup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVI3Auo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:50:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:29863 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932511AbVI3Aun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:50:43 -0400
Subject: [RFC][PATCH 8/11] generic timeofday i386 arch specific changes,
	part 4
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041391.8195.323.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
	 <1128041118.8195.314.camel@cog.beaverton.ibm.com>
	 <1128041188.8195.317.camel@cog.beaverton.ibm.com>
	 <1128041282.8195.319.camel@cog.beaverton.ibm.com>
	 <1128041345.8195.321.camel@cog.beaverton.ibm.com>
	 <1128041391.8195.323.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:50:39 -0700
Message-Id: <1128041439.8195.325.camel@cog.beaverton.ibm.com>
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

linux-2.6.14-rc2_timeofday-arch-i386-part4_B6.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
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
@@ -640,14 +641,15 @@ static int __init acpi_parse_fadt(unsign
 		    ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		acpi_pmtmr_ioport = fadt->xpm_tmr_blk.address;
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


