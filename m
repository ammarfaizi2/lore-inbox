Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbUJZN2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUJZN2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUJZN2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:28:37 -0400
Received: from verein.lst.de ([213.95.11.210]:45282 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262262AbUJZN2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:28:22 -0400
Date: Tue, 26 Oct 2004 15:28:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove invoke_softirq
Message-ID: <20041026132815.GC25384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this was used by the early irqstacks implementation on s390 and has been
replaced by __ARCH_HAS_DO_SOFTIRQ now


--- 1.32/include/linux/interrupt.h	2004-10-22 03:45:25 +02:00
+++ edited/include/linux/interrupt.h	2004-10-26 12:51:13 +02:00
@@ -109,10 +109,6 @@
 extern void FASTCALL(raise_softirq_irqoff(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
-#ifndef invoke_softirq
-#define invoke_softirq() do_softirq()
-#endif
-
 
 /* Tasklets --- multithreaded analogue of BHs.
 
--- 1.58/kernel/softirq.c	2004-10-19 07:26:37 +02:00
+++ edited/kernel/softirq.c	2004-10-26 12:51:23 +02:00
@@ -145,7 +145,7 @@
 	preempt_count() -= SOFTIRQ_OFFSET - 1;
 
 	if (unlikely(!in_interrupt() && local_softirq_pending()))
-		invoke_softirq();
+		do_softirq();
 
 	dec_preempt_count();
 	preempt_check_resched();
