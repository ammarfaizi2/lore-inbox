Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261962AbTCYL0X>; Tue, 25 Mar 2003 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTCYL0X>; Tue, 25 Mar 2003 06:26:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16790 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261937AbTCYL0T>;
	Tue, 25 Mar 2003 06:26:19 -0500
Date: Tue, 25 Mar 2003 12:37:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: dougg@torque.net, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Message-ID: <20030325113724.GU2371@suse.de>
References: <200303211056.04060.pbadari@us.ibm.com> <3E7C4251.4010406@torque.net> <20030322030419.1451f00b.akpm@digeo.com> <3E7C4D05.2030500@torque.net> <20030322040550.0b8baeec.akpm@digeo.com> <20030325105629.GS2371@suse.de> <20030325112307.GT2371@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325112307.GT2371@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25 2003, Jens Axboe wrote:
> On Tue, Mar 25 2003, Jens Axboe wrote:
> > Here's a patch that makes the request allocation (and io scheduler
> > private data) dynamic, with upper and lower bounds of 4 and 256
> > respectively. The numbers are a bit random - the 4 will allow us to make
> > progress, but it might be a smidgen too low. Perhaps 8 would be good.
> > 256 is twice as much as before, but that should be alright as long as
> > the io scheduler copes. BLKDEV_MAX_RQ and BLKDEV_MIN_RQ control these
> > two variables.
> > 
> > We loose the old batching functionality, for now. I can resurrect that
> > if needed. It's a rough fit with the mempool, it doesn't _quite_ fit our
> > needs here. I'll probably end up doing a specialised block pool scheme
> > for this.
> > 
> > Hasn't been tested all that much, it boots though :-)
> 
> Here's a version with better lock handling. We drop the queue_lock for
> most parts of __make_request(), except the actual io scheduler calls.

That was buggy, fixing... Back later.

-- 
Jens Axboe

