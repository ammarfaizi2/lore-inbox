Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVDBSLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVDBSLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDBSLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:11:16 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:20419 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261774AbVDBSK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:10:27 -0500
Subject: [PATCH] fix subarch breakage in intel_cacheinfo.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 12:10:17 -0600
Message-Id: <1112465417.5786.15.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not all x86 subarchitectures have support for hyperthreading, so every
piece you add for it has to be predicated on checks for CONFIG_X86_HT.

The patch corrects this hyperthreading leakage problem in
intel_cacheinfo.c

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

===== arch/i386/kernel/cpu/intel_cacheinfo.c 1.3 vs edited =====
--- 1.3/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-31 05:06:44 -06:00
+++ edited/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-04-02 12:03:39 -06:00
@@ -311,8 +311,10 @@
 
 	if (num_threads_sharing == 1)
 		cpu_set(cpu, this_leaf->shared_cpu_map);
+#ifdef CONFIG_X86_HT
 	else if (num_threads_sharing == smp_num_siblings)
 		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
+#endif
 	else
 		printk(KERN_INFO "Number of CPUs sharing cache didn't match "
 				"any known set of CPUs\n");


