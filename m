Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbSJCAdq>; Wed, 2 Oct 2002 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbSJCAdq>; Wed, 2 Oct 2002 20:33:46 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:52741 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S262706AbSJCAdo>;
	Wed, 2 Oct 2002 20:33:44 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 - fix compilation w/out APIC (uniprocessor)
Date: Wed, 2 Oct 2002 21:39:16 -0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210022139.16328.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ps: ** UNTESTED **

diff -uar linux-2.5.40/arch/i386/kernel/mpparse.c linux-2.5/arch/i386/kernel/mpparse.c
--- linux-2.5.40/arch/i386/kernel/mpparse.c	Tue Oct  1 04:06:28 2002
+++ linux-2.5/arch/i386/kernel/mpparse.c	Wed Oct  2 21:30:02 2002
@@ -26,6 +26,7 @@
 
 #include <asm/smp.h>
 #include <asm/acpi.h>
+#include <asm/apic.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
@@ -787,6 +788,7 @@
 void __init mp_register_lapic_address (
 	u64			address)
 {
+#ifdef CONFIG_X86_LOCAL_APIC
 	mp_lapic_addr = (unsigned long) address;
 
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
@@ -795,6 +797,7 @@
 		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 
 	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
+#endif
 }
 
 
--- linux-2.5.40/include/asm-i386/apic.h	Tue Oct  1 04:07:45 2002
+++ linux-2.5/include/asm-i386/apic.h	Wed Oct  2 21:21:44 2002
@@ -7,8 +7,6 @@
 #include <asm/apicdef.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_X86_LOCAL_APIC
-
 #define APIC_DEBUG 0
 
 #if APIC_DEBUG
@@ -16,6 +14,8 @@
 #else
 #define Dprintk(x...)
 #endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
 
 /*
  * Basic functions accessing APICs.

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


