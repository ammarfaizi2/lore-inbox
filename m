Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCSCeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCSCeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCSCea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:38338 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751270AbWCSCea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:30 -0500
Message-Id: <20060319023452.306314000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:21 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 08/23] readahead: common macros
Content-Disposition: inline; filename=readahead-common-macros.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define some common used macros for the read-ahead logics.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -14,6 +14,17 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/writeback.h>
+#include <linux/nfsd/const.h>
+
+/* The default max/min read-ahead pages. */
+#define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
+#define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
+#define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
+#define MIN_NFSD_PAGES	KB(NFSSVC_MAXBLKSIZE/1024)
+
+#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
+#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
@@ -21,7 +32,7 @@ void default_unplug_io_fn(struct backing
 EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
-	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.ra_pages	= MAX_RA_PAGES,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
@@ -49,7 +60,7 @@ static inline unsigned long get_max_read
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)
 {
-	return (VM_MIN_READAHEAD * 1024) / PAGE_CACHE_SIZE;
+	return MIN_RA_PAGES;
 }
 
 static inline void reset_ahead_window(struct file_ra_state *ra)

--
