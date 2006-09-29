Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWI3AFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWI3AFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWI3AEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:04:31 -0400
Received: from www.osadl.org ([213.239.205.134]:37524 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422855AbWI3AES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:18 -0400
Message-Id: <20060929234441.323486000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:42 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 22/23] dynticks: increase SLAB timeouts
Content-Disposition: inline; filename=slab-slowdown-nohz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

decrease the rate of SLAB timers going off. Reduces the amount
of timers going off in an idle system.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 mm/slab.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/mm/slab.c
===================================================================
--- linux-2.6.18-mm2.orig/mm/slab.c	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/mm/slab.c	2006-09-30 01:41:20.000000000 +0200
@@ -457,8 +457,13 @@ struct kmem_cache {
  * OTOH the cpuarrays can contain lots of objects,
  * which could lock up otherwise freeable slabs.
  */
-#define REAPTIMEOUT_CPUC	(2*HZ)
-#define REAPTIMEOUT_LIST3	(4*HZ)
+#ifdef CONFIG_NO_HZ
+# define REAPTIMEOUT_CPUC	(4*HZ)
+# define REAPTIMEOUT_LIST3	(8*HZ)
+#else
+# define REAPTIMEOUT_CPUC	(2*HZ)
+# define REAPTIMEOUT_LIST3	(4*HZ)
+#endif
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)

--

