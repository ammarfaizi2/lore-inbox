Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUJaS51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUJaS51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUJaS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:57:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:2063 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261545AbUJaS5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:57:23 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: remove wrong BUG_ON()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 01 Nov 2004 03:25:44 +0900
Message-ID: <87y8hmbv87.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please apply
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


This is valid state if file was accessed by multiple processes at the
same time.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN fs/fat/cache.c~fat-cache-bug_on-fix fs/fat/cache.c
--- linux-2.6.10-rc1/fs/fat/cache.c~fat-cache-bug_on-fix	2004-10-31 08:14:49.000000000 +0900
+++ linux-2.6.10-rc1-hirofumi/fs/fat/cache.c	2004-10-31 08:14:49.000000000 +0900
@@ -147,7 +147,6 @@ static void fat_cache_add(struct inode *
 		goto out;	/* this cache was invalidated */
 
 	cache = fat_cache_merge(inode, new);
-	BUG_ON(new->id == FAT_CACHE_VALID && cache != NULL);
 	if (cache == NULL) {
 		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
 			MSDOS_I(inode)->nr_caches++;
_
