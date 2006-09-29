Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWI3AKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWI3AKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWI3AKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:10:12 -0400
Received: from www.osadl.org ([213.239.205.134]:7316 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932377AbWI3AEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:02 -0400
Message-Id: <20060929234439.495950000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:25 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 06/23] time: fix timeout overflow
Content-Disposition: inline;
	filename=max-jiffies-timeout-prevent-overflow.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

prevent timeout overflow if timer ticks are behind jiffies (due to high
softirq load or due to dyntick), by limiting the valid timeout range
to MAX_LONG/2.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 include/linux/jiffies.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/include/linux/jiffies.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/jiffies.h	2006-09-30 01:41:15.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/jiffies.h	2006-09-30 01:41:16.000000000 +0200
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

