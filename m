Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUALQKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUALQKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:10:33 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:21983 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265539AbUALQK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:10:29 -0500
Date: Mon, 12 Jan 2004 08:10:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 and irq balancing
Message-ID: <893140000.1073923824@[10.10.2.4]>
In-Reply-To: <btt7pt$3m8$1@gatekeeper.tmr.com>
References: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com> <btt7pt$3m8$1@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How much is significant? The term doesn't really help much. I will say that with one NIC taking 120MB/sec of data to a TB database and copying to two other machine (~220MB)  my interrupts got up in in the 5k-12k range with essentially CPU0 doing the work, some few percent going to CPU2.


1010 per second, IIRC. Try this patch:

diff -aurpN -X /home/fletch/.diff.exclude 290-gfp_node_strict/arch/i386/kernel/io_apic.c 310-irqbal_fast/arch/i386/kernel/io_apic.c
--- 290-gfp_node_strict/arch/i386/kernel/io_apic.c	Fri Jan  9 22:25:48 2004
+++ 310-irqbal_fast/arch/i386/kernel/io_apic.c	Fri Jan  9 22:27:55 2004
@@ -401,7 +401,7 @@ static void do_irq_balance(void)
 	unsigned long max_cpu_irq = 0, min_cpu_irq = (~0);
 	unsigned long move_this_load = 0;
 	int max_loaded = 0, min_loaded = 0;
-	unsigned long useful_load_threshold = balanced_irq_interval + 10;
+	unsigned long useful_load_threshold = balanced_irq_interval / 10;
 	int selected_irq;
 	int tmp_loaded, first_attempt = 1;
 	unsigned long tmp_cpu_irq;

M.

