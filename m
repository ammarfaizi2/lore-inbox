Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWDGVFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWDGVFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWDGVFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:05:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2576 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964902AbWDGVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:05:24 -0400
Date: Fri, 7 Apr 2006 23:05:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: move SMP option above subarch selection
Message-ID: <20060407210521.GM7118@stusta.de>
References: <20060324165613.GF22727@stusta.de> <Pine.LNX.4.64.0603241928480.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603241928480.17704@scrub.home>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 07:30:17PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Fri, 24 Mar 2006, Adrian Bunk wrote:
> 
> > The SMP question comes after the subarch question, and it does therefore 
> > make sense to let the SMP-only subarchs select SMP instead of depending 
> > on it.
> 
> No, it doesn't make sense. If the ordering is wrong, fix the ordering, but 
> that's a silly reason to use select.

Patch below.

> bye, Roman

cu
Adrian


<--  snip  -->


Since several subarchs depend on SMP, the SMP option should be above the 
subarch selection.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/Kconfig |   58 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

--- linux-2.6.17-rc1-mm1-full/arch/i386/Kconfig.old	2006-04-07 17:04:26.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/arch/i386/Kconfig	2006-04-07 17:05:29.000000000 +0200
@@ -57,6 +57,35 @@
 
 menu "Processor type and features"
 
+config SMP
+	bool "Symmetric multi-processing support"
+	---help---
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, like most personal computers, say N. If
+	  you have a system with more than one CPU, say Y.
+
+	  If you say N here, the kernel will run on single and multiprocessor
+	  machines, but will use only one CPU of a multiprocessor machine. If
+	  you say Y here, the kernel will run on many, but not all,
+	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  will run faster if you say N here.
+
+	  Note that if you say Y here and choose architecture "586" or
+	  "Pentium" under "Processor family", the kernel will not work on 486
+	  architectures. Similarly, multiprocessor kernels for the "PPro"
+	  architecture may not work on all Pentium based boards.
+
+	  People using multiprocessor machines who say Y here should also say
+	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
+	  Management" code will be disabled if you say Y here.
+
+	  See also the <file:Documentation/smp.txt>,
+	  <file:Documentation/i386/IO-APIC.txt>,
+	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  If you don't know what to do here, say N.
+
 choice
 	prompt "Subarchitecture Type"
 	default X86_PC
@@ -188,35 +217,6 @@
 	depends on HPET_TIMER && RTC=y
 	default y
 
-config SMP
-	bool "Symmetric multi-processing support"
-	---help---
-	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
-
-	  If you say N here, the kernel will run on single and multiprocessor
-	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
-	  will run faster if you say N here.
-
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
-	  People using multiprocessor machines who say Y here should also say
-	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-	  Management" code will be disabled if you say Y here.
-
-	  See also the <file:Documentation/smp.txt>,
-	  <file:Documentation/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  If you don't know what to do here, say N.
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-255)"
 	range 2 255

