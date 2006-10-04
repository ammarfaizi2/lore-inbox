Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWJDRnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWJDRnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbWJDRmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:42:05 -0400
Received: from www.osadl.org ([213.239.205.134]:10469 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161546AbWJDRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:53 -0400
Message-Id: <20061004172222.555591000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:36 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 06/22] time: fix timeout overflow
Content-Disposition: inline; filename=time-fix-timeout-overflow.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Prevent timeout overflow if timer ticks are behind jiffies (due to high
softirq load or due to dyntick), by limiting the valid timeout range to
MAX_LONG/2.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 include/linux/jiffies.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm3/include/linux/jiffies.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/jiffies.h	2006-10-04 18:13:54.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/jiffies.h	2006-10-04 18:13:55.000000000 +0200
@@ -142,13 +142,13 @@ static inline u64 get_jiffies_64(void)
  *
  * And some not so obvious.
  *
- * Note that we don't want to return MAX_LONG, because
+ * Note that we don't want to return LONG_MAX, because
  * for various timeout reasons we often end up having
  * to wait "jiffies+1" in order to guarantee that we wait
  * at _least_ "jiffies" - so "jiffies+1" had better still
  * be positive.
  */
-#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
+#define MAX_JIFFY_OFFSET ((LONG_MAX >> 1)-1)
 
 /*
  * We want to do realistic conversions of time so we need to use the same

--

