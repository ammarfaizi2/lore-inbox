Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272580AbTHKNjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:39:12 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28633
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272580AbTHKNjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:03 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Kill nonexistent symbols in defconfig.
Date: Mon, 11 Aug 2003 02:02:51 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110202.55444.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make menuconfig against 2.6.0-test2-cset-20030808_1816 with no .config
and no /boot/defconfig produces the following complaints:

> #
> # using defaults found in arch/i386/defconfig
> #
> arch/i386/defconfig:22: trying to assign nonexistent symbol IKCONFIG
> arch/i386/defconfig:23: trying to assign nonexistent symbol IKCONFIG_PROC
> arch/i386/defconfig:70: trying to assign nonexistent symbol X86_SSE2
> arch/i386/defconfig:183: trying to assign nonexistent symbol PNP_NAMES
> arch/i386/defconfig:184: trying to assign nonexistent symbol PNP_CARD
> arch/i386/defconfig:324: trying to assign nonexistent symbol SCSI_EATA_DMA
> arch/i386/defconfig:336: trying to assign nonexistent symbol SCSI_NCR53C7xx
> arch/i386/defconfig:338: trying to assign nonexistent symbol SCSI_NCR53C8XX
> arch/i386/defconfig:361: trying to assign nonexistent symbol SCSI_PCMCIA
> arch/i386/defconfig:395: trying to assign nonexistent symbol FILTER
> arch/i386/defconfig:544: trying to assign nonexistent symbol NET_PCMCIA_RADIO
> arch/i386/defconfig:663: trying to assign nonexistent symbol INTEL_RNG
> arch/i386/defconfig:664: trying to assign nonexistent symbol AMD_RNG
> arch/i386/defconfig:678: trying to assign nonexistent symbol AGP3

So here's a patch to rip all those symbols out of defconfig.  (If this is
bad, I'd be happy to hear about why...)

Rob

--- linux-2.6.0-test2/arch/i386/defconfig	2003-08-10 22:47:33.000000000 -0400
+++ new/arch/i386/defconfig	2003-08-11 01:55:42.000000000 -0400
@@ -19,8 +19,6 @@
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
-CONFIG_IKCONFIG=n
-CONFIG_IKCONFIG_PROC=n
 
 #
 # Loadable module support
@@ -67,7 +65,6 @@
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
-CONFIG_X86_SSE2=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_SMP=y
 # CONFIG_PREEMPT is not set
@@ -180,8 +177,6 @@
 # Plug and Play support
 #
 CONFIG_PNP=y
-CONFIG_PNP_NAMES=y
-# CONFIG_PNP_CARD is not set
 # CONFIG_PNP_DEBUG is not set
 
 #
@@ -321,7 +316,6 @@
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_DTC3280 is not set
 # CONFIG_SCSI_EATA is not set
-# CONFIG_SCSI_EATA_DMA is not set
 # CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_GDTH is not set
@@ -333,9 +327,7 @@
 # CONFIG_SCSI_PPA is not set
 # CONFIG_SCSI_IMM is not set
 # CONFIG_SCSI_NCR53C406A is not set
-# CONFIG_SCSI_NCR53C7xx is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_NCR53C8XX is not set
 # CONFIG_SCSI_SYM53C8XX is not set
 # CONFIG_SCSI_PAS16 is not set
 # CONFIG_SCSI_PCI2000 is not set
@@ -356,11 +348,6 @@
 # CONFIG_SCSI_DEBUG is not set
 
 #
-# PCMCIA SCSI adapter support
-#
-# CONFIG_SCSI_PCMCIA is not set
-
-#
 # Old CD-ROM drivers (not SCSI, not IDE)
 #
 # CONFIG_CD_NO_IDESCSI is not set
@@ -392,7 +379,6 @@
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
 # CONFIG_NETFILTER is not set
-# CONFIG_FILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -541,7 +527,6 @@
 # CONFIG_PCMCIA_SMC91C92 is not set
 # CONFIG_PCMCIA_XIRC2PS is not set
 # CONFIG_PCMCIA_AXNET is not set
-CONFIG_NET_PCMCIA_RADIO=y
 CONFIG_PCMCIA_RAYCS=y
 
 #
@@ -660,8 +645,6 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_INTEL_RNG=y
-# CONFIG_AMD_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
@@ -675,7 +658,6 @@
 #
 # CONFIG_FTAPE is not set
 CONFIG_AGP=y
-# CONFIG_AGP3 is not set
 CONFIG_AGP_INTEL=y
 CONFIG_AGP_VIA=y
 CONFIG_AGP_AMD=y


