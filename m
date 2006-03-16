Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWCPDWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWCPDWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCPDWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:22:25 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49086 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750755AbWCPDWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:22:24 -0500
Date: Thu, 16 Mar 2006 12:21:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
Message-Id: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now,
for_each_cpu() is for-loop cpu over cpu_possible_map.
for_each_online_cpu is for-loop cpu over cpu_online_map.
.....for_each_cpu() looks bad name.

This patch renames for_each_cpu() as for_each_possible_cpu().

I also wrote patches to replace all for_each_cpu with for_each_possible_cpu.
please confirm....

BTW, when HOTPLUC_CPU is not suppoted, using for_each_possible_cpu()
should be avoided, I think.

all patches are against 2.6.16-rc6-mm1.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/include/linux/cpumask.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/cpumask.h
+++ linux-2.6.16-rc6-mm1/include/linux/cpumask.h
@@ -67,7 +67,7 @@
  *
  * int any_online_cpu(mask)		First online cpu in mask
  *
- * for_each_cpu(cpu)			for-loop cpu over cpu_possible_map
+ * for_each_possible_cpu(cpu)		for-loop cpu over cpu_possible_map
  * for_each_online_cpu(cpu)		for-loop cpu over cpu_online_map
  * for_each_present_cpu(cpu)		for-loop cpu over cpu_present_map
  *
@@ -407,7 +407,7 @@ extern cpumask_t cpu_present_map;
 	cpu;					\
 })
 
-#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
