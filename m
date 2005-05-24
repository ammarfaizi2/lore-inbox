Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVEXKwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVEXKwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXKwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:52:13 -0400
Received: from fmr18.intel.com ([134.134.136.17]:17381 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262030AbVEXJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:26:25 -0400
Subject: Re: [patch 0/4] CPU Hotplug support for X86_64
From: Shaohua Li <shaohua.li@intel.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ak@muc.de, akpm <akpm@osdl.org>, zwane <zwane@arm.linux.org.uk>,
       rusty@rustycorp.com.au, vatsa@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
In-Reply-To: <20050524081113.409604000@csdlinux-2.jf.intel.com>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 17:31:38 +0800
Message-Id: <1116927099.3827.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 01:11 -0700, Ashok Raj wrote:
> TBD: 
> 
> 1. Track down CONFIG_SCHED_SMT Oops with both cpu up/down.
> 2. Test on real NUMA hw. 
> 
With below patch, cpu hotplug works with SCHED_SMT enabled in my test.
set_cpu_sibling_map is invoked before cpu is set to online.

Thanks,
Shaohua

--- a/arch/x86_64/kernel/smpboot.c.orig	2005-05-24 16:47:57.000000000 +0800
+++ b/arch/x86_64/kernel/smpboot.c	2005-05-24 16:48:31.000000000 +0800
@@ -443,7 +443,7 @@ set_cpu_sibling_map(int cpu)
 	int i;
 
 	if (smp_num_siblings > 1) {
-		for_each_online_cpu(i) {
+		for (i = 0; i < NR_CPUS; i++) {
 			if (cpu_core_id[cpu] == cpu_core_id[i]) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
@@ -454,7 +454,7 @@ set_cpu_sibling_map(int cpu)
 	}
 
 	if (current_cpu_data.x86_num_cores > 1) {
-		for_each_online_cpu(i) {
+		for (i = 0; i < NR_CPUS; i++) {
 			if (phys_proc_id[cpu] == phys_proc_id[i]) {
 				cpu_set(i, cpu_core_map[cpu]);
 				cpu_set(cpu, cpu_core_map[i]);


