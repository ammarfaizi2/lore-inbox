Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVAOVnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVAOVnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAOVnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:43:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262335AbVAOVkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:40:17 -0500
Date: Sat, 15 Jan 2005 22:40:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 io_apic.c: misc cleanups (fwd)
Message-ID: <20050115214012.GY4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 1 Dec 2004 22:45:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 io_apic.c: misc cleanups

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

