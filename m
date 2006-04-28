Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWD1JVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWD1JVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1JVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:21:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965195AbWD1JVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:21:16 -0400
Date: Fri, 28 Apr 2006 11:21:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060428092150.GE23137@suse.de>
References: <20060426135310.GB5083@suse.de> <20060428091006.GA12001@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428091006.GA12001@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28 2006, Pavel Machek wrote:
> On St 26-04-06 15:53:10, Jens Axboe wrote:
> > Hi,
> > 
> > Running a splice benchmark on a 4-way IPF box, I decided to give the
> > lockless page cache patches from Nick a spin. I've attached the results
> > as a png, it pretty much speaks for itself.
> > 
> > The test in question splices a 1GiB file to a pipe and then splices that
> > to some output. Normally that output would be something interesting, in
> > this case it's simply /dev/null. So it tests the input side of things
> > only, which is what I wanted to do here. To get adequate runtime, the
> > operation is repeated a number of times (120 in this example). The
> > benchmark does that number of loops with 1, 2, 3, and 4 clients each
> > pinned to a private CPU. The pinning is mainly done for more stable
> > results.
> 
> 35GB/sec, AFAICS? Not sure how significant this benchmark is.. even
> with 4 clients, you have 2.5GB/sec, and that is better than almost
> anything you can splice to...

2.5GB/sec isn't that much, and remember that is with the system fully
loaded and spending _all_ its time in the kernel. It's the pure page
cache lookup performance, I'd like to think you should have room for
more. With hundreds or even thousands of clients.

The point isn't the numbers themselves, rather the scalability of the
vanilla page cache vs the lockless one. And that is demonstrated aptly.

-- 
Jens Axboe

