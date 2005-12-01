Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVK3X73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVK3X73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVK3X67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:59 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27811
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751334AbVK3X6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:46 -0500
Subject: [patch 42/43] rename TIMER_SOFTIRQ to TIMEOUT_SOFTIRQ
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:27 +0100
Message-Id: <1133395467.32542.486.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-rename-TIMER_SOFTIRQ.patch)
- rename TIMER_SOFTIRQ to TIMEOUT_SOFTIRQ

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/interrupt.h |    2 +-
 kernel/ktimeout.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/linux/interrupt.h
===================================================================
--- linux.orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -109,7 +109,7 @@ extern void local_bh_enable(void);
 enum
 {
 	HI_SOFTIRQ=0,
-	TIMER_SOFTIRQ,
+	TIMEOUT_SOFTIRQ,
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	SCSI_SOFTIRQ,
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -550,7 +550,7 @@ static void run_ktimeout_softirq(struct 
  */
 void run_local_ktimeouts(void)
 {
-	raise_softirq(TIMER_SOFTIRQ);
+	raise_softirq(TIMEOUT_SOFTIRQ);
 }
 
 static void process_timeout(unsigned long __data)
@@ -773,5 +773,5 @@ void __init init_ktimeouts(void)
 	ktimeout_cpu_notify(&ktimeouts_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
 	register_cpu_notifier(&ktimeouts_nb);
-	open_softirq(TIMER_SOFTIRQ, run_ktimeout_softirq, NULL);
+	open_softirq(TIMEOUT_SOFTIRQ, run_ktimeout_softirq, NULL);
 }

--

