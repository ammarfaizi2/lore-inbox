Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWFRHie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWFRHie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFRHiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:38:16 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:44437 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932119AbWFRHfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:35:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][26/29] mm-set_zero_dirty_ratio.patch
Date: Sun, 18 Jun 2006 17:35:13 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2562
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181735.13698.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set dirty_ratio to 0 by default. This makes processes doing file writes more
responsible for any I/O induced delays by throttling them very early instead
of handing off the workload to a pdflush thread. This improves latencies for
small writes and any reads in the presence of heavy writes. It also helps
preserve more mapped pages and useful pagecache by not ever having large
amounts of dirty data taking up ram.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/page-writeback.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-ck-dev/mm/page-writeback.c
===================================================================
--- linux-ck-dev.orig/mm/page-writeback.c	2006-06-18 15:25:16.000000000 +1000
+++ linux-ck-dev/mm/page-writeback.c	2006-06-18 15:25:22.000000000 +1000
@@ -64,33 +64,33 @@ static inline long sync_writeback_pages(
 /*
  * Start background writeback (via pdflush) at this percentage
  */
-int dirty_background_ratio = 10;
+int dirty_background_ratio __read_mostly = 10;
 
 /*
  * The generator of dirty data starts writeback at this percentage
  */
-int vm_dirty_ratio = 40;
+int vm_dirty_ratio __read_mostly;
 
 /*
  * The interval between `kupdate'-style writebacks, in jiffies
  */
-int dirty_writeback_interval = 5 * HZ;
+int dirty_writeback_interval __read_mostly = 5 * HZ;
 
 /*
  * The longest number of jiffies for which data is allowed to remain dirty
  */
-int dirty_expire_interval = 30 * HZ;
+int dirty_expire_interval __read_mostly = 30 * HZ;
 
 /*
  * Flag that makes the machine dump writes/reads and block dirtyings.
  */
-int block_dump;
+int block_dump __read_mostly;
 
 /*
  * Flag that puts the machine in "laptop mode". Doubles as a timeout in jiffies:
  * a full sync is triggered after this time elapses without any disk activity.
  */
-int laptop_mode;
+int laptop_mode __read_mostly;
 
 EXPORT_SYMBOL(laptop_mode);
 

-- 
-ck
