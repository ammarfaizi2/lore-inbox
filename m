Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRDXJOa>; Tue, 24 Apr 2001 05:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbRDXJOU>; Tue, 24 Apr 2001 05:14:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8201 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132909AbRDXJOK>;
	Tue, 24 Apr 2001 05:14:10 -0400
Date: Tue, 24 Apr 2001 11:14:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: read perf improved by mounting ext2?
Message-ID: <20010424111402.E9357@suse.de>
In-Reply-To: <20010424013150.A6892@garloff.etpnet.phys.tue.nl> <20010424105858.C9357@suse.de> <20010424110532.E12624@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010424110532.E12624@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Tue, Apr 24, 2001 at 11:05:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24 2001, Kurt Garloff wrote:
> > You wouldn't happen to have 4kB ext2 filesystems on those?
> 
> Sure I do.
> 
> > When ext2 mounts, it sets the soft blocksize to that then, I would expect
> > this to give at least some benefit over using 1kB blocks (as your IDE
> > partition otherwise would have).
> 
> Why? Are the request sizes larger this way? This would mean that the
> overhead is very significant, turning a max of 26MB/s into 16MB/s!

Because you'll be doing I/O on 4kB entries at least, and the overhead of
merging a 128kB request into the queue is much smaller this way. But
yes, 16 -> 26 seems quite a large win, I wouldn't expect this much
(unless you get no merging in any of the cases, then I suspect the 4kB
would be an even bigger win)

> If so, shouldn't we try to get the same effect also for the whole disk or
> other filesystems? Most notably reiser?

I would expect reiser to do the same. Setting the soft block size higher
is not required though, users are free to submit 4kB buffer heads even
for devices that have 1kB set. By default, it doesn't happen though.

-- 
Jens Axboe

