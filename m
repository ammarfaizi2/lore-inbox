Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWEJLdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWEJLdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWEJLdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:33:54 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:24753 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964926AbWEJLdx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:33:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mm: cleanup swap unused warning
Date: Wed, 10 May 2006 21:32:40 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605102132.41217.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any users of swp_entry_t when CONFIG_SWAP is not defined?

This patch fixes a warning for !CONFIG_SWAP for me.

---
if CONFIG_SWAP is not defined we get:

mm/vmscan.c: In function ‘remove_mapping’:
mm/vmscan.c:387: warning: unused variable ‘swap’

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/swap.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc3-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.17-rc3-mm1.orig/include/linux/swap.h	2006-05-10 21:14:41.000000000 +1000
+++ linux-2.6.17-rc3-mm1/include/linux/swap.h	2006-05-10 21:24:31.000000000 +1000
@@ -67,13 +67,20 @@ union swap_header {
 	} info;
 };
 
- /* A swap entry has to fit into a "unsigned long", as
-  * the entry is hidden in the "index" field of the
-  * swapper address space.
-  */
+/*
+ * A swap entry has to fit into a "unsigned long", as
+ * the entry is hidden in the "index" field of the
+ * swapper address space.
+ */
+#ifdef CONFIG_SWAP
 typedef struct {
 	unsigned long val;
 } swp_entry_t;
+#else
+typedef struct {
+	unsigned long val;
+} swp_entry_t __attribute__((__unused__));
+#endif
 
 /*
  * current->reclaim_state points to one of these when a task is running

-- 
-ck
