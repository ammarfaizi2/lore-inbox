Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbULAVq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbULAVq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbULAVq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:46:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46610 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261465AbULAVpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:45:55 -0500
Date: Wed, 1 Dec 2004 22:45:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 io_apic.c: misc cleanups
Message-ID: <20041201214552.GU2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make some needlessly global code static
- #if 0 some global print* functions that have no user


diffstat output:
 arch/i386/kernel/io_apic.c   |   14 +++++++++-----
 arch/x86_64/kernel/io_apic.c |   14 +++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/io_apic.c.old	2004-12-01 07:58:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/io_apic.c	2004-12-01 08:05:04.000000000 +0100
@@ -187,7 +187,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
+static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -685,8 +685,8 @@
  */
 
 #define MAX_PIRQS 8
-int pirq_entries [MAX_PIRQS];
-int pirqs_enabled;
+static int pirq_entries [MAX_PIRQS];
+static int pirqs_enabled;
 int skip_ioapic_setup;
 
 static int __init ioapic_setup(char *str)
@@ -1179,7 +1179,7 @@
 	}
 }
 
-void __init setup_IO_APIC_irqs(void)
+static void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
 	int apic, pin, idx, irq, first_notcon = 1, vector;
@@ -1258,7 +1258,7 @@
 /*
  * Set up the 8259A-master output pin:
  */
-void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
+static void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -1452,6 +1452,8 @@
 	return;
 }
 
+#if 0
+
 static void print_APIC_bitfield (int base)
 {
 	unsigned int v;
@@ -1594,6 +1596,8 @@
 	printk(KERN_DEBUG "... PIC ELCR: %04x\n", v);
 }
 
+#endif  /*  0  */
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/io_apic.c.old	2004-12-01 07:58:32.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/io_apic.c	2004-12-01 08:05:15.000000000 +0100
@@ -147,7 +147,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
+static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -185,8 +185,8 @@
  */
 
 #define MAX_PIRQS 8
-int pirq_entries [MAX_PIRQS];
-int pirqs_enabled;
+static int pirq_entries [MAX_PIRQS];
+static int pirqs_enabled;
 int skip_ioapic_setup;
 int ioapic_force;
 
@@ -707,7 +707,7 @@
 	}
 }
 
-void __init setup_IO_APIC_irqs(void)
+static void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
 	int apic, pin, idx, irq, first_notcon = 1, vector;
@@ -776,7 +776,7 @@
  * Set up the 8259A-master output pin as broadcast to all
  * CPUs.
  */
-void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
+static void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -948,6 +948,8 @@
 	return;
 }
 
+#if 0
+
 static __apicdebuginit void print_APIC_bitfield (int base)
 {
 	unsigned int v;
@@ -1090,6 +1092,8 @@
 	printk(KERN_DEBUG "... PIC ELCR: %04x\n", v);
 }
 
+#endif  /*  0  */
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;

