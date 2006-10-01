Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWJAXHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWJAXHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWJAXGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:06:54 -0400
Received: from www.osadl.org ([213.239.205.134]:63922 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932468AbWJAXGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:45 -0400
Message-Id: <20061001225723.719192000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:52 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 06/21] time: fix timeout overflow
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
--- linux-2.6.18-mm2.orig/include/linux/jiffies.h	2006-10-02 00:55:50.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/jiffies.h	2006-10-02 00:55:51.000000000 +0200
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

