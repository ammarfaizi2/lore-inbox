Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKNN1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKNN1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUKNN1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:27:11 -0500
Received: from mailfe10.tele2.se ([212.247.155.33]:34980 "EHLO
	mailfe10.swip.net") by vger.kernel.org with ESMTP id S261300AbUKNN1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:27:00 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: [PATCH] x86_64: assign_irq_vector should not be marked __init
From: Alexander Nyberg <alexn@dsv.su.se>
To: torvalds@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 14 Nov 2004 14:26:50 +0100
Message-Id: <1100438810.717.12.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hej Linus

This box crashed at startup today and I noticed that some modules will 
need to have assign_irq_vector() available although it is marked as __init. 
Looks like it was done for i386 in but not x86_64...


Signed off by: Alexander Nyberg <alexn@dsv.su.se>

===== arch/x86_64/kernel/io_apic.c 1.38 vs edited =====
--- 1.38/arch/x86_64/kernel/io_apic.c	2004-10-28 09:39:50 +02:00
+++ edited/arch/x86_64/kernel/io_apic.c	2004-11-14 14:03:50 +01:00
@@ -654,11 +654,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
-#else
-int __init assign_irq_vector(int irq)
-#endif
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 


