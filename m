Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938055AbWLHL5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938055AbWLHL5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938053AbWLHL5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:57:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52672 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938052AbWLHL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:57:17 -0500
Message-Id: <200612081152.kB8BqSKo019765@shell0.pdx.osdl.net>
Subject: [patch 06/13] io-accounting-read-accounting nfs fix
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com, wfg@mail.ustc.edu.cn
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

nfs's ->readpages uses read_cache_pages().  Wire it up there.

[wfg@mail.ustc.edu.cn: account only successful nfs/fuse reads]
Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/readahead.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN mm/readahead.c~io-accounting-read-accounting-nfs-fix mm/readahead.c
--- a/mm/readahead.c~io-accounting-read-accounting-nfs-fix
+++ a/mm/readahead.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/pagevec.h>
 
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
@@ -151,6 +152,7 @@ int read_cache_pages(struct address_spac
 			put_pages_list(pages);
 			break;
 		}
+		task_io_account_read(PAGE_CACHE_SIZE);
 	}
 	pagevec_lru_add(&lru_pvec);
 	return ret;
_
