Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288197AbSACE0W>; Wed, 2 Jan 2002 23:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288200AbSACE0M>; Wed, 2 Jan 2002 23:26:12 -0500
Received: from gear.torque.net ([204.138.244.1]:51720 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S288197AbSACE0C>;
	Wed, 2 Jan 2002 23:26:02 -0500
Message-ID: <3C33DDED.7212F2F9@torque.net>
Date: Wed, 02 Jan 2002 23:28:29 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] kernel BUG at scsi_merge.c:83
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:

> Jens Axboe <axboe@suse.de> writes:
> 
> > On Wed, Jan 02 2002, Peter Osterlund wrote:
> > > Hi!
> > > 
> > > While doing some stress testing on the 2.5.2-pre5 kernel, I am hitting
> > > a kernel BUG at scsi_merge.c:83, followed by a kernel panic. The
> > > problem is that scsi_alloc_sgtable fails because the request contains
> > > too many physical segments. I think this patch is the correct fix:
> > 
> > Correct, ll_rw_blk default is ok now. I missed this when killing
> > scsi_malloc/scsi_dma, thanks.
> 
> It turns out this is still not enough to fix the problem for me,
> because ll_new_hw_segment is still allowing nr_phys_segments to become
> too large. Is the following patch the correct way to deal with this
> problem, or is that case supposed to be prevented by some other means?
> At least, this patch prevents the kernel panic during my stress test.

<snipped patches/>

Peter,
I was able to get a repeatable oops at that line copying
files from /boot onto a "fake" scsi_debug disk with "pre5".
The first largish file it attempted to copy caused the
oops (which I sent to Jens).

Anyway, I just applied your 2 patches (to scsi.c and ll_rw_blk.c)
and the oops is no more.

Good work.

Doug Gilbert
