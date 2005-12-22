Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVLVWVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVLVWVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVLVWVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:21:39 -0500
Received: from ns1.siteground.net ([207.218.208.2]:37269 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030348AbVLVWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:21:38 -0500
Date: Thu, 22 Dec 2005 14:21:34 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: [patch] x86_64/ia64 : Fix compilation error for node_to_first_cpu
Message-ID: <20051222222134.GB3704@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a compiler error in node_to_first_cpu, __ffs expects unsigned long as
a parameter; instead cpumask_t was being passed.  The macro
node_to_first_cpu was not yet used in x86_64 and ia64 arches, and so we never 
hit this.  This patch replaces __ffs with first_cpu macro, similar to other
arches.

Please apply for 2.6.15

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran G Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>


Index: linux-2.6.15-rc6/include/asm-ia64/topology.h
===================================================================
--- linux-2.6.15-rc6.orig/include/asm-ia64/topology.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc6/include/asm-ia64/topology.h	2005-12-22 10:48:14.000000000 -0800
@@ -38,7 +38,7 @@
 /*
  * Returns the number of the first CPU on Node 'node'.
  */
-#define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
+#define node_to_first_cpu(node) (first_cpu(node_to_cpumask(node)))
 
 /*
  * Determines the node for a given pci bus
Index: linux-2.6.15-rc6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.15-rc6.orig/include/asm-x86_64/topology.h	2005-12-22 10:06:01.000000000 -0800
+++ linux-2.6.15-rc6/include/asm-x86_64/topology.h	2005-12-22 10:41:30.000000000 -0800
@@ -23,7 +23,7 @@
 
 #define cpu_to_node(cpu)		(cpu_to_node[cpu])
 #define parent_node(node)		(node)
-#define node_to_first_cpu(node) 	(__ffs(node_to_cpumask[node]))
+#define node_to_first_cpu(node) 	(first_cpu(node_to_cpumask[node]))
 #define node_to_cpumask(node)		(node_to_cpumask[node])
 #define pcibus_to_node(bus)		((long)(bus->sysdata))	
 #define pcibus_to_cpumask(bus)		node_to_cpumask(pcibus_to_node(bus));
