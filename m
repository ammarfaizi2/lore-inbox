Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFZAVw>; Tue, 25 Jun 2002 20:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFZAVv>; Tue, 25 Jun 2002 20:21:51 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23022 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316161AbSFZAVv>; Tue, 25 Jun 2002 20:21:51 -0400
Message-ID: <3D1908E4.8030404@us.ibm.com>
Date: Tue, 25 Jun 2002 17:20:52 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: [patch] boot hang on multi-quad machines.
Content-Type: multipart/mixed;
 boundary="------------080701030902000809050301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701030902000809050301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As mentioned in several posts, the balance_irq code introduced in 2.5.9 is 
broken for any architecture that doesn't use flat logical addressing.  Also, 
even when it does work, there have been several reports of it degrading 
performance.  As the NUMA-Q architecture I work with doesn't use flat logical 
addressing, and it isn't worth the possible performance hit, I'm submitting 
this patch for inclusion into the mainline.

Cheers!

-Matt


--------------080701030902000809050301
Content-Type: text/plain;
 name="balance_irq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="balance_irq-fix.patch"

--- linux-2.5.21-vanilla/arch/i386/kernel/io_apic.c	Fri Jun 14 17:17:44 2002
+++ linux-2.5.21-patched/arch/i386/kernel/io_apic.c.fixed	Mon Jun 24 17:54:20 2002
@@ -247,7 +247,7 @@
 
 static inline void balance_irq(int irq)
 {
-#if CONFIG_SMP
+#if (CONFIG_SMP && !CONFIG_MULTIQUAD)
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 

--------------080701030902000809050301--

