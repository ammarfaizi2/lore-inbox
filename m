Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWEVHBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWEVHBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWEVHBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:01:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57117 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932528AbWEVHBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:01:35 -0400
Date: Mon, 22 May 2006 09:02:50 +0200
From: Jens Axboe <axboe@suse.de>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, Don Dupuis <dondster@gmail.com>
Subject: Re: [PATCH 002 of 2] md: Make sure bi_max_vecs is set properly in bio_split
Message-ID: <20060522070249.GC4216@suse.de>
References: <20060522161259.2792.patches@notabene> <1060522061855.2861@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060522061855.2861@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2006, NeilBrown wrote:
> 
> Else a subsequence bio_clone might make a mess.
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> Cc: "Don Dupuis" <dondster@gmail.com>
> Cc: Jens Axboe <axboe@suse.de>
> ### Diffstat output
>  ./fs/bio.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff ./fs/bio.c~current~ ./fs/bio.c
> --- ./fs/bio.c~current~	2006-05-22 16:12:46.000000000 +1000
> +++ ./fs/bio.c	2006-05-22 16:12:16.000000000 +1000
> @@ -1103,6 +1103,9 @@ struct bio_pair *bio_split(struct bio *b
>  	bp->bio1.bi_io_vec = &bp->bv1;
>  	bp->bio2.bi_io_vec = &bp->bv2;
>  
> +	bp->bio1.bi_max_vecs = 1;
> +	bp->bio2.bi_max_vecs = 1;
> +
>  	bp->bio1.bi_end_io = bio_pair_end_1;
>  	bp->bio2.bi_end_io = bio_pair_end_2;
>  

Obviously correct, thanks Neil.

-- 
Jens Axboe

