Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUCLGOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 01:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUCLGOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 01:14:38 -0500
Received: from ozlabs.org ([203.10.76.45]:51101 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261979AbUCLGOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 01:14:36 -0500
Subject: [TRIVIAL] Clean up
From: Trivial Patch Monkey <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079072011.23776.461.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 17:13:31 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  Josef 'Jeff' Sipek <jeffpc@optonline.net>(by way of Jeff Sipek <jeffpc@optonline.net>)

---
  I just noticed the nested ifdefs, and made it little more readable.
  
  Josef 'Jeff' Sipek
  
  

--- trivial-2.6.4/arch/i386/kernel/irq.c.orig	2004-03-12 16:56:07.000000000 +1100
+++ trivial-2.6.4/arch/i386/kernel/irq.c	2004-03-12 16:56:07.000000000 +1100
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
@@ -186,11 +184,9 @@
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
-#ifdef CONFIG_X86_IO_APIC
-#ifdef APIC_MISMATCH_DEBUG
+#if defined(CONFIG_X86_IO_APIC) && defined(APIC_MISMATCH_DEBUG)
 		seq_printf(p, "MIS: %10u\n", atomic_read(&irq_mis_count));
 #endif
-#endif
 	}
 	return 0;
 }
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Josef 'Jeff' Sipek <jeffpc@optonline.net>(by way of Jeff Sipek <jeffpc@optonline.net>): [PATCH] Clean up

