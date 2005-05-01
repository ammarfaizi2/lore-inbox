Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVEAPJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVEAPJx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVEAPJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:09:53 -0400
Received: from zork.zork.net ([64.81.246.102]:62858 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261497AbVEAPJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:09:45 -0400
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: 2.6.12-rc3-mm2: ppc pte_offset_map()
References: <20050430164303.6538f47c.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Date: Sun, 01 May 2005 16:08:25 +0100
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 30 Apr 2005 16:43:03 -0700")
Message-ID: <6uu0lnf0gm.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Mackertosh (PowerBook5.4), build fails with the following:

  fs/proc/task_mmu.c: In function `smaps_pte_range':
  fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
  fs/proc/task_mmu.c:177: error: `KM_PTE0' undeclared (first use in this function)
  fs/proc/task_mmu.c:177: error: (Each undeclared identifier is reported only once
  fs/proc/task_mmu.c:177: error: for each function it appears in.)
  fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'

With the naive patch below, it builds with this warning and everything works.

  fs/proc/task_mmu.c: In function `smaps_pte_range':
  fs/proc/task_mmu.c:208: warning: passing arg 1 of `kunmap_atomic' makes pointer from integer without a cast

I tried including linux/highmem.h in asm-ppc/pgtable.h
(smaps_pte_range() -> pte_offset_map() -> kmap_atomic()), but that
doesn't work.


--- S12-rc3-mm2/fs/proc/task_mmu.c~	2005-05-01 15:52:55.000000000 +0100
+++ S12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 15:23:22.000000000 +0100
@@ -1,4 +1,5 @@
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/hugetlb.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>


-- 
Dag vijandelijk luchtschip de huismeester is dood
