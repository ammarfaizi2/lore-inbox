Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRCCTvK>; Sat, 3 Mar 2001 14:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRCCTvA>; Sat, 3 Mar 2001 14:51:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47122 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129723AbRCCTuw>;
	Sat, 3 Mar 2001 14:50:52 -0500
Date: Sat, 3 Mar 2001 20:50:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: agrawal@ais.org, linux-kernel@vger.kernel.org
Subject: Re: lingering loopback bugs?
Message-ID: <20010303205036.N2528@suse.de>
In-Reply-To: <20010303202458.L2528@suse.de> <Pine.GSO.4.21.0103031438520.19484-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0103031438520.19484-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Mar 03, 2001 at 02:41:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03 2001, Alexander Viro wrote:
> > Look for the patch I posted yesterday (hint: just remove these two
> > lines from loop_end_io_transfer)
> > 
> >                if (atomic_dec_and_test(&lo->lo_pending))
> >                        up(&lo->lo_bh_mutex);
> 
> Uhh... And what will compensate for atomic_inc() in loop_make_request() in
> case of loop over block device?

There is no atomic_inc() in loop_make_request, I moved it to
count pending bh on the queue only. But hmm, we should not
be able to remove it while it has bhs in flight. Ok, I'll
rearrange this a bit again...

-- 
Jens Axboe

