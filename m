Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTBNU4L>; Fri, 14 Feb 2003 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTBNUyb>; Fri, 14 Feb 2003 15:54:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267457AbTBNUwd>; Fri, 14 Feb 2003 15:52:33 -0500
Subject: PATCH: fix non SMP acpi build
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:02:23 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmyV-0005eu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/include/asm-i386/mach-default/mach_apic.h linux-2.5.60-ac1/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.60-ref/include/asm-i386/mach-default/mach_apic.h	2003-02-14 21:21:46.000000000 +0000
+++ linux-2.5.60-ac1/include/asm-i386/mach-default/mach_apic.h	2003-02-14 18:12:47.000000000 +0000
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
+#ifdef CONFIG_LOCAL_APIC
+
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #ifdef CONFIG_SMP
@@ -98,4 +100,6 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+#endif
+
 #endif /* __ASM_MACH_APIC_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/arch/i386/kernel/acpi/boot.c linux-2.5.60-ac1/arch/i386/kernel/acpi/boot.c
--- linux-2.5.60-ref/arch/i386/kernel/acpi/boot.c	2003-02-14 21:45:55.000000000 +0000
+++ linux-2.5.60-ac1/arch/i386/kernel/acpi/boot.c	2003-02-14 18:14:04.000000000 +0000
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <asm/pgalloc.h>
+#include <asm/mpspec.h>
 
 #include <mach_apic.h>
 #include <mach_mpparse.h>
