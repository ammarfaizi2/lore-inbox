Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbULBTwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbULBTwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbULBTwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:52:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2436 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261740AbULBTwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:52:43 -0500
Date: Thu, 2 Dec 2004 20:52:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041202195232.GA26695@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202114836.6b2e8d3f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > as:
> > Reader: 27985KiB/sec (max_lat=34msec)
> > Writer:    64KiB/sec (max_lat=1042msec)
> > 
> > cfq:
> > Reader: 12703KiB/sec (max_lat=108msec)
> > Writer:  9743KiB/sec (max_lat=89msec)
> > 
> > If you look at vmstat while running these tests, cfq and deadline give
> > equal bandwidth for the reader and writer all the time, while as
> > basically doesn't give anything to the writer (a single block per second
> > only). Nick, is the write batching broken or something?
> 
> Looks like it.  We used to do 2/3rds-read, 1/3rd-write in that testcase.

But 'as' has had no real changes in about 9 months time, it's really
strange. Twiddling with write expire and write batch expire settings
make no real difference. Upping the ante to 4 clients, two readers and
two writers work about the same: 27MiB/sec aggregate read bandwidth,
~100KiB/sec write.

At least something needs to be done about it. I don't know what kernel
this is a regression against, but at least it means that current 2.6
with its default io scheduler has basically zero write performance in
presence of reads.

-- 
Jens Axboe

