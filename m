Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283573AbRK3JCo>; Fri, 30 Nov 2001 04:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283572AbRK3JCf>; Fri, 30 Nov 2001 04:02:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38149 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283575AbRK3JCQ>;
	Fri, 30 Nov 2001 04:02:16 -0500
Date: Fri, 30 Nov 2001 10:01:53 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin A. Brooks" <martin@jtrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre4 compile error - pd.c
Message-ID: <20011130100153.S16796@suse.de>
In-Reply-To: <20011130092347.L16796@suse.de> <4199.10.119.8.1.1007110697.squirrel@extranet.jtrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4199.10.119.8.1.1007110697.squirrel@extranet.jtrix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Martin A. Brooks wrote:
> 
> > Please try this diff.
> 
> That seems to fix that error, but I now get a (possibly related) error
> elsewhere.
> 
> 
> gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686    -c -o xd.o xd.c
> xd.c: In function `xd_geninit':
> xd.c:250: `max_sectors' undeclared (first use in this function)
> xd.c:250: (Each undeclared identifier is reported only once
> xd.c:250: for each function it appears in.)
> make[3]: *** [xd.o] Error 1

max_sectors has been moved into the queue. So when you did this before

max_sectors[dev indexing] = max_sectors_in_request

you now do

q = blk_get_queue(dev);
blk_queue_max_sectors(max_sectors_in_request);

-- 
Jens Axboe

