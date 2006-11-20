Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966322AbWKTSIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966322AbWKTSIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966320AbWKTSH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:39126 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934298AbWKTSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:45 -0500
Message-Id: <20061120180526.757793000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:12 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Kevin Corry <kevcorry@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 18/22] cell: add symbol exports for oprofile
Content-Disposition: inline; filename=cell-pmu-exports.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add symbol-exports for the new routines in arch/powerpc/platforms/cell/pmu.c.
They are needed for Oprofile, which can be built as a module.

Patch is against 2.6.18-arnd5.

Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pmu.c
+++ linux-2.6/arch/powerpc/platforms/cell/pmu.c
@@ -85,6 +85,7 @@ u32 cbe_read_phys_ctr(u32 cpu, u32 phys_
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(cbe_read_phys_ctr);
 
 void cbe_write_phys_ctr(u32 cpu, u32 phys_ctr, u32 val)
 {
@@ -111,6 +112,7 @@ void cbe_write_phys_ctr(u32 cpu, u32 phy
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(cbe_write_phys_ctr);
 
 /*
  * "Logical" counter registers.
@@ -130,6 +132,7 @@ u32 cbe_read_ctr(u32 cpu, u32 ctr)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(cbe_read_ctr);
 
 void cbe_write_ctr(u32 cpu, u32 ctr, u32 val)
 {
@@ -149,6 +152,7 @@ void cbe_write_ctr(u32 cpu, u32 ctr, u32
 
 	cbe_write_phys_ctr(cpu, phys_ctr, val);
 }
+EXPORT_SYMBOL_GPL(cbe_write_ctr);
 
 /*
  * Counter-control registers.
@@ -164,12 +168,14 @@ u32 cbe_read_pm07_control(u32 cpu, u32 c
 
 	return pm07_control;
 }
+EXPORT_SYMBOL_GPL(cbe_read_pm07_control);
 
 void cbe_write_pm07_control(u32 cpu, u32 ctr, u32 val)
 {
 	if (ctr < NR_CTRS)
 		WRITE_WO_MMIO(pm07_control[ctr], val);
 }
+EXPORT_SYMBOL_GPL(cbe_write_pm07_control);
 
 /*
  * Other PMU control registers. Most of these are write-only.
@@ -215,6 +221,7 @@ u32 cbe_read_pm(u32 cpu, enum pm_reg_nam
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(cbe_read_pm);
 
 void cbe_write_pm(u32 cpu, enum pm_reg_name reg, u32 val)
 {
@@ -252,6 +259,7 @@ void cbe_write_pm(u32 cpu, enum pm_reg_n
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(cbe_write_pm);
 
 /*
  * Get/set the size of a physical counter to either 16 or 32 bits.
@@ -268,6 +276,7 @@ u32 cbe_get_ctr_size(u32 cpu, u32 phys_c
 
 	return size;
 }
+EXPORT_SYMBOL_GPL(cbe_get_ctr_size);
 
 void cbe_set_ctr_size(u32 cpu, u32 phys_ctr, u32 ctr_size)
 {
@@ -287,6 +296,7 @@ void cbe_set_ctr_size(u32 cpu, u32 phys_
 		cbe_write_pm(cpu, pm_control, pm_ctrl);
 	}
 }
+EXPORT_SYMBOL_GPL(cbe_set_ctr_size);
 
 /*
  * Enable/disable the entire performance monitoring unit.
@@ -304,6 +314,7 @@ void cbe_enable_pm(u32 cpu)
 	pm_ctrl = cbe_read_pm(cpu, pm_control) | CBE_PM_ENABLE_PERF_MON;
 	cbe_write_pm(cpu, pm_control, pm_ctrl);
 }
+EXPORT_SYMBOL_GPL(cbe_enable_pm);
 
 void cbe_disable_pm(u32 cpu)
 {
@@ -311,6 +322,7 @@ void cbe_disable_pm(u32 cpu)
 	pm_ctrl = cbe_read_pm(cpu, pm_control) & ~CBE_PM_ENABLE_PERF_MON;
 	cbe_write_pm(cpu, pm_control, pm_ctrl);
 }
+EXPORT_SYMBOL_GPL(cbe_disable_pm);
 
 /*
  * Reading from the trace_buffer.
@@ -325,4 +337,5 @@ void cbe_read_trace_buffer(u32 cpu, u64 
 	*buf++ = in_be64(&pmd_regs->trace_buffer_0_63);
 	*buf++ = in_be64(&pmd_regs->trace_buffer_64_127);
 }
+EXPORT_SYMBOL_GPL(cbe_read_trace_buffer);
 

--

