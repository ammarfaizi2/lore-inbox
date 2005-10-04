Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVJDMo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVJDMo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVJDMnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:04 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:36067 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932406AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:42:04 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 7/7] HPET: simplify initialization message
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124204.23057.29610.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: f6096ab4fa117ba63f870fa2b57272d1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>

When booting, display the timer frequency in Hertz instead of as tick
length in nanoseconds.  Apart from saving a local variable, this makes
the message more easily comprehensible.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:53:24.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:28.000000000 +0200
@@ -798,7 +798,7 @@ int hpet_alloc(struct hpet_data *hdp)
 	size_t siz;
 	struct hpet __iomem *hpet;
 	static struct hpets *last = (struct hpets *)0;
-	unsigned long ns, period;
+	unsigned long period;
 	unsigned long long temp;
 
 	/*
@@ -863,10 +863,9 @@ int hpet_alloc(struct hpet_data *hdp)
 		printk("%s %d", i > 0 ? "," : "", hdp->hd_irq[i]);
 	printk("\n");
 
-	ns = period / 1000000;	/* convert to nanoseconds, 10^-9 */
-	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
-		hpetp->hp_which, ns, hpetp->hp_ntimer,
-		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
+	printk(KERN_INFO "hpet%u: %u %d-bit timers, %Lu Hz\n",
+	       hpetp->hp_which, hpetp->hp_ntimer,
+	       cap & HPET_COUNTER_SIZE_MASK ? 64 : 32, hpetp->hp_tick_freq);
 
 	mcfg = readq(&hpet->hpet_config);
 	if ((mcfg & HPET_ENABLE_CNF_MASK) == 0) {
