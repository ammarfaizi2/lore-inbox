Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUIBMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUIBMpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUIBMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:45:18 -0400
Received: from ozlabs.org ([203.10.76.45]:59025 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268289AbUIBMpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:45:12 -0400
Date: Thu, 2 Sep 2004 22:39:52 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Allow SD_NODES_PER_DOMAIN to be overridden
Message-ID: <20040902123952.GE26072@krispykreme>
References: <20040902123713.GD26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902123713.GD26072@krispykreme>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow SD_NODES_PER_DOMAIN to be overridden.
On ppc64 set this at 16 so our top level scheduling domains will
include all nodes.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/asm-ppc64/processor.h~fix_smt include/asm-ppc64/processor.h
--- foobar2/include/asm-ppc64/processor.h~fix_smt	2004-09-02 22:22:49.861931162 +1000
+++ foobar2-anton/include/asm-ppc64/processor.h	2004-09-02 22:27:15.829370041 +1000
@@ -620,6 +620,8 @@ static inline void prefetchw(const void 
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
+#define SD_NODES_PER_DOMAIN 16
+
 #endif /* __KERNEL__ */
 
 #endif /* ASSEMBLY */
diff -puN kernel/sched.c~fix_smt kernel/sched.c
--- foobar2/kernel/sched.c~fix_smt	2004-09-02 22:28:29.144791718 +1000
+++ foobar2-anton/kernel/sched.c	2004-09-02 22:28:32.859032577 +1000
@@ -4305,7 +4305,9 @@ __init static int cpu_to_phys_group(int 
 #ifdef CONFIG_NUMA
 
 /* Number of nearby nodes in a node's scheduling domain */
+#ifndef SD_NODES_PER_DOMAIN
 #define SD_NODES_PER_DOMAIN 4
+#endif
 
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
_
