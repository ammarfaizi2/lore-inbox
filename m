Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVJNCTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVJNCTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVJNCTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:19:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7570 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932206AbVJNCTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:19:44 -0400
Subject: [RFC][PATCH 8/12] generic timeofday i386 arch specific changes,
	part 4
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Frank Sorenson <frank@tuxrocks.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <1129256216.27168.41.camel@cog.beaverton.ibm.com>
References: <1129255182.27168.14.camel@cog.beaverton.ibm.com>
	 <1129255761.27168.26.camel@cog.beaverton.ibm.com>
	 <1129255831.27168.29.camel@cog.beaverton.ibm.com>
	 <1129255906.27168.32.camel@cog.beaverton.ibm.com>
	 <1129255977.27168.34.camel@cog.beaverton.ibm.com>
	 <1129256040.27168.35.camel@cog.beaverton.ibm.com>
	 <1129256131.27168.38.camel@cog.beaverton.ibm.com>
	 <1129256216.27168.41.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 19:19:40 -0700
Message-Id: <1129256381.27168.44.camel@cog.beaverton.ibm.com>
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

linux-2.6.14-rc4_timeofday-arch-i386-part4_B7.patch
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


