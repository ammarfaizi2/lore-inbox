Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVBKS7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVBKS7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBKS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:56:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33042 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262288AbVBKSyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:54:32 -0500
Date: Fri, 11 Feb 2005 19:54:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, ak@suse.de, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64: mpparse.c: make some code static
Message-ID: <20050211185429.GF3736@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Jan 2005

 arch/i386/kernel/mpparse.c   |    4 ++--
 arch/x86_64/kernel/mpparse.c |    4 ++--
 include/asm-i386/mpspec.h    |    1 -
 include/asm-x86_64/mpspec.h  |    1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/mpspec.h.old	2005-01-16 04:40:50.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/mpspec.h	2005-01-16 04:40:59.000000000 +0100
@@ -22,7 +22,6 @@
 extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
 extern int mpc_default_type;
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
-extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
 extern int using_apic_timer;
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mpspec.h.old	2005-01-16 04:41:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mpspec.h	2005-01-16 04:41:11.000000000 +0100
@@ -176,7 +176,6 @@
 extern int mp_irq_entries;
 extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
 extern int mpc_default_type;
-extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
 
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/mpparse.c.old	2005-01-16 04:41:18.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/mpparse.c	2005-01-16 04:42:20.000000000 +0100
@@ -49,7 +49,7 @@
 int mp_bus_id_to_local [MAX_MP_BUSSES];
 int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
-int mp_current_pci_id;
+static int mp_current_pci_id;
 
 /* I/O APIC entries */
 struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
@@ -863,7 +863,7 @@
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
 
-struct mp_ioapic_routing {
+static struct mp_ioapic_routing {
 	int			apic_id;
 	int			gsi_base;
 	int			gsi_end;
--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/mpparse.c.old	2005-01-16 04:41:36.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/mpparse.c	2005-01-16 04:42:24.000000000 +0100
@@ -46,7 +46,7 @@
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 cpumask_t pci_bus_to_cpumask [256] = { [0 ... 255] = CPU_MASK_ALL };
 
-int mp_current_pci_id = 0;
+static int mp_current_pci_id = 0;
 /* I/O APIC entries */
 struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
 
@@ -708,7 +708,7 @@
 #define MP_ISA_BUS		0
 #define MP_MAX_IOAPIC_PIN	127
 
-struct mp_ioapic_routing {
+static struct mp_ioapic_routing {
 	int			apic_id;
 	int			gsi_start;
 	int			gsi_end;

