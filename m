Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVBXLS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVBXLS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVBXLSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:18:55 -0500
Received: from koto.vergenet.net ([210.128.90.7]:32406 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262229AbVBXLRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:17:18 -0500
Date: Thu, 24 Feb 2005 20:16:20 +0900
From: Horms <horms@debian.org>
To: Edward Miller <bugzilla@emiller.f2s.com>, 296639@bugs.debian.org
Cc: zwane@montezuma.fsmlabs.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug#296639: kernel-source-2.4.27: nforce[23] backport of acpi_skip_timer_override
Message-ID: <20050224111617.GD7093@verge.net.au>
References: <E1D41RP-0001UN-I6@hawea.lakes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502201157330.26742@montezuma.fsmlabs.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 06:40:55PM +0000, Edward Miller wrote:
> Package: kernel-source-2.4.27
> Version: 2.4.27-8
> Severity: normal
> Tags: patch
> 
> The 2.6 kernel series has, since 2.6.5, had a fix for an erroneous timer
> override present in many BIOSes in nforce[23] chipsets. The 2.4 series
> is missing this, resulting in an XT_PIC timer on systems that have an
> APIC-enabled kernel. This is believed to cause system instability,
> including hard lock-ups (with no ssh). At my request, Zwane Mwaikambo
> has kindly backported the fix for 2.4.30 and Ihave found that this patch
> works almost unaltered on Debian's kernel-source-2.4.27. Bearing in mind
> the proximity of Sarge's release and especially d-i rc3, I thought I
> should send you the patch for review now.
> 
> Maybe this will have to be a post-Sarge item but there is a lot of
> cheap nforce2 out there and 2.6.8 may not be suitable for everyone so I
> hope you can consider this patch for inclusion in Sarge's 2.4.27.

Thanks, looks good, though I think the Makefile portion of the patch
should be as follows. I am in the process of some rebuilds to confirm
this. I have CCed the Zwane Mwakikamo and LKML so this reaches the right
eyes.

-- 
Horms

diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-02-24 20:01:29.000000000 +0900
+++ b/arch/i386/kernel/Makefile.noedit	2005-02-24 20:03:40.000000000 +0900
@@ -36,7 +36,7 @@
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_APM)		+= apm.o
-obj-$(CONFIG_ACPI_BOOT)		+= acpi.o earlyquirk.o
+obj-$(CONFIG_ACPI_BOOT)		+= acpi.o
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 
