Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUC3Vu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUC3Vu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:50:26 -0500
Received: from fmr10.intel.com ([192.55.52.30]:64479 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261361AbUC3VuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:50:14 -0500
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <200403302225.33966.arekm@pld-linux.org>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <200403302030.26476.arekm@pld-linux.org> <1080677134.980.166.camel@dhcppc4>
	 <200403302225.33966.arekm@pld-linux.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080683344.3337.178.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2004 16:49:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, simplicity wins;-)

Build for 80386 -- get a build-time warning -- that should do.

thanks,
-Len

ps. earliest ACPI implementation is said to in the late Pentium (1) era.


===== arch/i386/kernel/acpi/boot.c 1.56 vs edited =====
--- 1.56/arch/i386/kernel/acpi/boot.c	Fri Mar 26 17:50:48 2004
+++ edited/arch/i386/kernel/acpi/boot.c	Tue Mar 30 16:23:39 2004
@@ -67,6 +67,10 @@
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+#ifndef __HAVE_ARCH_CMPXCHG
+#warning ACPI uses CMPXCHG, i486 and later hardware
+#endif
+
 /*
--------------------------------------------------------------------------
                               Boot-time Configuration
   
-------------------------------------------------------------------------- */
===== include/asm-i386/system.h 1.30 vs edited =====
--- 1.30/include/asm-i386/system.h	Fri Nov 21 01:24:00 2003
+++ edited/include/asm-i386/system.h	Tue Mar 30 16:05:30 2004
@@ -241,6 +241,7 @@
 
 #ifdef CONFIG_X86_CMPXCHG
 #define __HAVE_ARCH_CMPXCHG 1
+#endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long
old,
 				      unsigned long new, int size)
@@ -273,10 +274,6 @@
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
     
-#else
-/* Compiling for a 386 proper.	Is it worth implementing via cli/sti? 
*/
-#endif
-
 #ifdef __KERNEL__
 struct alt_instr { 
 	__u8 *instr; 		/* original instruction */



