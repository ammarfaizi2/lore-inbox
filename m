Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVAMX3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVAMX3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVAMX0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:26:11 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:25819 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261774AbVAMXWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:22:54 -0500
Subject: [PATCH] generic irq code missing export of probe_irq_mask()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 17:22:37 -0600
Message-Id: <1105658558.5630.16.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox just converted parisc over to doing the generic irq code
and we ran across the symbol probe_irq_mask being undefined (and thus
preventing yenta_socket from loading).

It looks like the EXPORT_SYMBOL() was accidentally missed from
kernel/irq/autoprobe.c and no-one noticed on x86 because it's still in
i386_ksyms.c

This patch corrects the problem so that the generic irq code now works
completely on parisc.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

--

James

Index: linux-2.6/arch/i386/kernel/i386_ksyms.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/i386_ksyms.c,v
retrieving revision 1.11
diff -u -r1.11 i386_ksyms.c
--- linux-2.6/arch/i386/kernel/i386_ksyms.c	29 Nov 2004 19:55:27 -0000	1.11
+++ linux-2.6/arch/i386/kernel/i386_ksyms.c	13 Jan 2005 23:16:41 -0000
@@ -75,7 +75,6 @@
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
Index: linux-2.6/kernel/irq/autoprobe.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/irq/autoprobe.c,v
retrieving revision 1.2
diff -u -r1.2 autoprobe.c
--- linux-2.6/kernel/irq/autoprobe.c	21 Oct 2004 19:00:13 -0000	1.2
+++ linux-2.6/kernel/irq/autoprobe.c	13 Jan 2005 23:17:10 -0000
@@ -137,6 +137,7 @@
 
 	return mask & val;
 }
+EXPORT_SYMBOL(probe_irq_mask);
 
 /**
  *	probe_irq_off	- end an interrupt autodetect


