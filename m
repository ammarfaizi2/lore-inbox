Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUHMFPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUHMFPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUHMFN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:13:58 -0400
Received: from ozlabs.org ([203.10.76.45]:16072 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268997AbUHMFNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:13:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.19925.876052.183316@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 15:12:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (2/4) Use cpu_present_map in ppc64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the "standard" cpu_present_map for describing cpus which are
present in the system, but not necessarily online.  cpu_present_map is
meant to be a superset of cpu_online_map and a subset of
cpu_possible_map.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/prom.c~ppc64-add-cpu_present_map arch/ppc64/kernel/prom.c
--- 2.6-tip/arch/ppc64/kernel/prom.c~ppc64-add-cpu_present_map	2004-08-03 18:07:06.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/prom.c	2004-08-03 18:07:06.000000000 -0500
@@ -943,6 +943,7 @@ static void __init prom_hold_cpus(unsign
 			cpu_set(cpuid, RELOC(cpu_available_map));
 			cpu_set(cpuid, RELOC(cpu_possible_map));
 			cpu_set(cpuid, RELOC(cpu_present_at_boot));
+			cpu_set(cpuid, RELOC(cpu_present_map));
 			if (reg == 0)
 				cpu_set(cpuid, RELOC(cpu_online_map));
 #endif /* CONFIG_SMP */
@@ -1045,6 +1046,7 @@ static void __init prom_hold_cpus(unsign
 				cpu_set(cpuid, RELOC(cpu_available_map));
 				cpu_set(cpuid, RELOC(cpu_possible_map));
 				cpu_set(cpuid, RELOC(cpu_present_at_boot));
+				cpu_set(cpuid, RELOC(cpu_present_map));
 #endif
 			} else {
 				prom_printf("... failed: %x\n", *acknowledge);
@@ -1057,6 +1059,7 @@ static void __init prom_hold_cpus(unsign
 			cpu_set(cpuid, RELOC(cpu_possible_map));
 			cpu_set(cpuid, RELOC(cpu_online_map));
 			cpu_set(cpuid, RELOC(cpu_present_at_boot));
+			cpu_set(cpuid, RELOC(cpu_present_map));
 		}
 #endif
 next:
@@ -1072,6 +1075,7 @@ next:
 			if (_naca->smt_state) {
 				cpu_set(cpuid, RELOC(cpu_available_map));
 				cpu_set(cpuid, RELOC(cpu_present_at_boot));
+				cpu_set(cpuid, RELOC(cpu_present_map));
 				prom_printf("available\n");
 			} else {
 				prom_printf("not available\n");
@@ -1103,6 +1107,7 @@ next:
 			}
 /* 			cpu_set(i+1, cpu_online_map); */
 			cpu_set(i+1, RELOC(cpu_possible_map));
+			cpu_set(i+1, RELOC(cpu_present_map));
 		}
 		_systemcfg->processorCount *= 2;
 	} else {
diff -puN arch/ppc64/kernel/smp.c~ppc64-add-cpu_present_map arch/ppc64/kernel/smp.c
--- 2.6-tip/arch/ppc64/kernel/smp.c~ppc64-add-cpu_present_map	2004-08-03 18:07:06.000000000 -0500
+++ 2.6-tip-nathanl/arch/ppc64/kernel/smp.c	2004-08-03 18:07:06.000000000 -0500
@@ -127,6 +127,7 @@ static int smp_iSeries_numProcs(void)
 			cpu_set(i, cpu_available_map);
 			cpu_set(i, cpu_possible_map);
 			cpu_set(i, cpu_present_at_boot);
+			cpu_set(i, cpu_present_map);
                         ++np;
                 }
         }
