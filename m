Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275058AbTHLFzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275059AbTHLFzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:55:41 -0400
Received: from [66.212.224.118] ([66.212.224.118]:54020 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275058AbTHLFzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:55:38 -0400
Date: Tue, 12 Aug 2003 01:43:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6-mm] cpumask_t - flush_tlb_others warning
Message-ID: <Pine.LNX.4.53.0308120039540.26153@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86_64/kernel/smp.c: In function `flush_tlb_others':
arch/x86_64/kernel/smp.c:262: warning: passing arg 1 of `bitmap_or' 
discards qualifiers from pointer target type
arch/x86_64/kernel/smp.c:262: warning: passing arg 3 of `bitmap_or' 
discards qualifiers from pointer target type
arch/x86_64/kernel/smp.c:270: warning: passing arg 1 of `bitmap_empty' 
discards qualifiers from pointer target type

Index: linux-2.6.0-test3-x86_64/arch/x86_64/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/arch/x86_64/kernel/smp.c,v
retrieving revision 1.2
diff -u -p -B -r1.2 smp.c
--- linux-2.6.0-test3-x86_64/arch/x86_64/kernel/smp.c	12 Aug 2003 04:37:27 -0000	1.2
+++ linux-2.6.0-test3-x86_64/arch/x86_64/kernel/smp.c	12 Aug 2003 04:55:01 -0000
@@ -134,7 +134,7 @@ static inline void send_IPI_mask(cpumask
  *	Optimizations Manfred Spraul <manfred@colorfullife.com>
  */
 
-static volatile cpumask_t flush_cpumask;
+static cpumask_t flush_cpumask;
 static struct mm_struct * flush_mm;
 static unsigned long flush_va;
 static spinlock_t tlbstate_lock = SPIN_LOCK_UNLOCKED;
@@ -268,7 +268,7 @@ static void flush_tlb_others(cpumask_t c
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
 	while (!cpus_empty(flush_cpumask))
-		/* nothing. lockup detection does not belong here */;
+		mb();	/* nothing. lockup detection does not belong here */;
 
 	flush_mm = NULL;
 	flush_va = 0;
