Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263486AbVBDKDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbVBDKDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbVBDKCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:02:37 -0500
Received: from ozlabs.org ([203.10.76.45]:7050 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261490AbVBDKCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:02:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.18474.882725.183584@cargo.ozlabs.ibm.com>
Date: Fri, 4 Feb 2005 21:02:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 show -1 for physical_id of non-present cpus
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <nathanl@austin.ibm.com>.

Make the physical_id cpu sysfs attribute on ppc64 show -1 instead of
65535 for non-present cpus.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/sysfs.c~make-cpu-physical_id-signed arch/ppc64/kernel/sysfs.c
--- linux-2.6.11-rc2-mm1/arch/ppc64/kernel/sysfs.c~make-cpu-physical_id-signed	2005-01-27 15:03:16.000000000 -0600
+++ linux-2.6.11-rc2-mm1-nathanl/arch/ppc64/kernel/sysfs.c	2005-01-27 15:05:12.000000000 -0600
@@ -387,7 +387,7 @@ static ssize_t show_physical_id(struct s
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
-	return sprintf(buf, "%u\n", get_hard_smp_processor_id(cpu->sysdev.id));
+	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->sysdev.id));
 }
 static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
 
diff -puN include/asm-ppc64/paca.h~make-cpu-physical_id-signed include/asm-ppc64/paca.h
--- linux-2.6.11-rc2-mm1/include/asm-ppc64/paca.h~make-cpu-physical_id-signed	2005-01-27 15:04:14.000000000 -0600
+++ linux-2.6.11-rc2-mm1-nathanl/include/asm-ppc64/paca.h	2005-01-27 15:04:51.000000000 -0600
@@ -68,7 +68,7 @@ struct paca_struct {
 	u64 stab_real;			/* Absolute address of segment table */
 	u64 stab_addr;			/* Virtual address of segment table */
 	void *emergency_sp;		/* pointer to emergency stack */
-	u16 hw_cpu_id;			/* Physical processor number */
+	s16 hw_cpu_id;			/* Physical processor number */
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
 
