Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSJOQBT>; Tue, 15 Oct 2002 12:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSJOQBT>; Tue, 15 Oct 2002 12:01:19 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:60155 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262648AbSJOQBS>; Tue, 15 Oct 2002 12:01:18 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 15 Oct 2002 10:04:17 -0600
To: Christoph Hellwig <hch@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015160417.GE15552@clusterfs.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org> <20021015163121.B27906@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015163121.B27906@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2002  16:31 +0100, Christoph Hellwig wrote:
> Patch 2: mbcache (all against 2.5.42-mm3):
> 
> --- linux-2.5.42-mm3-plain/fs/mbcache.c	Tue Oct 15 17:05:09 2002
> +++ linux-2.5.42-mm3/fs/mbcache.c	Tue Oct 15 17:26:53 2002
> @@ -247,20 +228,20 @@
>  	}
>  	while (nr_to_scan && !list_empty(&mb_cache_lru_list)) {
>  		struct mb_cache_entry *ce =
>  			list_entry(mb_cache_lru_list.prev,
>  				   struct mb_cache_entry, e_lru_list);
> @@ -382,20 +361,19 @@
>  	LIST_HEAD(free_list);
>  	struct list_head *l;
>  
> -	mb_cache_lock();
> +	spin_lock(&mb_cache_spinlock);
>  	l = mb_cache_lru_list.prev;
>  	while (l != &mb_cache_lru_list) {
>  		struct mb_cache_entry *ce =
>  			list_entry(l, struct mb_cache_entry, e_lru_list);
> @@ -420,15 +398,14 @@
>  	struct list_head *l;
>  	int n;
>  
> -	mb_cache_lock();
> +	spin_lock(&mb_cache_spinlock);
>  	l = mb_cache_lru_list.prev;
>  	while (l != &mb_cache_lru_list) {
>  		struct mb_cache_entry *ce =
>  			list_entry(l, struct mb_cache_entry, e_lru_list);

Couldn't these all be "list_for_each{_safe}"?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

