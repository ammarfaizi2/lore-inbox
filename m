Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313851AbSDPTeo>; Tue, 16 Apr 2002 15:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSDPTen>; Tue, 16 Apr 2002 15:34:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31496 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313851AbSDPTem>;
	Tue, 16 Apr 2002 15:34:42 -0400
Date: Tue, 16 Apr 2002 21:33:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: readahead
Message-ID: <20020416193304.GV1097@suse.de>
In-Reply-To: <UTC200204161910.g3GJAx009370.aeb@smtp.cwi.nl> <3CBC7A41.384FD032@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2002, Andrew Morton wrote:
> Andries.Brouwer@cwi.nl wrote:
> > 
> > ...
> >     Do these cards not have a request queue?
> > 
> > The kernel views them as SCSI disks.
> > So yes, I can do
> > 
> >    blockdev --setra 0 /dev/sdc
> > 
> > Unfortunately that does not help in the least.
> > Indeed, the only user of the readahead info is
> > readahead.c: get_max_readahead() and it does
> > 
> >         blk_ra_kbytes = blk_get_readahead(inode->i_dev) / 2;
> >         if (blk_ra_kbytes < VM_MIN_READAHEAD)
> >                 blk_ra_kbytes = VM_MAX_READAHEAD;
> > 
> > We need to distinguish between undefined, and explicily zero.
> 
> Yup.  The below (untested) patch should fix it up.  Assuming
> that all drivers use blk_init_queue(), and heaven knows if
> that's the case.  If not, the readahead window will have to be

set it in blk_queue_make_request(), please.

-- 
Jens Axboe

