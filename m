Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265633AbUFXVVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUFXVVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUFXVVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:21:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:47568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265633AbUFXVVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:21:53 -0400
Date: Thu, 24 Jun 2004 14:24:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2: compile error SCHED_SMT + NUMA + gcc 2.95
Message-Id: <20040624142403.378df57d.akpm@osdl.org>
In-Reply-To: <20040624205922.GC26669@fs.tum.de>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
	<20040624205922.GC26669@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
>  CC      arch/i386/kernel/smpboot.o
> arch/i386/kernel/smpboot.c: In function `arch_init_sched_domains':
> arch/i386/kernel/smpboot.c:1195: invalid lvalue in unary `&'
> arch/i386/kernel/smpboot.c:1231: invalid lvalue in unary `&'

--- 25/arch/i386/kernel/smpboot.c~smpboot-build-fix	Thu Jun 24 14:22:55 2004
+++ 25-akpm/arch/i386/kernel/smpboot.c	Thu Jun 24 14:22:55 2004
@@ -1192,7 +1192,9 @@ __init void arch_init_sched_domains(void
 		int j;
 		cpumask_t nodemask;
 		struct sched_group *node = &sched_group_nodes[i];
-		cpus_and(nodemask, node_to_cpumask(i), cpu_possible_map);
+		cpumask_t node_cpumask = node_to_cpumask(i);
+
+		cpus_and(nodemask, node_cpumask, cpu_possible_map);
 
 		if (cpus_empty(nodemask))
 			continue;
@@ -1228,7 +1230,9 @@ __init void arch_init_sched_domains(void
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		struct sched_group *cpu = &sched_group_nodes[i];
 		cpumask_t nodemask;
-		cpus_and(nodemask, node_to_cpumask(i), cpu_possible_map);
+		cpumask_t node_cpumask = node_to_cpumask(i);
+
+		cpus_and(nodemask, node_cpumask, cpu_possible_map);
 
 		if (cpus_empty(nodemask))
 			continue;
_

