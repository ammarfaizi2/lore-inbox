Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUBDU3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbUBDU3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:29:18 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:12751 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S266566AbUBDU0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:26:37 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200402042026.i14KQZi7020354@fsgi900.americas.sgi.com>
Subject: [PATCH 2.6] small Altix mod [1/2]
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Feb 2004 14:26:34 -0600 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small mod to the Altix code.

-- Pat



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1519  -> 1.1520 
#	arch/ia64/sn/io/sn2/ml_SN_intr.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/16	pfg@attica.americas.sgi.com	1.1520
# arch/ia64/sn/io/sn2/ml_SN_intr.c
#     Use the pda to keep the num of interrupts
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/sn2/ml_SN_intr.c b/arch/ia64/sn/io/sn2/ml_SN_intr.c
--- a/arch/ia64/sn/io/sn2/ml_SN_intr.c	Fri Jan 16 16:13:35 2004
+++ b/arch/ia64/sn/io/sn2/ml_SN_intr.c	Fri Jan 16 16:13:35 2004
@@ -30,6 +30,7 @@
 #include <asm/sal.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/sn2/shub_mmr.h>
+#include <asm/sn/pda.h>
 
 extern irqpda_t	*irqpdaindr;
 extern cnodeid_t master_node_get(vertex_hdl_t vhdl);
@@ -216,7 +217,6 @@
 {
 	cpuid_t		cpu, best_cpu = CPU_NONE;
 	int		slice, min_count = 1000;
-	irqpda_t	*irqs;
 
 	for (slice = CPUS_PER_NODE - 1; slice >= 0; slice--) {
 		int intrs;
@@ -227,8 +227,7 @@
 		if (!cpu_online(cpu))
 			continue;
 
-		irqs = irqpdaindr;
-		intrs = irqs->num_irq_used;
+		intrs = pdacpu(cpu)->sn_num_irqs;
 
 		if (min_count > intrs) {
 			min_count = intrs;
@@ -243,6 +242,7 @@
 			}
 		}
 	}
+	pdacpu(best_cpu)->sn_num_irqs++;
 	return best_cpu;
 }
