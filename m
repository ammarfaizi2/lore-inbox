Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbRKOSTX>; Thu, 15 Nov 2001 13:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKOSSj>; Thu, 15 Nov 2001 13:18:39 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29151 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280971AbRKOSSa>; Thu, 15 Nov 2001 13:18:30 -0500
Date: Thu, 15 Nov 2001 10:15:43 -0800
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: lahr@eng2.beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] SCSI io_request_lock patch
Message-ID: <20011115101543.R26302@us.ibm.com>
In-Reply-To: <20011112130902.B26302@us.ibm.com> <20011113092311.L786@suse.de> <20011113104210.L26302@us.ibm.com> <20011114091129.H17933@suse.de> <20011114105433.O26302@us.ibm.com> <20011115112300.S27010@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115112300.S27010@suse.de>; from axboe@suse.de on Thu, Nov 15, 2001 at 11:23:00AM +0100
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Wed, Nov 14 2001, Jonathan Lahr wrote:
> > > It's absolutely worthless. Look, it ties in with the points I made
> > > below. You are exporting the merge functions for instance, and setting
> > > them in the queue. This will cause scsi_merge not to use it's own
> > > functions, broken.
> > 
> > As in the baseline, initialize_merge_fn overwrites these pointers:
> >      q->back_merge_fn = scsi_back_merge_fn_;
> >      q->front_merge_fn = scsi_front_merge_fn_;
> >      q->merge_requests_fn = scsi_merge_requests_fn_;
> 
> I had forgotten I had #if 0 out the check for already set back_merge etc
> in scsi_merge -- however that's still beside the point. _Why_ are you
> exporting the ll_rw_blk functions and setting them just to have them
> overridden? Makes no sense.
...
> Don't export the merge functions ever, define your own if you really
> need them. You don't, though.

That resulted merely from basing scsi_init_queue on blk_init_queue.
I'll simplify the code by removing these unnecessary assignments.

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

