Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTHVM5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTHVMvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:51:04 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:17826 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S263241AbTHVMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:39:06 -0400
Subject: [PATCH] sched: find_busiest_node
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Aug 2003 14:39:05 +0200
Message-Id: <1061555945.3341.26.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to get the best possible resolution we need to use NR_CPUS instead of the constant value 10.
load is an int, so no need to worry about overflows...


Frank.


 sched.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Aug 22 14:24:11 2003
+++ b/kernel/sched.c	Fri Aug 22 14:24:11 2003
@@ -849,7 +849,7 @@
  *      load_{t} = load_{t-1}/2 + nr_node_running_{t}
  * This way sudden load peaks are flattened out a bit.
  * Node load is divided by nr_cpus_node() in order to compare nodes
- * of different cpu count but also [first] multiplied by 10 to 
+ * of different cpu count but also [first] multiplied by NR_CPUS to 
  * provide better resolution.
  */
 static int find_busiest_node(int this_node)
@@ -859,14 +859,14 @@
 	if (!nr_cpus_node(this_node))
 		return node;
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
-		+ (10 * atomic_read(&node_nr_running[this_node])
+		+ (NR_CPUS * atomic_read(&node_nr_running[this_node])
 		/ nr_cpus_node(this_node));
 	this_rq()->prev_node_load[this_node] = this_load;
 	for_each_node_with_cpus(i) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
-			+ (10 * atomic_read(&node_nr_running[i])
+			+ (NR_CPUS * atomic_read(&node_nr_running[i])
 			/ nr_cpus_node(i));
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {



