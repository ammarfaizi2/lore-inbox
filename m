Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUBILbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUBILbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:31:52 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.67]:37291 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264942AbUBILbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:31:04 -0500
Date: Mon, 09 Feb 2004 06:29:52 -0500
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH] Clean up
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Message-id: <200402090629.52433.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed the nested ifdefs, and made it little more readable.

Josef 'Jeff' Sipek


diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c    Mon Feb  9 03:22:21 2004
+++ b/arch/i386/kernel/irq.c    Mon Feb  9 03:22:21 2004
@@ -126,11 +126,9 @@
 };

 atomic_t irq_err_count;
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
+#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
 atomic_t irq_mis_count;
 #endif
-#endif

 /*
  * Generic, controller-independent functions:
@@ -186,10 +184,8 @@
                seq_putc(p, '\n');
 #endif
                seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
+#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
                seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
-#endif
 #endif
        }
        return 0;


-- 
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

