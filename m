Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWIFKyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIFKyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIFKyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:54:39 -0400
Received: from brick.kernel.dk ([62.242.22.158]:2084 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750702AbWIFKyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:54:38 -0400
Date: Wed, 6 Sep 2006 12:57:56 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Damon LaCrosse <arid@inbox.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 odd hd slow down
Message-ID: <20060906105755.GZ14565@kernel.dk>
References: <87r6ypuy3v.fsf@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r6ypuy3v.fsf@inbox.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06 2006, Damon LaCrosse wrote:
> 
> Hi all,
> experimenting a little the 2.6 block device layer I detected under
> some circumstances a net slowness in the disk throughput. Strangely
> enough, in fact, my IDE disk reported a significant performance drop
> off in correspondence of certain access patterns.
> 
> Following further investigations I was able to simulate this ill
> behavior in the following piece of code, clearly showing a non
> negligible hard-disk slow down when the step value is set greater than
> 8. These result in fact far below the hard-disk real speed
> (30~70MB/sec), as correctly measured instead in correspondence of low
> STEP values (<8). In particular, with step of 512 or above, the
> overall performance scored by the disk results below 2MB/sec.

You are effectively approaching seeky writes, I bet it's just the drive
firmware biting you. Repeat the test on a different drive, and see if
you see an identical pattern.

> At first I thought to a side-effect of the queue plug/unplug
> mechanism: the scattered accesses involve the unplug timeout to each
> bio. So, I added the BIO_RW_SYNC flag that - AFAIK - should force the
> queue unplugging. Unfortunately nothing changes.
> 
> Now, as it is quite possible that I'm missing something, the question
> is: is there an effective way of doing scattered disk accesses using
> bios? In other words, how can I fix the following program in order to
> get disk full speed for steps > 8?

I don't think the io path has anything to do with this. Why are you
expecting non-sequential writes to continue to be fast? They wont be.

-- 
Jens Axboe

