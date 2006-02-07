Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWBGXRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWBGXRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWBGXRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:17:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38404 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030245AbWBGXRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:17:14 -0500
Date: Wed, 8 Feb 2006 00:17:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Keith Owens <kaos@sgi.com>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060207231713.GG3524@stusta.de>
References: <20060207221157.GA3524@stusta.de> <9883.1139351831@ocs3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9883.1139351831@ocs3>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 09:37:11AM +1100, Keith Owens wrote:
> 
> A generic IA64 kernel requires (at least) the ACPI and NUMA options in
> order to run on all the IA64 platforms out there.  Omitting those
> options and relying on the user to set them by hand is going to cause
> more problems.
> 
> If anything, there should be more options being set as a side effect of
> selecting IA64_GENERIC, including ARCH_DISCONTIGMEM_ENABLE,
> ARCH_SPARSEMEM_ENABLE, PCI and even SMP.

IOW, you want the patch below?

Not that I'm a big fan of this approach, but if it should be done this 
way, it should be done right.

cu
Adrian


<--  snip  -->


Let IA64_GENERIC select more stuff (as wanted by the ia64 developers).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig.old	2006-02-07 23:07:29.000000000 +0100
+++ linux-2.6.16-rc1-mm5-ia64/arch/ia64/Kconfig	2006-02-08 00:13:58.000000000 +0100
@@ -73,10 +73,12 @@
 config IA64_GENERIC
 	bool "generic"
 	select ACPI
 	select NUMA
 	select ACPI_NUMA
+	select PCI
+	select SMP
 	help
 	  This selects the system type of your hardware.  A "generic" kernel
 	  will run on any supported IA-64 system.  However, if you configure
 	  a kernel for your specific system, it will be faster and smaller.
 
@@ -132,10 +134,11 @@
 	  This choice is safe for all IA-64 systems, but may not perform
 	  optimally on systems with, say, Itanium 2 or newer processors.
 
 config MCKINLEY
 	bool "Itanium 2"
+	depends on IA64_GENERIC=n
 	help
 	  Select this to configure for an Itanium 2 (McKinley) processor.
 
 endchoice
 
@@ -318,11 +321,11 @@
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
 	  or have huge holes in the physical address space for other reasons.
  	  See <file:Documentation/vm/numa> for more.
 
 config ARCH_FLATMEM_ENABLE
-	def_bool y
+	def_bool y if IA64_GENERIC=n
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 

