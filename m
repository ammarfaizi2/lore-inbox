Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbTCGHVX>; Fri, 7 Mar 2003 02:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTCGHVX>; Fri, 7 Mar 2003 02:21:23 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:32906
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261402AbTCGHVU>; Fri, 7 Mar 2003 02:21:20 -0500
Date: Fri, 7 Mar 2003 02:29:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Martin Bligh <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFT] noirqbalance still doesn't do anything
Message-ID: <Pine.LNX.4.50.0303070224190.18716-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get a response to my other patch to do this so i'm guessing that 
people want a simpler patch(??) This one simply sets TARGET_CPUS to 
cpu_callout_map instead of cpu_online_map so that when we finally do boot 
we actually use the other cpus for servicing interrupts.

Only tested on 2way AMD/SMP booted with noirqbalance, interrupts get 
distributed via apic bus arbitration.

	Zwane

Index: linux-2.5.62-numaq//include/asm-i386/mach-bigsmp/mach_apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/mach-bigsmp/mach_apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mach_apic.h
--- linux-2.5.62-numaq//include/asm-i386/mach-bigsmp/mach_apic.h	18 Feb 2003 00:16:00 -0000	1.1.1.1
+++ linux-2.5.62-numaq//include/asm-i386/mach-bigsmp/mach_apic.h	7 Mar 2003 05:34:49 -0000
@@ -19,7 +19,7 @@
 }
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
-#define TARGET_CPUS	((cpu_online_map < 0xf)?cpu_online_map:0xf)
+#define TARGET_CPUS	((cpu_callout_map < 0xf)?cpu_callout_map:0xf)
 
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
Index: linux-2.5.62-numaq//include/asm-i386/mach-default/mach_apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/mach-default/mach_apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mach_apic.h
--- linux-2.5.62-numaq//include/asm-i386/mach-default/mach_apic.h	18 Feb 2003 00:15:59 -0000	1.1.1.1
+++ linux-2.5.62-numaq//include/asm-i386/mach-default/mach_apic.h	7 Mar 2003 05:33:20 -0000
@@ -4,7 +4,7 @@
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #ifdef CONFIG_SMP
- #define TARGET_CPUS (cpu_online_map)
+ #define TARGET_CPUS (cpu_callout_map)
 #else
  #define TARGET_CPUS 0x01
 #endif
Index: linux-2.5.62-numaq//include/asm-i386/mach-summit/mach_apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/mach-summit/mach_apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mach_apic.h
--- linux-2.5.62-numaq//include/asm-i386/mach-summit/mach_apic.h	18 Feb 2003 00:15:59 -0000	1.1.1.1
+++ linux-2.5.62-numaq//include/asm-i386/mach-summit/mach_apic.h	7 Mar 2003 05:36:40 -0000
@@ -13,7 +13,7 @@
 		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
 
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
-#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_callout_map)
 
 #define INT_DELIVERY_MODE (x86_summit ? dest_Fixed : dest_LowestPrio)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */

-- 
function.linuxpower.ca
