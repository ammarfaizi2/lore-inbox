Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbTDDJ5N (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 04:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbTDDJ5N (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 04:57:13 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:35853 "EHLO pazke")
	by vger.kernel.org with ESMTP id S263501AbTDDJ4s (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 04:56:48 -0500
Date: Fri, 4 Apr 2003 14:08:17 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] cleanup mach-visws/mpparse.c
Message-ID: <20030404100817.GD964@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this trivial patch (2.5.66) removes some now unused data
structures from mach-visws/mpparse.c

Please apply.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-cleanup

diff -urN -X /usr/share/dontdiff linux-2.5.66.vanilla/arch/i386/mach-visws/mpparse.c linux-2.5.66/arch/i386/mach-visws/mpparse.c
--- linux-2.5.66.vanilla/arch/i386/mach-visws/mpparse.c	Mon Mar 31 13:37:22 2003
+++ linux-2.5.66/arch/i386/mach-visws/mpparse.c	Sun Mar 16 16:28:01 2003
@@ -4,8 +4,6 @@
 #include <linux/smp.h>
 
 #include <asm/smp.h>
-#include <asm/apic.h>
-#include <asm/mpspec.h>
 #include <asm/io.h>
 
 #include "cobalt.h"
@@ -19,21 +17,6 @@
  * MP-table.
  */
 int apic_version [MAX_APICS];
-int mp_bus_id_to_type [MAX_MP_BUSSES];
-int mp_bus_id_to_node [MAX_MP_BUSSES];
-int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-int mp_current_pci_id;
-
-/* I/O APIC entries */
-struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
-
-/* # of MP IRQ source entries */
-struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
-
-/* MP IRQ source entries */
-int mp_irq_entries;
-
-int nr_ioapics;
 
 int pic_mode;
 unsigned long mp_lapic_addr;
@@ -42,13 +25,9 @@
 unsigned int boot_cpu_physical_apicid = -1U;
 unsigned int boot_cpu_logical_apicid = -1U;
 
-/* Internal processor count */
-static unsigned int num_processors;
-
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
-u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS - 1] = BAD_APICID };
 
 /*
  * The Visual Workstation is Intel MP compliant in the hardware
@@ -76,12 +55,9 @@
 		boot_cpu_logical_apicid = logical_apicid;
 	}
 
-	num_processors++;
-
 	if (m->mpc_apicid > MAX_APICS) {
 		printk(KERN_ERR "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
-		--num_processors;
 		return;
 	}
 	ver = m->mpc_apicver;
@@ -97,7 +73,6 @@
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
-	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 void __init find_smp_config(void)

--KdquIMZPjGJQvRdI--
