Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVGPBoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVGPBoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 21:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVGPBoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 21:44:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:1483 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262043AbVGPBnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 21:43:40 -0400
From: Andreas Gruenbacher <agruen@suse.de>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
Date: Sat, 16 Jul 2005 03:44:05 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <1121346444.4282.8.camel@localhost.localdomain> <200507151636.27532.agruen@suse.de> <1121440067.4137.2.camel@localhost.localdomain>
In-Reply-To: <1121440067.4137.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507160344.06235.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 July 2005 17:07, Akinobu Mita wrote:
> 2005-07-15 (Fri) 16:36 +0200  Andreas Gruenbacher wrote:
> > The cache parameter could indeed be removed. Not that it would matter
> > much...
>
> Currently, mbcache is used only for xattr on ext2/ext3 and reiserfs.
> In other words, only one type of mbcache is used per-filesystem.
> So any problems don't happen without the patch I sent.

Actually, reiserfs doesn't use the mbcache, so this can go:

Index: linux-2.6.12/fs/reiserfs/xattr.c
===================================================================
--- linux-2.6.12.orig/fs/reiserfs/xattr.c
+++ linux-2.6.12/fs/reiserfs/xattr.c
@@ -41,3 +41,2 @@
 #include <linux/reiserfs_acl.h>
-#include <linux/mbcache.h>
 #include <asm/uaccess.h>

> But, for example when someone use mbcache as another purpose on ext3,
> The crash will be caused by using mb_cache_shrink().
>
> Therefore, I think your patch should not be committed until
> mbcache will be limited to use only type per-filesystem.

Removing the cache parameter from mb_cache_shrink would break when more than 
one mb_cache is used per filesystem, correct. Leaving the parameter in and 
adding your patch is more "future proof", so I'm fine with it. Are you 
actually using more than one mb_cache, or is this theoretical?

As you say in your follow-up mail, without your patch the cache would become 
less effective, it won't crash anything, though.

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
