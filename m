Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUHAGGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUHAGGm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 02:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUHAGGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 02:06:42 -0400
Received: from ozlabs.org ([203.10.76.45]:1471 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265215AbUHAGGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 02:06:40 -0400
Date: Sun, 1 Aug 2004 16:01:44 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use for_each_cpu
Message-ID: <20040801060144.GI30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The per cpu schedule counters need to be summed up over all possible cpus.
When testing hotplug cpu remove I saw the sum of the online cpu count
for nr_uninterruptible go negative which made the load average go nuts.

Anton

diff -puN kernel/sched.c~debug_nr_running kernel/sched.c
--- foobar2/kernel/sched.c~debug_nr_running	2004-08-01 14:42:46.133968016 +1000
+++ foobar2-anton/kernel/sched.c	2004-08-01 15:26:17.272626720 +1000
@@ -1095,7 +1095,7 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_online_cpu(i)
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
 
 	return sum;
@@ -1105,7 +1105,7 @@ unsigned long long nr_context_switches(v
 {
 	unsigned long long i, sum = 0;
 
-	for_each_online_cpu(i)
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
 
 	return sum;
@@ -1115,7 +1115,7 @@ unsigned long nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
-	for_each_online_cpu(i)
+	for_each_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
