Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUBEU1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUBEU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:27:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18148 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266523AbUBEUZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:25:11 -0500
Date: Thu, 5 Feb 2004 12:25:03 -0800
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] memblks compile fixes
Message-ID: <20040205202503.GB6551@sgi.com>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like Jes forgot missed some conversions in his NR_MEMBLKS removal
patch.  Here's are the fixes to get ia64 going again.

Thanks,
Jesse

===== arch/ia64/kernel/acpi.c 1.60 vs edited =====
--- 1.60/arch/ia64/kernel/acpi.c	Tue Feb  3 21:35:17 2004
+++ edited/arch/ia64/kernel/acpi.c	Thu Feb  5 11:46:50 2004
@@ -395,7 +395,7 @@
 	size = ma->length_hi;
 	size = (size << 32) | ma->length_lo;
 
-	if (num_memblks >= NR_MEMBLKS) {
+	if (num_node_memblks >= NR_NODE_MEMBLKS) {
 		printk(KERN_ERR "Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
 		       size/(1024*1024), paddr);
 		return;
===== arch/ia64/sn/kernel/setup.c 1.30 vs edited =====
--- 1.30/arch/ia64/sn/kernel/setup.c	Tue Feb  3 21:39:58 2004
+++ edited/arch/ia64/sn/kernel/setup.c	Thu Feb  5 11:46:31 2004
@@ -136,7 +136,7 @@
 	int nid;
 
 	nid = pxm_to_nid_map[pxm];
-	for (i = 0; i < num_memblks; i++) {
+	for (i = 0; i < num_node_memblks; i++) {
 		if (node_memblk[i].nid == nid) {
 			return NASID_GET(node_memblk[i].start_paddr);
 		}
