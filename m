Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265617AbSJRSy4>; Fri, 18 Oct 2002 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbSJRSvX>; Fri, 18 Oct 2002 14:51:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:22155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265350AbSJRSnx>;
	Fri, 18 Oct 2002 14:43:53 -0400
Date: Fri, 18 Oct 2002 11:47:40 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.43 IO APIC bit fields
Message-ID: <Pine.LNX.4.33L2.0210181143280.12841-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch recognizes & logs 2 more IO APIC bit fields and
reduces UNEXPECTED IO-APIC traffic.

Has also been acked by Maciej W. Rozycki (macro).

Please apply to 2.5.43.

Thanks,
-- 
~Randy



--- ./arch/i386/kernel/io_apic.c.2543	Tue Oct 15 20:27:50 2002
+++ ./arch/i386/kernel/io_apic.c	Thu Oct 17 17:43:17 2002
@@ -856,7 +856,9 @@
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
 	printk(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
 	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
-	if (reg_00.__reserved_1 || reg_00.__reserved_2)
+	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
+	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
+	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
 		UNEXPECTED_IO_APIC();

 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
--- ./include/asm-i386/io_apic.h.2543	Tue Oct 15 20:28:28 2002
+++ ./include/asm-i386/io_apic.h	Thu Oct 17 17:41:38 2002
@@ -22,9 +22,12 @@
  * The structure of the IO-APIC:
  */
 struct IO_APIC_reg_00 {
-	__u32	__reserved_2	: 24,
+	__u32	__reserved_2	: 14,
+		LTS		:  1,
+		delivery_type	:  1,
+		__reserved_1	:  8,
 		ID		:  4,
-		__reserved_1	:  4;
+		__reserved_0	:  4;
 } __attribute__ ((packed));

 struct IO_APIC_reg_01 {


~~

