Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282934AbSACISu>; Thu, 3 Jan 2002 03:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282945AbSACISl>; Thu, 3 Jan 2002 03:18:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44295 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282934AbSACIS0>;
	Thu, 3 Jan 2002 03:18:26 -0500
Date: Thu, 3 Jan 2002 09:18:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel BUG at scsi_merge.c:83
Message-ID: <20020103091818.C482@suse.de>
In-Reply-To: <3C33DDED.7212F2F9@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33DDED.7212F2F9@torque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02 2002, Douglas Gilbert wrote:
> Peter Osterlund <petero2@telia.com> wrote:
> 
> > Jens Axboe <axboe@suse.de> writes:
> > 
> > > On Wed, Jan 02 2002, Peter Osterlund wrote:
> > > > Hi!
> > > > 
> > > > While doing some stress testing on the 2.5.2-pre5 kernel, I am hitting
> > > > a kernel BUG at scsi_merge.c:83, followed by a kernel panic. The
> > > > problem is that scsi_alloc_sgtable fails because the request contains
> > > > too many physical segments. I think this patch is the correct fix:
> > > 
> > > Correct, ll_rw_blk default is ok now. I missed this when killing
> > > scsi_malloc/scsi_dma, thanks.
> > 
> > It turns out this is still not enough to fix the problem for me,
> > because ll_new_hw_segment is still allowing nr_phys_segments to become
> > too large. Is the following patch the correct way to deal with this
> > problem, or is that case supposed to be prevented by some other means?
> > At least, this patch prevents the kernel panic during my stress test.
> 
> <snipped patches/>
> 
> Peter,
> I was able to get a repeatable oops at that line copying
> files from /boot onto a "fake" scsi_debug disk with "pre5".
> The first largish file it attempted to copy caused the
> oops (which I sent to Jens).
> 
> Anyway, I just applied your 2 patches (to scsi.c and ll_rw_blk.c)
> and the oops is no more.

I've included a slightly modified version, your logic was correct though
Peter. Thanks.

-- 
Jens Axboe

