Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVHKCVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVHKCVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVHKCVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:21:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49303 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932218AbVHKCVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:21:33 -0400
Subject: [PATCH 6/9] generic timekeeping i386 arch specific changes, part 4
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123726813.32531.45.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <1123726463.32531.35.camel@cog.beaverton.ibm.com>
	 <1123726619.32531.38.camel@cog.beaverton.ibm.com>
	 <1123726698.32531.41.camel@cog.beaverton.ibm.com>
	 <1123726758.32531.43.camel@cog.beaverton.ibm.com>
	 <1123726813.32531.45.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 19:21:21 -0700
Message-Id: <1123726881.32531.48.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timekeeping subsystem has
been split into 6 parts. This patch, the fourth of six, renames some
ACPI PM variables. 

It applies on top of my timeofday-arch-i386-part3 patch. This patch is
part the timeofday-arch-i386 patchset, so without the following parts it
is not expected to compile.
	
thanks
-john

linux-2.6.13-rc6_timeofday-arch-i386-part4_B5.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -633,7 +633,8 @@ static int __init acpi_parse_hpet(unsign
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -664,13 +665,13 @@ static int __init acpi_parse_fadt(unsign
 		if (fadt->xpm_tmr_blk.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		acpi_pmtmr_ioport = fadt->xpm_tmr_blk.address;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	}
-	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", pmtmr_ioport);
+	if (acpi_pmtmr_ioport)
+		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", acpi_pmtmr_ioport);
 #endif
 	return 0;
 }


