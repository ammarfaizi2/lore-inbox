Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTHOV1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271002AbTHOV1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:27:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47118
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271003AbTHOV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:27:10 -0400
Date: Fri, 15 Aug 2003 14:27:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030815212707.GR1027@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16185.29398.80225.875488@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:05:58AM +1000, Neil Brown wrote:
> On Tuesday August 12, akpm@osdl.org wrote:
> > Tupshin Harper <tupshin@tupshin.com> wrote:
> > >
> > > raid0_make_request bug: can't convert block across chunks or bigger than 
> > > 8k 12436792 8
> > 
> > There is a fix for this at
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1/broken-out/bio-too-big-fix.patch
> > 
> > Results of testing are always appreciated...
> 
> I don't think this will help.  It is a different problem.
> 
> As far as I can tell, the problem is that dm doesn't honour the
> merge_bvec_fn of the underlying device (neither does md for that
> matter).
> I think it does honour the max_sectors restriction, so it will only
> allow a request as big as one chunk, but it will allow such a requests
> to span a chunk boundary.
> 
> Probably the simplest solution to this is to put in calls to
> bio_split, which will need to be strengthed to handle multi-page bios.
> 
> The policy would be:
>   "a client of a block device *should* honour the various bio size 
>    restrictions, and may suffer performance loss if it doesn't;
>    a block device driver *must* handle any bio it is passed, and may
>    call bio_split to help out".
> 

Any progress on this?
