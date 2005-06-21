Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVFUWfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVFUWfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVFUW2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:28:40 -0400
Received: from mail.tyan.com ([66.122.195.4]:57610 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262537AbVFUVjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:10 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12 with dual way dual core ck804 MB
Date: Tue, 21 Jun 2005 14:41:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

for the dual way dual core Opteron ck804 MB, the 2.6.12 still has the timing
problem, I  still need to add one printk in amd_detec_cmp after the
phys_proc_id is setup.

Regards

YH

static void __init amd_detect_cmp(struct cpuinfo_x86 *c)
{
#ifdef CONFIG_SMP
        int cpu = smp_processor_id();
        int node = 0;
        unsigned bits;
        if (c->x86_num_cores == 1)
                return;

        bits = 0;
        while ((1 << bits) < c->x86_num_cores)
                bits++;

        /* Low order bits define the core id (index of core in socket) */
        cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
        /* Convert the APIC ID into the socket ID */
        phys_proc_id[cpu] >>= bits;
+        printk(KERN_INFO "  CPU %d(%d)  phys_proc_id %d  Core %d\n",
+                        cpu, c->x86_num_cores, phys_proc_id[cpu],
cpu_core_id[cpu]);
