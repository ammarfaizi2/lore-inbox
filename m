Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVK3BPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVK3BPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVK3BPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:15:41 -0500
Received: from fmr15.intel.com ([192.55.52.69]:55189 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750749AbVK3BPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:15:40 -0500
Subject: [PATCH] setting irq affinity is broken in ia32 with MSI enabled
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       akpm <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 00:37:15 -0800
Message-Id: <1133339835.8212.14.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setting irq affinity stops working when MSI is enabled. With MSI,
move_irq is empty, so we can't change irq affinity. It appears a typo in
Ashok's original commit for this issue. X86_64 actually is using
move_native_irq.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

--- a/arch/i386/kernel/io_apic.c	2005-11-29 22:22:16.000000000 -0800
+++ b/arch/i386/kernel/io_apic.c	2005-11-29 22:23:01.000000000 -0800
@@ -2009,7 +2009,7 @@ static void ack_edge_ioapic_vector(unsig
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	ack_edge_ioapic_irq(irq);
 }
 
@@ -2024,7 +2024,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	end_level_ioapic_irq(irq);
 }
 


