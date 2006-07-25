Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWGYQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGYQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGYQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:56:59 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:29023 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932470AbWGYQ46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:56:58 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 7] [x86-64] Calgary IOMMU: rearrange 'struct iommu_table'
	members
X-Mercurial-Node: bc678333b410a6aa7bf86a97f314a62c300dae3a
Message-Id: <bc678333b410a6aa7bf8.1153846591@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:31 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 3 insertions(+), 3 deletions(-)
include/asm-x86_64/calgary.h |    6 +++---


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153732042 -10800
# Node ID bc678333b410a6aa7bf86a97f314a62c300dae3a
# Parent  8b88f7d9cf044a7b43aff57dd019b6786d1ab66e
[x86-64] Calgary IOMMU: rearrange 'struct iommu_table' members

Rearrange struct members loosely based on size for improved alignment
and to save a few bytes.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 8b88f7d9cf04 -r bc678333b410 include/asm-x86_64/calgary.h
--- a/include/asm-x86_64/calgary.h	Mon Jul 24 08:28:10 2006 +0300
+++ b/include/asm-x86_64/calgary.h	Mon Jul 24 12:07:22 2006 +0300
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
