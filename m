Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHFOGf>; Tue, 6 Aug 2002 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319088AbSHFOGf>; Tue, 6 Aug 2002 10:06:35 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:4539 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S314396AbSHFOGd>; Tue, 6 Aug 2002 10:06:33 -0400
Subject: Re: Linux v2.4.19-rc5
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D4F50F7.2DE00276@zip.com.au>
References: <1028232945.3147.99.camel@spc9.esa.lanl.gov>
	<Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com> 
	<3D4F50F7.2DE00276@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Aug 2002 08:07:17 -0600
Message-Id: <1028642837.2802.59.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 22:30, Andrew Morton wrote:
[snipped]
> 
> IO in 2.5 is much more CPU efficient that in 2.4, and straight-line
> bandwidth is better as well.
> 
> The scheduling of that IO has a few problems, so in wildly seeky loads
> like dbench the kernel still falls over its own feet a bit.  The
> two main culprits here are the lock_buffer() in block_write_full_page()
> against the blockdev mapping, and the writeback of dirty pages from the
> tail of the LRU in page reclaim.
> 
> And no, the eventual dbench numbers will not be a measure of the success
> of the tuning which will happen on the run in to 2.6.  Dbench throughput
> may well be lower, because we probably should be starting writeback
> at lower dirty thresholds.
> 
> If you want good dbench numbers:
> 
> echo 70 > /proc/sys/vm/dirty_background_ratio
> echo 75 > /proc/sys/vm/dirty_async_ratio
> echo 80 > /proc/sys/vm/dirty_sync_ratio
> echo 30000 > /proc/sys/vm/dirty_expire_centisecs

That last one looks like the biggest cheat.  Rather than optimizing for
dbench, is there a set of pessimizing numbers which would optimally turn
dbench into a semi-useful tool for measuring meaningful IO performance? 
Or is dbench really only useful for stress testing?

Thanks for the explanations.

Steven

