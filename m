Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUJ1QD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUJ1QD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUJ1QC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:02:57 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:60945 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261746AbUJ1P7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:59:38 -0400
To: Nigel Kukard <nkukard@lbsd.net>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net> <873bzzw60c.fsf@devron.myhome.or.jp>
	<200410280714.40033.gene.heskett@verizon.net>
	<200410280812.41150.gene.heskett@verizon.net>
	<87oeingerg.fsf@devron.myhome.or.jp> <41810F3F.6070809@lbsd.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 29 Oct 2004 00:58:21 +0900
In-Reply-To: <41810F3F.6070809@lbsd.net> (Nigel Kukard's message of "Thu, 28
 Oct 2004 15:24:47 +0000")
Message-ID: <877jpa6dia.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> writes:

> could you shoot me the patch when you done plz  :-)

The patch is following. I'm going to do my usual stress test for one
or two days.

Please CC to me if you found the problem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] FAT: remove wrong BUG_ON()

This is valid state if file was accessed by multiple processes at the
same time.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN fs/fat/cache.c~fat-cache-bug_on-fix fs/fat/cache.c
--- linux-2.6.10-rc1/fs/fat/cache.c~fat-cache-bug_on-fix	2004-10-28 01:52:38.000000000 +0900
+++ linux-2.6.10-rc1-hirofumi/fs/fat/cache.c	2004-10-28 01:52:45.000000000 +0900
@@ -147,7 +147,6 @@ static void fat_cache_add(struct inode *
 		goto out;	/* this cache was invalidated */
 
 	cache = fat_cache_merge(inode, new);
-	BUG_ON(new->id == FAT_CACHE_VALID && cache != NULL);
 	if (cache == NULL) {
 		if (MSDOS_I(inode)->nr_caches < fat_max_cache(inode)) {
 			MSDOS_I(inode)->nr_caches++;
_
