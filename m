Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755959AbWKWJUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbWKWJUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757286AbWKWJUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:20:06 -0500
Received: from brick.kernel.dk ([62.242.22.158]:30532 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1755959AbWKWJUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:20:04 -0500
Date: Thu, 23 Nov 2006 10:19:57 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Milan Broz <mbroz@redhat.com>,
       Heinz Mauelshagen <hjm@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: [PATCH 01/11] dm io: fix bi_max_vecs
Message-ID: <20061123091957.GM4999@kernel.dk>
References: <20061122185936.GR6993@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122185936.GR6993@agk.surrey.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22 2006, Alasdair G Kergon wrote:
> From: Heinz Mauelshagen <hjm@redhat.com>
> 
> The existing code allocates an extra slot in bi_io_vec[] and uses it to
> store the region number.
> 
> This patch hides the extra slot from bio_add_page() so the region number
> can't get overwritten.
> 
> Also remove a hard-coded SECTOR_SHIFT and fix a typo in a comment.
>
> Index: linux-2.6.19-rc6/drivers/md/dm-io.c
> ===================================================================
> --- linux-2.6.19-rc6.orig/drivers/md/dm-io.c	2006-11-22 17:26:47.000000000 +0000
> +++ linux-2.6.19-rc6/drivers/md/dm-io.c	2006-11-22 17:26:53.000000000 +0000
> @@ -92,12 +92,12 @@ void dm_io_put(unsigned int num_pages)
>   *---------------------------------------------------------------*/
>  static inline void bio_set_region(struct bio *bio, unsigned region)
>  {
> -	bio->bi_io_vec[bio->bi_max_vecs - 1].bv_len = region;
> +	bio->bi_io_vec[bio->bi_max_vecs].bv_len = region;
>  }
>  

Ehm eww, that is really ugly code imo.

-- 
Jens Axboe

