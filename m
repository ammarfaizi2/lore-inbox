Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUA2WPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266480AbUA2WO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:14:59 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:24083 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266478AbUA2WOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:14:55 -0500
Date: Thu, 29 Jan 2004 16:14:44 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: [PATCH] - Move cpu_vm_mask to be closer to mmu_context_t in struct mm
Message-ID: <20040129221444.GA11032@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The cpu_vm_mask use to be close to the mmu_context_t field
in the mm struct. Recently some large members were
added between "cpu_vm_mask" and "context". I suspect that
was an oversight. 

Here is a patch that puts the fields close together. This
makes it likely that both fields are in the same cache line. 
Since both fields are likely to be updated at the same 
time, this may improve performance.




--- linux.base/./include/linux/sched.h	Mon Jan 26 17:06:13 2004
+++ linux/./include/linux/sched.h	Thu Jan 29 13:28:15 2004
@@ -206,7 +206,6 @@
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
-	cpumask_t cpu_vm_mask;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
@@ -214,6 +213,8 @@
 #ifdef CONFIG_HUGETLB_PAGE
 	int used_hugetlb;
 #endif
+	cpumask_t cpu_vm_mask;
+
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


