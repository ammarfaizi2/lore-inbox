Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbUJ1ARY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUJ1ARY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUJ1ANS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:13:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:55511 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262691AbUJ1AKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:10:41 -0400
Date: Thu, 28 Oct 2004 02:10:01 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
Message-ID: <20041028001001.GF23595@wotan.suse.de>
References: <20041026142826.A24417@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026142826.A24417@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 02:28:26PM -0700, Venkatesh Pallipadi wrote:
> 
> Add links for p4-clockmod driver in x86-64 cpufreq. 

I added it with a clarified description and made it dependent on 
CONFIG_EMBEDDED to prevent mistakes (perhaps that should be done on i386 too?) 

Thanks.

-Andi


Here's the patch for your reference:



Add links for p4-clockmod driver in x86-64 cpufreq. 

AK: Made it dependent on EMBEDDED because the driver is only
useful in some special situations and should be normally not used.

Signed-off-by: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de> 
 
Index: linux/arch/x86_64/kernel/cpufreq/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/cpufreq/Makefile	2004-10-19 01:55:08.%N +0200
+++ linux/arch/x86_64/kernel/cpufreq/Makefile	2004-10-28 02:02:00.%N +0200
@@ -7,7 +7,11 @@
 obj-$(CONFIG_X86_POWERNOW_K8) += powernow-k8.o
 obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO) += speedstep-centrino.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ) += acpi.o
+obj-$(CONFIG_X86_P4_CLOCKMOD) += p4-clockmod.o
+obj-$(CONFIG_X86_SPEEDSTEP_LIB) += speedstep-lib.o
 
 powernow-k8-objs := ${SRCDIR}/powernow-k8.o
 speedstep-centrino-objs := ${SRCDIR}/speedstep-centrino.o
 acpi-objs := ${SRCDIR}/acpi.o
+p4-clockmod-objs := ${SRCDIR}/p4-clockmod.o
+speedstep-lib-objs := ${SRCDIR}/speedstep-lib.o
Index: linux/arch/x86_64/kernel/cpufreq/Kconfig
===================================================================
--- linux.orig/arch/x86_64/kernel/cpufreq/Kconfig	2004-10-25 04:47:15.%N +0200
+++ linux/arch/x86_64/kernel/cpufreq/Kconfig	2004-10-28 02:09:04.%N +0200
@@ -88,5 +88,29 @@
 
 	  If in doubt, say N.
 
+config X86_P4_CLOCKMOD
+	tristate "Intel Pentium 4 clock modulation"
+	depends on CPU_FREQ_TABLE && EMBEDDED
+	help
+	  This adds the clock modulation driver for Intel Pentium 4 / XEON
+	  processors.  When enabled it will lower CPU temperature by skipping 
+	  clocks. 
+	  
+	  This driver should be only used in exceptional
+	  circumstances when very low power is needed because it causes severe 
+	  slowdowns and noticeable latencies.  Normally Speedstep should be used 
+	  instead.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  Unless you are absolutely sure say N.
+
+
+config X86_SPEEDSTEP_LIB
+        tristate
+        depends on (X86_P4_CLOCKMOD)
+        default (X86_P4_CLOCKMOD)
+
+
 endmenu
 
