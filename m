Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUC2Nhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUC2Ngc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:36:32 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:8635 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262849AbUC2MR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:17:26 -0500
Date: Mon, 29 Mar 2004 04:16:28 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT:  fix nodes_complement usage - x86_64 [22/22]
Message-Id: <20040329041628.68d82db1.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_22_of_22 - Fix nodes_complement call - it's a dyadic macro.
	One bit of code in Matthew's Patch 5 of 7 also had a
	nodes_complement call - convert it to two arg form.

diffstat Patch_22_of_22:
 k8topology.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1728  -> 1.1729 
#	arch/x86_64/mm/k8topology.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1729
# Fix nodes_complement call - it's a dyadic macro.
# --------------------------------------------
#
diff -Nru a/arch/x86_64/mm/k8topology.c b/arch/x86_64/mm/k8topology.c
--- a/arch/x86_64/mm/k8topology.c	Mon Mar 29 01:41:13 2004
+++ b/arch/x86_64/mm/k8topology.c	Mon Mar 29 01:41:13 2004
@@ -163,7 +163,8 @@
 	   CPUs, as the number of CPUs is not known yet. 
 	   We round robin the existing nodes. */
 	rr = first_node(node_online_map);
-	nodemask_t node_offline_map = nodes_complement(node_online_map);
+	nodemask_t node_offline_map;
+	nodes_complement(node_offline_map, node_online_map);
 	for_each_node_mask(i, node_offline_map) {
 		node_data[i] = node_data[rr];
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
