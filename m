Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262211AbSIZGyp>; Thu, 26 Sep 2002 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSIZGyp>; Thu, 26 Sep 2002 02:54:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262211AbSIZGyo>;
	Thu, 26 Sep 2002 02:54:44 -0400
Date: Thu, 26 Sep 2002 08:59:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926065951.GD12862@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926064455.GC12862@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26 2002, Jens Axboe wrote:
> > Now alter fifo_batch, everything else default:
> > 
> > 	fifo_batch (units)	time cat kernel/*.c (secs)
> > 		64			5.0
> > 		32			2.0
> > 		16			0.2
> > 		 8			0.17
> > 
> > OK, that's a winner.
> 
> Cool, I'm resting benchmarks with 16 as the default now. I fear this
> might be too agressive, and that 32 will be a decent value.

fifo_batch=16 drops throughput slightly on tiobench, however it also
gives really really good interactive behaviour here. Using 32 doesn't
change that a whole lot, the throughput that is. This might just be
normal deviation between runs, more are needed to be sure.  Note that
I'm testing with the last_sec patch I posted, you should too.

BTW, for SCSI, it would be nice to first convert more drivers to use the
block level queued tagging. That would provide us with a much better
means to control starvation properly on SCSI as well.

-- 
Jens Axboe

