Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRE2VP4>; Tue, 29 May 2001 17:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261965AbRE2VPr>; Tue, 29 May 2001 17:15:47 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:32260 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S261960AbRE2VPd>;
	Tue, 29 May 2001 17:15:33 -0400
Message-ID: <3B14108B.78B02A5C@yahoo.com>
Date: Tue, 29 May 2001 17:11:39 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.org>
CC: linux-kernel list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] panic in scsi_free/sr_scatter_pad
In-Reply-To: <3B133ADC.974A76A@yahoo.com> <20010529121153.I26871@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, May 29 2001, Paul Gortmaker wrote:
> > I think I recall seeing something reported like this on the list(?):
> >
> >   sr: ran out of mem for scatter pad
> >   Kernel panic: scsi_free: bad offset
> 
> Here's a better patch, it also gets the freeing right. It's been fixed
> for long, just haven't been sent to Linus yet. It's in Alan's tree, and
> in fact I think I've send it to this list more than once :)

Ok, essentially same patch - good to see.  Seems old rule of thumb[1] for
linux patches still applies :)   I see you opted for a new var. to store
old use_sg value, rather than make use of SCpnt->old_use_sg like I did.
Was curious as to your reasoning for that - maybe I'm overlooking something.

Other thing that crossed my mind was the appropriateness of scsi_free()
doing a panic.  For this particular case, a BUG() would have been more
informative if we were relying on info in a bug report from Joe Average
to solve the problem. (Also, panic is a bit harsh if say CD is only SCSI
device and everything else is EIDE, but scsi_free has no way of knowing...)

Paul.

[1] Odds are somebody has already posted the patch you just finished...

