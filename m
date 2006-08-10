Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWHJULT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWHJULT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWHJULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:11:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:50832 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932622AbWHJTgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:31 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [74/145] x86_64: Calgary IOMMU: rearrange 'struct iommu_table' members
Message-Id: <20060810193630.87F2213C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:30 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Rearrange struct members loosely based on size for improved alignment
and to save a few bytes.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/calgary.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux/include/asm-x86_64/calgary.h
===================================================================
--- linux.orig/include/asm-x86_64/calgary.h
+++ linux/include/asm-x86_64/calgary.h
@@ -34,12 +34,12 @@ struct iommu_table {
 	unsigned long  it_base;      /* mapped address of tce table */
 	unsigned long  it_hint;      /* Hint for next alloc */
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
+	void __iomem  *bbar;         /* Bridge BAR */
+	u64	       tar_val;      /* Table Address Register */
+	struct timer_list watchdog_timer;
 	spinlock_t     it_lock;      /* Protects it_map */
 	unsigned int   it_size;      /* Size of iommu table in entries */
 	unsigned char  it_busno;     /* Bus number this table belongs to */
-	void __iomem  *bbar;
-	u64	       tar_val;
-	struct timer_list watchdog_timer;
 };
 
 #define TCE_TABLE_SIZE_UNSPECIFIED	~0
