Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274984AbTHPXwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHPXwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:52:50 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6673
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S274984AbTHPXws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:52:48 -0400
Date: Sat, 16 Aug 2003 16:52:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030816235245.GU1027@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL> <20030815212707.GR1027@matchmail.com> <16189.58517.211393.526998@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16189.58517.211393.526998@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 06:00:21PM +1000, Neil Brown wrote:
> On Friday August 15, mfedyk@matchmail.com wrote:
> > On Wed, Aug 13, 2003 at 09:05:58AM +1000, Neil Brown wrote:
> > > On Tuesday August 12, akpm@osdl.org wrote:
> > > > Tupshin Harper <tupshin@tupshin.com> wrote:
> > > > >
> > > > > raid0_make_request bug: can't convert block across chunks or bigger than 
> > > > > 8k 12436792 8
> 
> > > 
> > > Probably the simplest solution to this is to put in calls to
> > > bio_split, which will need to be strengthed to handle multi-page bios.
> > > 
> > > The policy would be:
> > >   "a client of a block device *should* honour the various bio size 
> > >    restrictions, and may suffer performance loss if it doesn't;
> > >    a block device driver *must* handle any bio it is passed, and may
> > >    call bio_split to help out".
> > > 
> > 
> > Any progress on this?
> 
> No, and I doubt there will be in a big hurry, unless I come up with an
> easy way to make lvm-over-raid0 break instantly instead of eventually.
> 
> I think that for now you should assume tat lvm over raid0 (or raid0
> over lvm) simply isn't supported.  As lvm (aka dm) supports striping,
> it shouldn't be needed.

I have a raid5 with "4" 18gb drives, and one of the "drives" is two 9gb
drives in a linear md "array".

I'm guessing this will hit this bug too?

I have a couple systems that use software raid5 that I'll avoid putting
2.6-test on until I know the raid is more reliable (or is this only with
md+lvm?)

