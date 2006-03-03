Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWCCSz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWCCSz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWCCSz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:55:26 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:30843 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161029AbWCCSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:55:23 -0500
Date: Fri, 3 Mar 2006 19:55:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jblunck@suse.de, linux-kernel@vger.kernel.org
Subject: [patch 2/2] s390: fix compile with VIRT_CPU_ACCOUNTING=n.
Message-ID: <20060303185531.GB16574@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Blunck <jblunck@suse.de>

[patch 2/2] s390: fix compile with VIRT_CPU_ACCOUNTING=n.

When CONFIG_VIRT_CPU_ACCOUNTING is not defined compiling fails with an
undefined reference to account_vtime().

Signed-off-by: Jan Blunck <jblunck@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/system.h |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2006-03-03 18:52:32.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2006-03-03 18:53:21.000000000 +0100
@@ -118,6 +118,8 @@ static inline void sched_cacheflush(void
 extern void account_vtime(struct task_struct *);
 extern void account_tick_vtime(struct task_struct *);
 extern void account_system_vtime(struct task_struct *);
+#else
+#define account_vtime(x) do { /* empty */ } while (0)
 #endif
 
 #define finish_arch_switch(prev) do {					     \
