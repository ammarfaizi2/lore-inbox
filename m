Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbUANM1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUANM1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:27:49 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:22496 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S266108AbUANM1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:27:48 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: 2.6.1-mm3
References: <20040114014846.78e1a31b.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 14 Jan 2004 07:27:34 -0500
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Message-ID: <yq04quyr9zd.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Tiny patch to make -mm3 compile on an NUMA box with NR_CPUS >
BITS_PER_LONG.

Cheers,
Jes

--- old/kernel/sched.c~	Wed Jan 14 02:59:53 2004
+++ new/kernel/sched.c	Wed Jan 14 03:18:28 2004
@@ -3249,7 +3249,7 @@
 		for_each_cpu_mask(j, node->cpumask) {
 			struct sched_group *cpu = &sched_group_cpus[j];
 
-			cpu->cpumask = CPU_MASK_NONE;
+			cpus_clear(cpu->cpumask);
 			cpu_set(j, cpu->cpumask);
 
 			printk(KERN_INFO "CPU%d\n", j);
