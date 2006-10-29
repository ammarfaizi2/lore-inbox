Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWJ2VE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWJ2VE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWJ2VE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:04:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:13490 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030254AbWJ2VE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:04:26 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 29 Oct 2006 22:04:17 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in create_irq
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning
arch/i386/kernel/io_apic.c: In function `create_irq':
arch/i386/kernel/io_apic.c:2420: warning: 'vector' might be used uninitialized in this function

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Only compile-tested.
arch/x86_64/kernel/io_apic.c seems to have the same initialization already.

Index: linux-2.6.19-rc3/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.19-rc3.orig/arch/i386/kernel/io_apic.c	2006-10-29 20:41:20.000000000 +0100
+++ linux-2.6.19-rc3/arch/i386/kernel/io_apic.c	2006-10-29 21:55:19.000000000 +0100
@@ -2421,6 +2421,7 @@ int create_irq(void)
 	unsigned long flags;
 
 	irq = -ENOSPC;
+	vector = 0;
 	spin_lock_irqsave(&vector_lock, flags);
 	for (new = (NR_IRQS - 1); new >= 0; new--) {
 		if (platform_legacy_irq(new))


