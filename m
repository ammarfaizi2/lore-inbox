Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSAGHta>; Mon, 7 Jan 2002 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289006AbSAGHtU>; Mon, 7 Jan 2002 02:49:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19474 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289020AbSAGHtJ>;
	Mon, 7 Jan 2002 02:49:09 -0500
Date: Mon, 7 Jan 2002 08:48:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More loop/BIO breakage (ll_rw_blk.c:1359)
Message-ID: <20020107084835.E1755@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201070828180.18265-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201070828180.18265-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07 2002, Zwane Mwaikambo wrote:
> Hi Jens,
> 	Oops reproducible by doing a "mount /dev/fd0 /floppy -o loop".
> Decoded oops at the end.
> 
> loop.c
> static inline void loop_handle_bio(struct loop_device *lo, struct bio
> *bio)
> {
> 	<snip>
> 	} else {
> 		struct bio *rbh = bio->bi_private;
> 
> 		ret = do_bio_blockbacked(lo, bio, rbh);
> 		bio_endio(rbh, !ret, bio_sectors(bio)); <== [1]
> 		loop_put_buffer(bio);
> 	}
> }

Ah excellent, nice work. Applied.

-- 
Jens Axboe

