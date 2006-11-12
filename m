Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933033AbWKLRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbWKLRsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933034AbWKLRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:48:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15114 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933033AbWKLRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:48:21 -0500
Date: Sun, 12 Nov 2006 18:48:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/io_apic.c: handle a negative return value
Message-ID: <20061112174826.GC3382@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that bad things might happen if 
find_isa_irq_apic() returned -1.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/arch/i386/kernel/io_apic.c.old	2006-11-12 18:41:24.000000000 +0100
+++ linux-2.6/arch/i386/kernel/io_apic.c	2006-11-12 18:42:00.000000000 +0100
@@ -2160,7 +2160,8 @@ static inline void unlock_ExtINT_logic(v
 
 	pin  = find_isa_irq_pin(8, mp_INT);
 	apic = find_isa_irq_apic(8, mp_INT);
-	if (pin == -1)
+
+	if ((pin == -1) || (apic == -1))
 		return;
 
 	entry0 = ioapic_read_entry(apic, pin);

