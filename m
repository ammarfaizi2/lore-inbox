Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSKZTsx>; Tue, 26 Nov 2002 14:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbSKZTsx>; Tue, 26 Nov 2002 14:48:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:11153 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266731AbSKZTsv>;
	Tue, 26 Nov 2002 14:48:51 -0500
Message-ID: <3DE3D1D1.BE5B30ED@digeo.com>
Date: Tue, 26 Nov 2002 11:56:01 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Srihari Vijayaraghavan <harisri@bigpond.com>, Jens Axboe <axboe@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
References: <200211262203.20088.harisri@bigpond.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2002 19:56:02.0333 (UTC) FILETIME=[D8FB44D0:01C29585]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan wrote:
> 
> [1.] One line summary of the problem:
> kernel BUG at drivers/block/ll_rw_blk.c:1950!

That's BIO_BUG_ON(!bio->bi_size);

> Software RAID 0.

Yes, there have been a few reports of this.  The pagecache code
does bio_add_page() against a new BIO and it doesn't work.  We
end up submitting an empty BIO and boom.

I've seen various RAID patches floating about which address this,
but either they weren't merged or they didn't work right.

Jens, what is the policy here?  Should bio_add_page() for an
empty bio "always succeed"?  (Bearing in mind that pages can
be 64k...).    I guess -EIO would be better than a BUG.

Are there more RAID fixes pending?

Thanks.
