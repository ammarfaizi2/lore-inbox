Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVGNNNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVGNNNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGNNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:13:44 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:56029 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261372AbVGNNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:13:43 -0400
Subject: [PATCH] mb_cache_shrink() frees unexpected caches
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 22:07:24 +0900
Message-Id: <1121346444.4282.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mb_cache_shrink() tries to free all sort of mbcache in the lru list.

All user of mb_cache_shrink() are ext2/ext3 xattr.

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

--- 2.6-rc/fs/mbcache.c.orig	2005-07-14 20:40:34.000000000 +0900
+++ 2.6-rc/fs/mbcache.c	2005-07-14 20:43:42.000000000 +0900
@@ -329,7 +329,7 @@ mb_cache_shrink(struct mb_cache *cache, 
 	list_for_each_safe(l, ltmp, &mb_cache_lru_list) {
 		struct mb_cache_entry *ce =
 			list_entry(l, struct mb_cache_entry, e_lru_list);
-		if (ce->e_bdev == bdev) {
+		if (ce->e_cache == cache && ce->e_bdev == bdev) {
 			list_move_tail(&ce->e_lru_list, &free_list);
 			__mb_cache_entry_unhash(ce);
 		}


