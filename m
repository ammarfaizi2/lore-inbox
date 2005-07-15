Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263296AbVGONsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbVGONsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGONsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:48:53 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:8950 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S263296AbVGONrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:47:53 -0400
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200507151249.52294.agruen@suse.de>
References: <1121346444.4282.8.camel@localhost.localdomain>
	 <200507151249.52294.agruen@suse.de>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 22:41:34 +0900
Message-Id: <1121434894.1261.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > --- 2.6-rc/fs/mbcache.c.orig	2005-07-14 20:40:34.000000000 +0900
> > +++ 2.6-rc/fs/mbcache.c	2005-07-14 20:43:42.000000000 +0900
> > @@ -329,7 +329,7 @@ mb_cache_shrink(struct mb_cache *cache,
> >  	list_for_each_safe(l, ltmp, &mb_cache_lru_list) {
> >  		struct mb_cache_entry *ce =
> >  			list_entry(l, struct mb_cache_entry, e_lru_list);
> > -		if (ce->e_bdev == bdev) {
> > +		if (ce->e_cache == cache && ce->e_bdev == bdev) {
> >  			list_move_tail(&ce->e_lru_list, &free_list);
> >  			__mb_cache_entry_unhash(ce);
> >  		}
> 
> this patch looks bogus to me. How could the cache contain entries for the same 
> block_device from different file systems? The block_device is sufficient to 
> identify the file system, and hence its cache entries.

Why is mb_cache_shrink() declared as:

void
mb_cache_shrink(struct mb_cache *cache, struct block_device *bdev);

The variable cache was never used.


