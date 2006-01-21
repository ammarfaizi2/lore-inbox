Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWAUBiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWAUBiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWAUBiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:38:03 -0500
Received: from fmr23.intel.com ([143.183.121.15]:33930 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964834AbWAUBiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:38:02 -0500
Date: Fri, 20 Jan 2006 17:37:23 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, matthew.e.tolentino@intel.com
Subject: __cpuinit functions wrongly marked __meminit
Message-ID: <20060120173723.A7060@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

This is required, __meminit has overzelously been modified and crept its way
into marking cpuup callbacks as __meminit. 

I still have some trouble in getting cpu up to work on x86_64, even with these 
changes and it might be some other changes that iam trying to hunt down.

Seems NUMA related. IA64 seems to work fine for now.



-- 
Cheers,
Ashok Raj
- Open Source Technology Center


__meminit has overzelously been modified and crept its way
into marking cpuup callbacks as __meminit. 

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------
 mm/page_alloc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc1-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/mm/page_alloc.c
+++ linux-2.6.16-rc1-mm2/mm/page_alloc.c
@@ -1876,7 +1876,7 @@ void zonetable_add(struct zone *zone, in
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif
 
-static int __meminit zone_batchsize(struct zone *zone)
+static int __cpuinit zone_batchsize(struct zone *zone)
 {
 	int batch;
 
@@ -1970,7 +1970,7 @@ static struct per_cpu_pageset
  * Dynamically allocate memory for the
  * per cpu pageset array in struct zone.
  */
-static int __meminit process_zones(int cpu)
+static int __cpuinit process_zones(int cpu)
 {
 	struct zone *zone, *dzone;
 
@@ -2011,7 +2011,7 @@ static inline void free_zone_pagesets(in
 	}
 }
 
-static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
+static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
 {
