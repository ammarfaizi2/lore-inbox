Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTHQRvB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270453AbTHQRvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:51:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12295
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270452AbTHQRu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:50:57 -0400
Date: Sun, 17 Aug 2003 10:50:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>,
       Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030817175050.GX1027@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Joe Thornber <thornber@sistina.com>, Andrew Morton <akpm@osdl.org>,
	Tupshin Harper <tupshin@tupshin.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL> <20030815212707.GR1027@matchmail.com> <16189.58517.211393.526998@gargle.gargle.HOWL> <20030816235245.GU1027@matchmail.com> <16190.51307.990399.306100@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16190.51307.990399.306100@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 10:12:27AM +1000, Neil Brown wrote:
> On Saturday August 16, mfedyk@matchmail.com wrote:
> > I have a raid5 with "4" 18gb drives, and one of the "drives" is two 9gb
> > drives in a linear md "array".
> > 
> > I'm guessing this will hit this bug too?
> 
> This should be safe.  raid5 only ever submits 1-page (4K) requests
> that are page aligned, and linear arrays will have the boundary
> between drives 4k aligned (actually "chunksize" aligned, and chunksize
> is atleast 4k). 
> 

So why is this hitting with raid0?  Is lvm2 on top of md the problem and md
on lvm2 is ok?

> So raid5 should be safe over everything (unless dm allows striping
> with a chunk size less than pagesize).
> 
> Thinks: as an interim solution of other raid levels - if the
> underlying device has a merge_bvec_function which is being ignored, we
> could set max_sectors to PAGE_SIZE/512.  This should be safe, though
> possibly not optimal (but "safe" is trumps "optimal" any day).

Assuming that sectors are always 512 bytes (true for any hard drive I've
seen) that will be 512 * 8 = one 4k page.

Any chance sector != 512?
