Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSEAVoG>; Wed, 1 May 2002 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314067AbSEAVoF>; Wed, 1 May 2002 17:44:05 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:26273 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S314057AbSEAVoF>; Wed, 1 May 2002 17:44:05 -0400
Message-ID: <3CD060FD.4070903@didntduck.org>
Date: Wed, 01 May 2002 17:41:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix thermal_interrupt
Content-Type: multipart/mixed;
 boundary="------------020600010907000504050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600010907000504050103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The interrupt stub for thermal_interrupt was not being created.

-- 

						Brian Gerst

--------------020600010907000504050103
Content-Type: text/plain;
 name="thermal-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thermal-1"

diff -urN linux-2.5.12/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.12/arch/i386/kernel/entry.S	Mon Apr 29 02:29:49 2002
+++ linux/arch/i386/kernel/entry.S	Wed May  1 14:38:28 2002
@@ -395,6 +395,11 @@
 BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+
+#ifdef CONFIG_X86_MCE_P4THERMAL
+BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
+#endif
+
 #endif
 
 ENTRY(divide_error)
diff -urN linux-2.5.12/arch/i386/kernel/i8259.c linux/arch/i386/kernel/i8259.c
--- linux-2.5.12/arch/i386/kernel/i8259.c	Mon Apr 29 02:29:49 2002
+++ linux/arch/i386/kernel/i8259.c	Wed May  1 14:36:22 2002
@@ -394,7 +394,7 @@
 
 	/* thermal monitor LVT interrupt */
 #ifdef CONFIG_X86_MCE_P4THERMAL
-	set_intr_gate(THERMAL_APIC_VECTOR, smp_thermal_interrupt);
+	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
 #endif
 

--------------020600010907000504050103--

