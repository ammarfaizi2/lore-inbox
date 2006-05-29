Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWE2Vqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWE2Vqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWE2VXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20434 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751322AbWE2VXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:07 -0400
Date: Mon, 29 May 2006 23:23:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
Message-ID: <20060529212328.GE3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add WARN_ON_ONCE(cond) to print once-per-bootup messages.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-generic/bug.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux/include/asm-generic/bug.h
===================================================================
--- linux.orig/include/asm-generic/bug.h
+++ linux/include/asm-generic/bug.h
@@ -44,4 +44,17 @@
 # define WARN_ON_SMP(x)			do { } while (0)
 #endif
 
+#define WARN_ON_ONCE(condition)				\
+({							\
+	static int __warn_once = 1;			\
+	int __ret = 0;					\
+							\
+	if (unlikely(__warn_once && (condition))) {	\
+		__warn_once = 0;			\
+		WARN_ON(1);				\
+		__ret = 1;				\
+	}						\
+	__ret;						\
+})
+
 #endif
