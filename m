Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUIHN75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUIHN75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUIHN50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:57:26 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:35755 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269152AbUIHNpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:45:34 -0400
Message-ID: <413EFFFB.5050902@yahoo.com.au>
Date: Wed, 08 Sep 2004 22:50:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] sched: trivial changes
Content-Type: multipart/mixed;
 boundary="------------040700060003020005010709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040700060003020005010709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Couple of trival changes before the hotplug stuff.

--------------040700060003020005010709
Content-Type: text/x-patch;
 name="sched-trivial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-trivial.patch"



Make a definition static and slightly sanitize ifdefs.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/kernel/sched.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN kernel/sched.c~sched-trivial kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-trivial	2004-09-08 21:01:53.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-09-08 22:39:38.000000000 +1000
@@ -247,9 +247,7 @@ struct sched_group {
 
 	/*
 	 * CPU power of this group, SCHED_LOAD_SCALE being max power for a
-	 * single CPU. This should be read only (except for setup). Although
-	 * it will need to be written to at cpu hot(un)plug time, perhaps the
-	 * cpucontrol semaphore will provide enough exclusion?
+	 * single CPU. This is read only (except for setup, hotplug CPU).
 	 */
 	unsigned long cpu_power;
 };
@@ -4053,7 +4051,8 @@ static void cpu_attach_domain(struct sch
  * in arch code. That defines the number of nearby nodes in a node's top
  * level scheduling domain.
  */
-#if defined(CONFIG_NUMA) && defined(SD_NODES_PER_DOMAIN)
+#ifdef CONFIG_NUMA
+#ifdef SD_NODES_PER_DOMAIN
 /**
  * find_next_best_node - find the next node to include in a sched_domain
  * @node: node whose sched_domain we're building
@@ -4100,7 +4099,7 @@ static int __init find_next_best_node(in
  * should be one that prevents unnecessary balancing, but also spreads tasks
  * out optimally.
  */
-cpumask_t __init sched_domain_node_span(int node)
+static cpumask_t __init sched_domain_node_span(int node)
 {
 	int i;
 	cpumask_t span;
@@ -4119,12 +4118,13 @@ cpumask_t __init sched_domain_node_span(
 
 	return span;
 }
-#else /* CONFIG_NUMA && SD_NODES_PER_DOMAIN */
-cpumask_t __init sched_domain_node_span(int node)
+#else /* SD_NODES_PER_DOMAIN */
+static cpumask_t __init sched_domain_node_span(int node)
 {
 	return cpu_possible_map;
 }
-#endif /* CONFIG_NUMA && SD_NODES_PER_DOMAIN */
+#endif /* SD_NODES_PER_DOMAIN */
+#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SCHED_SMT
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);

_

--------------040700060003020005010709--
