Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUAPTRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUAPTRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:17:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:22420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbUAPTRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:17:19 -0500
Date: Fri, 16 Jan 2004 11:15:01 -0800
From: cliff white <cliffw@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: piggin@cyberone.com.au, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-Id: <20040116111501.70200cf3.cliffw@osdl.org>
In-Reply-To: <20040110005232.GD25089@fs.tum.de>
References: <20040106054859.GA18208@waste.org>
	<3FFA56D6.6040808@cyberone.com.au>
	<20040106064607.GB18208@waste.org>
	<3FFA5ED3.6040000@cyberone.com.au>
	<20040110004625.GB25089@fs.tum.de>
	<20040110005232.GD25089@fs.tum.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004 01:52:32 +0100
Adrian Bunk <bunk@fs.tum.de> wrote:


> Changes:
> 
> - changed the i386 CPU selection from a choice to single options for
>   every cpu
> - X86_GENERIC is no longer required
> - renamed the M* variables to CPU_*, this is needed to ask the users
>   upgrading from older kernels instead of silently changing the
>   semantics
> - X86_GOOD_APIC -> X86_BAD_APIC
> - AMD Elan is a different subarch, you can't configure a kernel that
>   runs on both the AMD Elan and other i386 CPUs
> - added optimizing CFLAGS for the AMD Elan
> - gcc 2.95 supports -march=k6 (no need for check_gcc)
> - help text changes/updates
> 
> TODO:
> - module versioning
> 
> 
> diffstat output:
> 
>  arch/i386/Kconfig                    |  258 ++++++++++++---------------
>  arch/i386/Makefile                   |   57 +++--
>  arch/i386/boot/setup.S               |    2 
>  arch/i386/lib/mmx.c                  |    2 
>  drivers/serial/8250.h                |    2 
>  include/asm-i386/apic.h              |    4 
>  include/asm-i386/bugs.h              |    7 
>  include/asm-i386/module.h            |    2 
>  include/asm-i386/processor.h         |    4 
>  include/asm-i386/timex.h             |    2 
>  arch/x86_64/Kconfig                  |    4 
>  include/asm-x86_64/apic.h            |    2 
>  arch/i386/kernel/cpu/cpufreq/Kconfig |    2 
>  arch/i386/mach-voyager/voyager_smp.c |    6 
>  14 files changed, 172 insertions(+), 182 deletions(-)
> 
> 
>
It would be good to also update arch/i386/defconfig, as the current
breaks our auto-compile, which uses 'make defconfig' This patch sets a
default CPU also.

Patch
-------------------------------
diff -Nur a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig       2004-01-16 11:09:48.703161400 -0800
+++ b/arch/i386/defconfig       2004-01-16 10:57:33.690900248 -0800
@@ -48,26 +48,36 @@
 # CONFIG_X86_VISWS is not set
 # CONFIG_X86_GENERICARCH is not set
 # CONFIG_X86_ES7000 is not set
-# CONFIG_M386 is not set
-# CONFIG_M486 is not set
-# CONFIG_M586 is not set
-# CONFIG_M586TSC is not set
-# CONFIG_M586MMX is not set
-# CONFIG_M686 is not set
-# CONFIG_MPENTIUMII is not set
-# CONFIG_MPENTIUMIII is not set
-CONFIG_MPENTIUM4=y
-# CONFIG_MK6 is not set
-# CONFIG_MK7 is not set
-# CONFIG_MK8 is not set
-# CONFIG_MELAN is not set
-# CONFIG_MCRUSOE is not set
-# CONFIG_MWINCHIPC6 is not set
-# CONFIG_MWINCHIP2 is not set
-# CONFIG_MWINCHIP3D is not set
-# CONFIG_MCYRIXIII is not set
-# CONFIG_MVIAC3_2 is not set
-# CONFIG_X86_GENERIC is not set
+
+#
+
+#
+# Processor support
+#
+
+#
+# Select all processors your kernel should support
+#
+# CONFIG_CPU_386 is not set
+# CONFIG_CPU_486 is not set
+# CONFIG_CPU_586 is not set
+# CONFIG_CPU_586TSC is not set
+# CONFIG_CPU_586MMX is not set
+# CONFIG_CPU_686 is not set
+# CONFIG_CPU_PENTIUMII is not set
+# CONFIG_CPU_PENTIUMIII is not set
+# CONFIG_CPU_PENTIUMM is not set
+CONFIG_CPU_PENTIUM4=y
+# CONFIG_CPU_K6 is not set
+# CONFIG_CPU_K7 is not set
+# CONFIG_CPU_K8 is not set
+# CONFIG_CPU_CRUSOE is not set
+# CONFIG_CPU_WINCHIPC6 is not set
+# CONFIG_CPU_WINCHIP2 is not set
+# CONFIG_CPU_WINCHIP3D is not set
+# CONFIG_CPU_CYRIXIII is not set
+# CONFIG_CPU_VIAC3_2 is not set
+CONFIG_CPU_INTEL=y
 CONFIG_X86_CMPXCHG=y
 CONFIG_X86_XADD=y
 CONFIG_X86_L1_CACHE_SHIFT=7

-----------------------
cliffw
OSDL
