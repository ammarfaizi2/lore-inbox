Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTBTWH4>; Thu, 20 Feb 2003 17:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTBTWH4>; Thu, 20 Feb 2003 17:07:56 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:46587 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267120AbTBTWHx>; Thu, 20 Feb 2003 17:07:53 -0500
Message-ID: <3E55539D.6080607@us.ibm.com>
Date: Thu, 20 Feb 2003 14:15:57 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] make io_apic.c use named initializers
Content-Type: multipart/mixed;
 boundary="------------070701090107020003050808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070701090107020003050808
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bill Irwin was talking about hw_interrupt_type.set_affinity and kirq.
When I went looking, I failed to find this initialization.

Here are some nice, easy-to-find, named initializers.
-- 
Dave Hansen
haveblue@us.ibm.com


--------------070701090107020003050808
Content-Type: text/plain;
 name="i_am_not_art_haas-io_apic-2.5.62-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i_am_not_art_haas-io_apic-2.5.62-0.patch"

--- ./arch/i386/kernel/io_apic.c.orig	Thu Feb 20 11:38:34 2003
+++ ./arch/i386/kernel/io_apic.c	Thu Feb 20 11:52:42 2003
@@ -1745,25 +1745,25 @@
  */
 
 static struct hw_interrupt_type ioapic_edge_irq_type = {
-	"IO-APIC-edge",
-	startup_edge_ioapic_irq,
-	shutdown_edge_ioapic_irq,
-	enable_edge_ioapic_irq,
-	disable_edge_ioapic_irq,
-	ack_edge_ioapic_irq,
-	end_edge_ioapic_irq,
-	set_ioapic_affinity,
+	.typename 	= "IO-APIC-edge",
+	.startup 	= startup_edge_ioapic_irq,
+	.shutdown 	= shutdown_edge_ioapic_irq,
+	.enable 	= enable_edge_ioapic_irq,
+	.disable 	= disable_edge_ioapic_irq,
+	.ack 		= ack_edge_ioapic_irq,
+	.end 		= end_edge_ioapic_irq,
+	.set_affinity 	= set_ioapic_affinity,
 };
 
 static struct hw_interrupt_type ioapic_level_irq_type = {
-	"IO-APIC-level",
-	startup_level_ioapic_irq,
-	shutdown_level_ioapic_irq,
-	enable_level_ioapic_irq,
-	disable_level_ioapic_irq,
-	mask_and_ack_level_ioapic_irq,
-	end_level_ioapic_irq,
-	set_ioapic_affinity,
+	.typename 	= "IO-APIC-level",
+	.startup 	= startup_level_ioapic_irq,
+	.shutdown 	= shutdown_level_ioapic_irq,
+	.enable 	= enable_level_ioapic_irq,
+	.disable 	= disable_level_ioapic_irq,
+	.ack 		= mask_and_ack_level_ioapic_irq,
+	.end 		= end_level_ioapic_irq,
+	.set_affinity 	= set_ioapic_affinity,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -1821,13 +1821,13 @@
 static void end_lapic_irq (unsigned int i) { /* nothing */ }
 
 static struct hw_interrupt_type lapic_irq_type = {
-	"local-APIC-edge",
-	NULL, /* startup_irq() not used for IRQ0 */
-	NULL, /* shutdown_irq() not used for IRQ0 */
-	enable_lapic_irq,
-	disable_lapic_irq,
-	ack_lapic_irq,
-	end_lapic_irq
+	.typename 	= "local-APIC-edge",
+	.startup 	= NULL, /* startup_irq() not used for IRQ0 */
+	.shutdown 	= NULL, /* shutdown_irq() not used for IRQ0 */
+	.enable 	= enable_lapic_irq,
+	.disable 	= disable_lapic_irq,
+	.ack 		= ack_lapic_irq,
+	.end 		= end_lapic_irq
 };
 
 void enable_NMI_through_LVT0 (void * dummy)

--------------070701090107020003050808--

