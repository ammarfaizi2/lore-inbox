Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbREBKpn>; Wed, 2 May 2001 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbREBKpe>; Wed, 2 May 2001 06:45:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132547AbREBKpU>;
	Wed, 2 May 2001 06:45:20 -0400
Date: Wed, 2 May 2001 12:44:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Shaun <delius@progsoc.uts.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk Performance Measurements
Message-ID: <20010502124445.J25336@suse.de>
In-Reply-To: <Pine.LNX.4.21.0105021528170.10591-100000@ftoomsh.progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105021528170.10591-100000@ftoomsh.progsoc.uts.edu.au>; from delius@progsoc.uts.edu.au on Wed, May 02, 2001 at 04:31:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02 2001, Shaun wrote:
> In regards to diskr/wblk, drive_stat_acct() increments the number of
> sectors/blocks read based n the values in the request being processed by
> add_request(). But add_request() is only called for requests that can't be
> merged with requests currently on the queue. Thus the counters can't be
> updated for sectors that are read by being added to aqueued
> request. Unless I'm mistaken this makes the diskr/wblk mostly useless.

Look again, drive_stat_acct is also called for list merges (just with 0
set for new i/o of course).


> record the _kilobytes_ read or written to the disks. His code adds
> drive_pg_stat_acct(). This routine increments disk_pgin/out once for each
> call to make_request(). Presumably he has assumed every call to
> make_request will always be for 2 sectors/1 Kilobytes worth of
> data. However I added printk() statements to try to verify this and found
> that the request to the block device need not be 1024 bytes, I frequently
> saw 4096 requests. In fact, the "correct_size" for the block device
> appeared to be changeable from partition to partition on the same
> disk. This "correct_size" appears to be related to the block size for the
> filesystem on the partition/disk? Following from the above logic it would
> appear that the pgin/pgout statistics are also useless since you don't
> know how large the requests were?

The size of requests will typically vary with the block size set by
ext2. So if you have 1kB block size on your fs, that partition will
receive 1kB buffers. Similar for 4kB. The stats collected in the kernel
are sector based, units of 512 bytes. The proc printed value should be
in kB however for pgpin/out and 512b sectors for rio/rblk wio/wblk.

-- 
Jens Axboe

