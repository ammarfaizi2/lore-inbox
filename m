Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbRBHDSt>; Wed, 7 Feb 2001 22:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBHDSk>; Wed, 7 Feb 2001 22:18:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47626 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129099AbRBHDSb>;
	Wed, 7 Feb 2001 22:18:31 -0500
Date: Thu, 8 Feb 2001 04:18:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt_Domsch@Dell.com
Cc: jason@heymax.com, linux-kernel@vger.kernel.org, gandalf@winds.org
Subject: Re: aacraid 2.4.0 kernel
Message-ID: <20010208041814.I27027@suse.de>
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9CA2@ausxmrr501.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9CA2@ausxmrr501.us.dell.com>; from Matt_Domsch@Dell.com on Wed, Feb 07, 2001 at 09:03:53PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2001, Matt_Domsch@Dell.com wrote:
> Adaptec is still working on it.  Basically (and as Jason discovered), the
> driver and firmware can't handle single I/O requests larger than 64KB.  Even
> when scatter/gathered, if the total is >64KB, it chokes.  This was just fine
> for 2.2.x (no one has ever run into this problem there), but the
> much-improved block layer of 2.4.x throws larger I/Os at the driver.  So,
> the developers at Adaptec are busy trying to add support to break large
> requests into smaller chunks, and then gather them back together.

Poor hardware, even IDE does better than this with scatter gather.
However, that's not why I'm replying. A driver should never have
to deal with bigger requests than it can handle. This just leads
to duplicated code in the block drivers and someone getting it
wrong (in fact, 2.4.1-pre showed bugs in the cpqarray driver
doing this for sg). The block layer is flexible enough to stop
merging beyond the low level drivers limit.

I haven't seen this driver, but if it uses the SCSI layer instead
of being a "pure" block driver then I can see a slight problem
in that currently only understand max sg entry limits and not
total request sizes. I would rather fix this limitation then, and
would also be interested to know if any of the (older) SCSI drivers
have such limitations too.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
