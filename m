Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285886AbRLHJG6>; Sat, 8 Dec 2001 04:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285939AbRLHJGs>; Sat, 8 Dec 2001 04:06:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3086 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285886AbRLHJGd>;
	Sat, 8 Dec 2001 04:06:33 -0500
Date: Sat, 8 Dec 2001 10:06:24 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, pat@it.com.au, tfries@umr.edu,
        ankry@mif.pg.gda.pl, torvalds@transmeta.com
Subject: Re: Patch?: linux-2.5.1-pre7/drivers/block/xd.c compilation fixes
Message-ID: <20011208090624.GJ32569@suse.de>
In-Reply-To: <20011207220808.A6037@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207220808.A6037@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Adam J. Richter wrote:
> 	I do not know the whole new block IO interface, but here
> is my attempt at making linux-2.4.17-pre7/drivers/block/xd.c compile.
> If I got any of this wrong, I would appreciate someone telling me,
> because I may start tring to fix some of the other 90+ drivers that
> do not compile in 2.4.1-pre7 later this weekend.

That would be great! The fix looks good -- what you want to add in
addition is checking that this is a rw request. So before your switch,
do something ala

	/*
	 * we don't support special requests
	 */
	if (!(CURRENT->flags & REQ_CMD)) {
		blkdev_dequeue_request(CURRENT);
		end_that_request_first(CURRENT, 0, CURRENT->nr_sectors);
		end_that_request_last(CURRENT);
		continue;
	}

-- 
Jens Axboe

