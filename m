Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUKAWWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUKAWWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S325728AbUKAWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:14:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291939AbUKATaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:39 -0500
Date: Mon, 1 Nov 2004 19:30:21 GMT
Message-Id: <200411011930.iA1JULxi023187@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 5/14] FRV: Fork fixes
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes fork to get rid of the assumption that THREAD_SIZE >=
PAGE_SIZE (on the FR-V the smallest available page size is 16KB).

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-fork-2610rc1bk10.diff
 fork.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/fork.c linux-2.6.10-rc1-bk10-frv/kernel/fork.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/fork.c	2004-11-01 11:45:34.740160149 +0000
+++ linux-2.6.10-rc1-bk10-frv/kernel/fork.c	2004-11-01 11:47:05.153633406 +0000
@@ -118,7 +118,12 @@
 	 * value: the thread structures can take up at most half
 	 * of memory.
 	 */
+#if THREAD_SIZE >= PAGE_SIZE
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
+#else
+	max_threads = mempages / 8;
+#endif
+
 	/*
 	 * we need to allow at least 20 threads to boot a system
 	 */
