Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWG2Knn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWG2Knn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWG2Knm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:43:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1422731AbWG2Knm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:43:42 -0400
Date: Sat, 29 Jul 2006 12:42:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accuracy of disk statistics IO counter
Message-ID: <20060729104232.GD13095@suse.de>
References: <44CA3523.9020000@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CA3523.9020000@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28 2006, Mark Seger wrote:
> Awhile back I had suggested moving the place in the block driver logic 
> where stats get updated to more accurately reflect what was happening at 
> the time they were actually sent to the drivers and I believe they were 
> indeed made in the 2.6.15 timeframe.  I've recently started taking 
> closer look at the numbers and while the sector counts look correct I'm 
> not sure I'd agree with the number of I/Os being reported and believe 
> they can be off by maybe 15% or more.
> 
> Specifically, I wrote a 1GB file with a blocksize of 1MB, which would 
> result in 1000 writes at the application level.  What I believe then 
> happens is that each write turns into 8 128KB requests to the driver, 
> which should result in 8000 actual writes.  Toss in metadata operations 
> and who knows what else and the actual number should be a little 
> higher.  What I've see after repeating the tests a number of times on 
> 2.6.16-27 is numbers ranging from 6800-7000 writes which feels like a 
> big enough difference to at least point out.

Install http://brick.kernel.dk/snaps/blktrace-git-20060723022503.tar.gz
and blktrace your disk for the duration of the test and compare the io
numbers. Requires 2.6.17 or later, though.

-- 
Jens Axboe

