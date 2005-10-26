Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVJZEVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVJZEVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 00:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVJZEVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 00:21:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932534AbVJZEVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 00:21:30 -0400
Message-Id: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
Subject: [patch 1/1] export cpu_online_map
To: rajesh.shah@intel.com
Cc: mingo@elte.hu, pj@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
From: akpm@osdl.org
Date: Tue, 25 Oct 2005 21:20:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

With CONFIG_SMP=n:

*** Warning: "cpu_online_map" [drivers/firmware/dcdbas.ko] undefined!

due to set_cpus_allowed().

Questions:

- Why isn't set_cpus_allowed() just a no-op on UP?  Or some trivial thing
  which tests for cpu #0?

- Why does cpu_online_map even exist on CONFIG_SMP=n?



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/sched.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN kernel/sched.c~export-cpu_online_map kernel/sched.c
--- devel/kernel/sched.c~export-cpu_online_map	2005-10-25 21:13:28.000000000 -0700
+++ devel-akpm/kernel/sched.c	2005-10-25 21:19:36.000000000 -0700
@@ -3879,6 +3879,7 @@ EXPORT_SYMBOL(cpu_present_map);
 
 #ifndef CONFIG_SMP
 cpumask_t cpu_online_map = CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_online_map);
 cpumask_t cpu_possible_map = CPU_MASK_ALL;
 #endif
 
_
