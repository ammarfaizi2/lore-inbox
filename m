Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGQAVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGQAVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 20:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGQAVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 20:21:14 -0400
Received: from [216.208.38.107] ([216.208.38.107]:24710 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S1751191AbWGQAVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 20:21:13 -0400
Date: Mon, 17 Jul 2006 02:20:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Jonathan Baccash <jbaccash@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: raid io requests not parallel?
Message-ID: <20060717002007.GA5032@suse.de>
References: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com> <17594.53980.497790.409035@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17594.53980.497790.409035@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17 2006, Neil Brown wrote:
> On Saturday July 15, jbaccash@gmail.com wrote:
> > I'm using kernel linux-2.6.15-gentoo-r1, and I noticed performance of
> > the software RAID-1 is not as good as I would have expected on my two
> > SATA drives, and I was wondering if anyone has an idea what may be
> > happening. The test I run is 1024 16k direct-IO reads/writes from
> > random locations within a 1GB file (on a RAID-1 partition), with my
> > disk caches set to
> > write-through mode. In the MT (multi-threaded) case, I issue them from
> > 8 threads (so it's 128 requests per thread):
> > 
> > Random read: 10.295 sec
> > Random write: 19.142 sec
> 
> Odd.  I would expect these two numbers to be a lot closer together.
> 
> Try changing the IO scheduler on the drives and see if it makes a
> difference.
> e.g.
>   cat /sys/block/XXX/queue/scheduler
>   echo cfq > /sys/block/XXX/queue/scheduler
>   echo deadline > /sys/block/XXX/queue/scheduler
> 
> See what works best.

His cache is set to write through, 16kb direct writes in that case will
be a lot slower than the equivalent reads. 10 vs 20 seconds does not
sounds out of the question.

-- 
Jens Axboe

