Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272816AbTHPIBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272817AbTHPIBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:01:45 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:4749 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272816AbTHPIBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:01:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Sat, 16 Aug 2003 18:00:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16189.58517.211393.526998@gargle.gargle.HOWL>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
In-Reply-To: message from Mike Fedyk on Friday August 15
References: <3F3951F1.9040605@tupshin.com>
	<20030812142846.46eacc48.akpm@osdl.org>
	<16185.29398.80225.875488@gargle.gargle.HOWL>
	<20030815212707.GR1027@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 15, mfedyk@matchmail.com wrote:
> On Wed, Aug 13, 2003 at 09:05:58AM +1000, Neil Brown wrote:
> > On Tuesday August 12, akpm@osdl.org wrote:
> > > Tupshin Harper <tupshin@tupshin.com> wrote:
> > > >
> > > > raid0_make_request bug: can't convert block across chunks or bigger than 
> > > > 8k 12436792 8

> > 
> > Probably the simplest solution to this is to put in calls to
> > bio_split, which will need to be strengthed to handle multi-page bios.
> > 
> > The policy would be:
> >   "a client of a block device *should* honour the various bio size 
> >    restrictions, and may suffer performance loss if it doesn't;
> >    a block device driver *must* handle any bio it is passed, and may
> >    call bio_split to help out".
> > 
> 
> Any progress on this?

No, and I doubt there will be in a big hurry, unless I come up with an
easy way to make lvm-over-raid0 break instantly instead of eventually.

I think that for now you should assume tat lvm over raid0 (or raid0
over lvm) simply isn't supported.  As lvm (aka dm) supports striping,
it shouldn't be needed.

NeilBrown
