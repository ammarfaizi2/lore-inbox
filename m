Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbUKHOd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUKHOd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUKHOdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:33:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261842AbUKHOcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:52 -0500
Date: Mon, 8 Nov 2004 14:32:40 GMT
Message-Id: <200411081432.iA8EWep3023379@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Fork fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes fork to get rid of the assumption that THREAD_SIZE >=
PAGE_SIZE (on the FR-V the smallest available page size is 16KB).

Signed-Off-By: dhowells@redhat.com
---
diffstat fork-2610rc1mm3.diff
 fork.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/fork.c linux-2.6.10-rc1-mm3-frv/kernel/fork.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/kernel/fork.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/kernel/fork.c	2004-11-05 14:13:04.517443917 +0000
@@ -119,7 +119,12 @@ void __init fork_init(unsigned long memp
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
