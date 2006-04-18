Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWDRSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWDRSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWDRSoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:44:16 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:1476 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932244AbWDRSoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:44:15 -0400
Date: Tue, 18 Apr 2006 20:44:13 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: make pmtmr_ioport __read_mostly
Message-ID: <20060418184413.GA23331@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

- written on init only, accessed for every timer read --> __read_mostly
- fix broken sentence

Patch tested on 2.6.17-rc1-mm2, rediffed against 2.6.17-rc1-mm3.
I did not test the x86_64 part, though, for obvious reasons.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc1-mm3.orig/drivers/clocksource/acpi_pm.c linux-2.6.17-rc1-mm3/drivers/clocksource/acpi_pm.c
--- linux-2.6.17-rc1-mm3.orig/drivers/clocksource/acpi_pm.c	2006-04-18 20:06:57.000000000 +0200
+++ linux-2.6.17-rc1-mm3/drivers/clocksource/acpi_pm.c	2006-04-18 20:08:19.000000000 +0200
@@ -30,7 +30,7 @@
  * The location is detected during setup_arch(),
  * in arch/i386/acpi/boot.c
  */
-u32 pmtmr_ioport;
+u32 pmtmr_ioport __read_mostly;
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
@@ -47,7 +47,7 @@
 	/*
 	 * It has been reported that because of various broken
 	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM clock
-	 * source is not latched, so you must read it multiple
+	 * source is not latched, you must read it multiple
 	 * times to ensure a safe value is read:
 	 */
 	do {

diff -urN linux-2.6.17-rc1-mm3.orig/arch/x86_64/kernel/pmtimer.c linux-2.6.17-rc1-mm3/arch/x86_64/kernel/pmtimer.c
--- linux-2.6.17-rc1-mm3.orig/arch/x86_64/kernel/pmtimer.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-mm3/arch/x86_64/kernel/pmtimer.c	2006-04-18 20:36:35.000000000 +0200
@@ -27,7 +27,7 @@
 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
  * in arch/i386/kernel/acpi/boot.c */
-u32 pmtmr_ioport;
+u32 pmtmr_ioport __read_mostly;
 
 /* value of the Power timer at last timer interrupt */
 static u32 offset_delay;
