Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933450AbWKNQIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbWKNQIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933449AbWKNQIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:08:53 -0500
Received: from mail.suse.de ([195.135.220.2]:9615 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933448AbWKNQIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:08:53 -0500
From: Andi Kleen <ak@suse.de>
Message-Id: <20061114508.445749000@suse.de>
To: "Aaron Durbin" <adurbin@google.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [1/9] x86_64: Fix partial page check to ensure unusable memory is not being marked usable.
Date: Tue, 14 Nov 2006 17:08:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Aaron Durbin" <adurbin@google.com>
Fix partial page check in e820_register_active_regions to ensure
partial pages are
not being marked as active in the memory pool.

Signed-off-by: Aaron Durbin <adurbin@google.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
This was causing a machine to reboot w/ an area in the e820 that was less
than the page size because the upper address was being use to mark a hole as
active in the memory pool.

 arch/x86_64/kernel/e820.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
@@ -278,7 +278,7 @@ e820_register_active_regions(int nid, un
 								>> PAGE_SHIFT;
 
 		/* Skip map entries smaller than a page */
-		if (ei_startpfn > ei_endpfn)
+		if (ei_startpfn >= ei_endpfn)
 			continue;
 
 		/* Check if end_pfn_map should be updated */
